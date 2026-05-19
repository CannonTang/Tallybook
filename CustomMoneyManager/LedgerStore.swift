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
    @Published var monthlyBudget: Double
    @Published var expenseCategories: [String]
    @Published var incomeCategories: [String]
    @Published var categoryBudgets: [String: Double]

    private let storageURL: URL

    init() {
        storageURL = Self.makeStorageURL()

        if let state = Self.loadState(from: storageURL) {
            entries = state.entries.sorted { $0.createdAt < $1.createdAt }
            monthlyBudget = state.monthlyBudget
            expenseCategories = state.expenseCategories.isEmpty ? Self.defaultExpenseCategories : state.expenseCategories
            incomeCategories = state.incomeCategories.isEmpty ? Self.defaultIncomeCategories : state.incomeCategories
            categoryBudgets = state.categoryBudgets
        } else {
            entries = []
            monthlyBudget = 0
            expenseCategories = Self.defaultExpenseCategories
            incomeCategories = Self.defaultIncomeCategories
            categoryBudgets = [:]
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

    func updateMonthlyBudget(_ value: Double) {
        monthlyBudget = max(0, value)
        save()
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
            categoryBudgets.removeValue(forKey: name)
        case .income:
            incomeCategories.removeAll { $0 == name }
            categoryBudgets.removeValue(forKey: name)
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
        if let budget = categoryBudgets.removeValue(forKey: oldName) {
            categoryBudgets[trimmed] = budget
        }
        save()
    }

    func setCategoryBudget(category: String, amount: Double) {
        let clamped = max(0, amount)
        if clamped > 0 {
            categoryBudgets[category] = clamped
        } else {
            categoryBudgets.removeValue(forKey: category)
        }
        save()
    }

    func categorySpending(category: String, in month: Date) -> Double {
        entries(in: month)
            .filter { $0.category == category && $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)
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
            monthlyBudget: monthlyBudget,
            expenseCategories: expenseCategories,
            incomeCategories: incomeCategories,
            categoryBudgets: categoryBudgets
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
    var monthlyBudget: Double
    var expenseCategories: [String]
    var incomeCategories: [String]
    var categoryBudgets: [String: Double]
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
