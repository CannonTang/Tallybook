//
//  LedgerStore.swift
//  CustomMoneyManager
//
//  Created by windbylocus on 2026/5/18.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class LedgerStore: ObservableObject {
    @Published var entries: [LedgerEntry]
    @Published var budgetPlans: [BudgetPlan]
    @Published var expenseCategories: [String]
    @Published var incomeCategories: [String]

    private let storageURL: URL

    init() {
        storageURL = Self.makeStorageURL()

        if let state = Self.loadState(from: storageURL) {
            entries = state.entries.sorted { $0.createdAt < $1.createdAt }
            budgetPlans = Self.migrateBudgetPlans(from: state)
            expenseCategories = state.expenseCategories.isEmpty ? Self.defaultExpenseCategories : state.expenseCategories
            incomeCategories = state.incomeCategories.isEmpty ? Self.defaultIncomeCategories : state.incomeCategories
        } else {
            entries = []
            budgetPlans = [.defaultPlan()]
            expenseCategories = Self.defaultExpenseCategories
            incomeCategories = Self.defaultIncomeCategories
            save()
        }
    }

    func entries(in month: Date) -> [LedgerEntry] {
        let calendar = Calendar.current
        return entries
            .filter { calendar.isDate($0.date, equalTo: month, toGranularity: .month) }
            .sorted { $0.date < $1.date || ($0.date == $1.date && $0.createdAt < $1.createdAt) }
    }

    func entries(on date: Date) -> [LedgerEntry] {
        let calendar = Calendar.current
        return entries
            .filter { calendar.isDate($0.date, inSameDayAs: date) }
            .sorted { $0.createdAt > $1.createdAt }
    }

    func totalExpense(in month: Date) -> Double {
        entries(in: month)
            .filter { $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)
    }

    func totalIncome(in month: Date) -> Double {
        entries(in: month)
            .filter { $0.kind == .income }
            .map(\.amount)
            .reduce(0, +)
    }

    func entries(from startDate: Date, to endDate: Date) -> [LedgerEntry] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let endExclusive = calendar.date(byAdding: .day, value: 1, to: end) ?? end

        return entries
            .filter { $0.date >= start && $0.date < endExclusive }
            .sorted { $0.date < $1.date || ($0.date == $1.date && $0.createdAt < $1.createdAt) }
    }

    func totalExpense(from startDate: Date, to endDate: Date) -> Double {
        entries(from: startDate, to: endDate)
            .filter { $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)
    }

    func activeDays(from startDate: Date, to endDate: Date) -> Int {
        Set(entries(from: startDate, to: endDate).map { Calendar.current.startOfDay(for: $0.date) }).count
    }

    func expenseCount(in month: Date) -> Int {
        entries(in: month).filter { $0.kind == .expense }.count
    }

    func incomeCount(in month: Date) -> Int {
        entries(in: month).filter { $0.kind == .income }.count
    }

    func activeDays(in month: Date) -> Int {
        Set(entries(in: month).map { Calendar.current.startOfDay(for: $0.date) }).count
    }

    func entries(on date: Date, kind: TransactionKind? = nil) -> [LedgerEntry] {
        let filtered = entries(on: date)
        guard let kind else { return filtered }
        return filtered.filter { $0.kind == kind }
    }

    func addEntry(date: Date, kind: TransactionKind, category: String, amount: Double, note: String) {
        let entry = LedgerEntry(
            id: UUID(),
            date: date.startOfDay,
            createdAt: Date(),
            kind: kind,
            category: category,
            amount: amount,
            note: note.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        entries.append(entry)
        entries.sort { $0.createdAt < $1.createdAt }
        save()
    }

    func updateEntry(id: UUID, kind: TransactionKind, category: String, amount: Double, note: String) {
        guard let index = entries.firstIndex(where: { $0.id == id }) else {
            return
        }

        entries[index].kind = kind
        entries[index].category = category
        entries[index].amount = amount
        entries[index].note = note.trimmingCharacters(in: .whitespacesAndNewlines)
        save()
    }

    func deleteEntry(id: UUID) {
        entries.removeAll { $0.id == id }
        save()
    }

    func deleteEntries(from startDate: Date, to endDate: Date) {
        let start = startDate.startOfDay
        let end = endDate.startOfDay
        entries.removeAll { entry in
            entry.date >= start && entry.date < end
        }
        save()
    }

    func deleteAllEntries() {
        entries.removeAll()
        save()
    }

    func addBudgetPlan(amount: Double, startDate: Date, endDate: Date) -> BudgetValidationError? {
        let plan = BudgetPlan(amount: amount, startDate: startDate, endDate: endDate)
        if let error = validateBudgetPlan(plan) {
            return error
        }

        budgetPlans.append(plan)
        sortBudgetPlans()
        save()
        return nil
    }

    func updateBudgetPlan(id: UUID, amount: Double, startDate: Date, endDate: Date) -> BudgetValidationError? {
        guard let index = budgetPlans.firstIndex(where: { $0.id == id }) else {
            return .notFound
        }

        let plan = BudgetPlan(id: id, amount: amount, startDate: startDate, endDate: endDate)
        if let error = validateBudgetPlan(plan, ignoring: id) {
            return error
        }

        budgetPlans[index] = plan
        sortBudgetPlans()
        save()
        return nil
    }

    func deleteBudgetPlan(id: UUID) {
        budgetPlans.removeAll { $0.id == id }
        save()
    }

    func budgetPlan(containing date: Date) -> BudgetPlan? {
        let day = Calendar.current.startOfDay(for: date)
        return budgetPlans.first { $0.startDate <= day && $0.endDate >= day }
    }

    func budgetMetrics(for plan: BudgetPlan, referenceDate: Date = Date()) -> BudgetMetrics {
        BudgetMetrics(
            plan: plan,
            spent: totalExpense(from: plan.startDate, to: plan.endDate),
            activeDays: activeDays(from: plan.startDate, to: plan.endDate),
            referenceDate: referenceDate
        )
    }

    func currentBudgetMetrics(referenceDate: Date = Date()) -> BudgetMetrics? {
        guard let plan = budgetPlan(containing: referenceDate) else {
            return nil
        }

        return budgetMetrics(for: plan, referenceDate: referenceDate)
    }

    func totalBudgetAllocation(from startDate: Date, to endDate: Date) -> Double {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)

        return budgetPlans.reduce(0) { total, plan in
            let overlapStart = max(start, plan.startDate)
            let overlapEnd = min(end, plan.endDate)

            guard overlapStart <= overlapEnd, plan.dayCount > 0 else {
                return total
            }

            let overlapDays = BudgetPlan.daysInclusive(from: overlapStart, to: overlapEnd, calendar: calendar)
            return total + plan.averageDailyBudget * Double(overlapDays)
        }
    }

    func validateBudgetPlan(_ plan: BudgetPlan, ignoring ignoredID: UUID? = nil) -> BudgetValidationError? {
        if budgetPlans.contains(where: { existing in
            existing.id != ignoredID && existing.overlaps(plan)
        }) {
            return .overlapsExisting
        }

        return nil
    }

    func addCategory(_ name: String, kind: TransactionKind) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        switch kind {
        case .expense:
            guard !expenseCategories.contains(trimmed) else { return }
            expenseCategories.append(trimmed)
        case .income:
            guard !incomeCategories.contains(trimmed) else { return }
            incomeCategories.append(trimmed)
        }
        save()
    }

    func removeCategory(_ name: String, kind: TransactionKind) {
        switch kind {
        case .expense:
            expenseCategories.removeAll { $0 == name }
        case .income:
            incomeCategories.removeAll { $0 == name }
        }
        for i in entries.indices where entries[i].category == name && entries[i].kind == kind {
            entries[i].category = "其他"
        }
        save()
    }

    func renameCategory(from oldName: String, to newName: String, kind: TransactionKind) {
        let trimmed = newName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed != oldName else { return }
        switch kind {
        case .expense:
            guard let idx = expenseCategories.firstIndex(of: oldName) else { return }
            expenseCategories[idx] = trimmed
        case .income:
            guard let idx = incomeCategories.firstIndex(of: oldName) else { return }
            incomeCategories[idx] = trimmed
        }
        for i in entries.indices where entries[i].category == oldName && entries[i].kind == kind {
            entries[i].category = trimmed
        }
        save()
    }

    func categories(for kind: TransactionKind) -> [String] {
        kind == .expense ? expenseCategories : incomeCategories
    }

    func defaultCategory(for kind: TransactionKind) -> String {
        categories(for: kind).first ?? ""
    }

    private func save() {
        let state = LedgerState(
            entries: entries,
            monthlyBudget: budgetPlans.first?.amount ?? 0,
            budgetPlan: budgetPlans.first,
            budgetPlans: budgetPlans,
            expenseCategories: expenseCategories,
            incomeCategories: incomeCategories
        )

        do {
            let folder = storageURL.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
            let data = try Self.encoder.encode(state)
            try data.write(to: storageURL, options: [.atomic])
        } catch {
            // Keep the app usable even when persistence fails.
        }
    }

    private static func loadState(from url: URL) -> LedgerState? {
        guard FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(LedgerState.self, from: data)
        } catch {
            return nil
        }
    }

    private static func makeStorageURL() -> URL {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.temporaryDirectory
        let bundleID = Bundle.main.bundleIdentifier ?? "CustomMoneyManager"
        return base
            .appendingPathComponent(bundleID, isDirectory: true)
            .appendingPathComponent("ledger-state.json")
    }

    private func sortBudgetPlans() {
        budgetPlans.sort { $0.startDate < $1.startDate }
    }

    private static func migrateBudgetPlans(from state: LedgerState) -> [BudgetPlan] {
        if let plans = state.budgetPlans, !plans.isEmpty {
            return sanitizedBudgetPlans(plans)
        }

        if let plan = state.budgetPlan {
            return [plan]
        }

        return [BudgetPlan.defaultPlan(amount: state.monthlyBudget ?? 0)]
    }

    private static func sanitizedBudgetPlans(_ plans: [BudgetPlan]) -> [BudgetPlan] {
        plans
            .sorted { $0.startDate < $1.startDate }
            .reduce(into: [BudgetPlan]()) { result, plan in
                guard !result.contains(where: { $0.overlaps(plan) }) else {
                    return
                }

                result.append(plan)
            }
    }

    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }()

    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()

    private static let defaultExpenseCategories = [
        "餐饮", "早餐", "交通", "购物", "房租", "咖啡", "旅行", "水果",
        "数码配件", "水电", "娱乐", "药品", "停车", "服饰", "家居",
        "零食", "快递", "运动", "学习", "宠物", "理发", "晚餐", "其他"
    ]

    private static let defaultIncomeCategories = [
        "工资", "奖金", "报销", "红包", "副业", "其他"
    ]

}

struct LedgerState: Codable {
    var entries: [LedgerEntry]
    var monthlyBudget: Double?
    var budgetPlan: BudgetPlan?
    var budgetPlans: [BudgetPlan]?
    var expenseCategories: [String]
    var incomeCategories: [String]
    var categoryBudgets: [String: Double]?
}

struct BudgetPlan: Identifiable, Codable, Equatable {
    var id: UUID
    var amount: Double
    var startDate: Date
    var endDate: Date

    init(id: UUID = UUID(), amount: Double, startDate: Date, endDate: Date, calendar: Calendar = .current) {
        let start = calendar.startOfDay(for: startDate)
        let requestedEnd = calendar.startOfDay(for: endDate)
        let minimumEnd = calendar.date(byAdding: .day, value: 1, to: start) ?? start

        self.id = id
        self.amount = max(0, amount)
        self.startDate = start
        self.endDate = requestedEnd < minimumEnd ? minimumEnd : requestedEnd
    }

    var dayCount: Int {
        BudgetPlan.daysInclusive(from: startDate, to: endDate)
    }

    var averageDailyBudget: Double {
        dayCount > 0 ? amount / Double(dayCount) : 0
    }

    static func defaultPlan(amount: Double = 0, referenceDate: Date = Date(), calendar: Calendar = .current) -> BudgetPlan {
        let components = calendar.dateComponents([.year, .month], from: referenceDate)
        let start = calendar.date(from: components) ?? calendar.startOfDay(for: referenceDate)
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: start) ?? start
        let end = calendar.date(byAdding: .day, value: -1, to: nextMonth) ?? start
        return BudgetPlan(amount: amount, startDate: start, endDate: end, calendar: calendar)
    }

    static func daysInclusive(from startDate: Date, to endDate: Date, calendar: Calendar = .current) -> Int {
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let days = calendar.dateComponents([.day], from: start, to: end).day ?? 0
        return max(1, days + 1)
    }

    func overlaps(_ other: BudgetPlan) -> Bool {
        startDate <= other.endDate && other.startDate <= endDate
    }
}

enum BudgetValidationError: LocalizedError, Equatable {
    case notFound
    case overlapsExisting

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "预算不存在。"
        case .overlapsExisting:
            return "预算日期不能与已有预算重叠。"
        }
    }
}

struct BudgetMetrics {
    let plan: BudgetPlan
    let spent: Double
    let activeDays: Int
    let dayCount: Int
    let elapsedDays: Int
    let remainingDays: Int
    let remaining: Double
    let averageDailyBudget: Double
    let suggestedDailyBudget: Double
    let progress: Double

    init(plan: BudgetPlan, spent: Double, activeDays: Int, referenceDate: Date, calendar: Calendar = .current) {
        let today = calendar.startOfDay(for: referenceDate)
        let dayCount = plan.dayCount
        let elapsedDays: Int
        let remainingDays: Int

        if today < plan.startDate {
            elapsedDays = 0
            remainingDays = dayCount
        } else if today > plan.endDate {
            elapsedDays = dayCount
            remainingDays = 0
        } else {
            elapsedDays = BudgetPlan.daysInclusive(from: plan.startDate, to: today, calendar: calendar)
            remainingDays = BudgetPlan.daysInclusive(from: today, to: plan.endDate, calendar: calendar)
        }

        let remaining = plan.amount - spent

        self.plan = plan
        self.spent = spent
        self.activeDays = activeDays
        self.dayCount = dayCount
        self.elapsedDays = elapsedDays
        self.remainingDays = remainingDays
        self.remaining = remaining
        self.averageDailyBudget = dayCount > 0 ? plan.amount / Double(dayCount) : 0
        self.suggestedDailyBudget = remainingDays > 0 ? max(0, remaining) / Double(remainingDays) : 0
        self.progress = plan.amount > 0 ? min(max(spent / plan.amount, 0), 1) : (spent > 0 ? 1 : 0)
    }
}

struct LedgerEntry: Identifiable, Codable {
    var id: UUID
    var date: Date
    var createdAt: Date
    var kind: TransactionKind
    var category: String
    var amount: Double
    var note: String
}

enum TransactionKind: String, Codable, CaseIterable, Identifiable {
    case expense
    case income

    var id: String { rawValue }

    var title: String {
        switch self {
        case .expense: return "支出"
        case .income: return "收入"
        }
    }

    var symbol: String {
        switch self {
        case .expense: return "arrow.up.right"
        case .income: return "arrow.down.left"
        }
    }

    var tint: Color {
        switch self {
        case .expense: return .orange
        case .income: return .green
        }
    }
}

private extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
