//
//  ContentView.swift
//  CustomMoneyManager
//
//  Created by windbylocus on 2026/5/18.
//

import AppKit
import Combine
import SwiftUI
import Charts

private enum AppLanguage: String, CaseIterable, Identifiable {
    case chinese
    case english

    var id: String { rawValue }

    func displayName(in language: AppLanguage) -> String {
        switch (language, self) {
        case (.chinese, .chinese): return "中文"
        case (.chinese, .english): return "英文"
        case (.english, .chinese): return "Chinese"
        case (.english, .english): return "English"
        }
    }

    var locale: Locale {
        switch self {
        case .chinese: return Locale(identifier: "zh_Hans_CN")
        case .english: return Locale(identifier: "en_US")
        }
    }

    func text(_ key: AppText) -> String {
        switch (self, key) {
        case (.chinese, .ledgerSection): return "账本"
        case (.english, .ledgerSection): return "Ledger"
        case (.chinese, .analysisSection): return "分析"
        case (.english, .analysisSection): return "Analysis"
        case (.chinese, .settingsSection): return "设置"
        case (.english, .settingsSection): return "Settings"
        case (.chinese, .calendarLedger): return "日历账本"
        case (.english, .calendarLedger): return "Calendar"
        case (.chinese, .transactions): return "交易明细"
        case (.english, .transactions): return "Transactions"
        case (.chinese, .reports): return "报表"
        case (.english, .reports): return "Reports"
        case (.chinese, .categoryManagement): return "分类管理"
        case (.english, .categoryManagement): return "Categories"
        case (.chinese, .settings): return "设置"
        case (.english, .settings): return "Settings"
        case (.chinese, .language): return "语言"
        case (.english, .language): return "Language"
        case (.chinese, .languageSubtitle): return "选择应用界面语言。"
        case (.english, .languageSubtitle): return "Choose the app interface language."
        case (.chinese, .month): return "月"
        case (.english, .month): return "Month"
        case (.chinese, .previousMonth): return "上个月"
        case (.english, .previousMonth): return "Previous month"
        case (.chinese, .nextMonth): return "下个月"
        case (.english, .nextMonth): return "Next month"
        case (.chinese, .today): return "今天"
        case (.english, .today): return "Today"
        case (.chinese, .backToToday): return "回到今天"
        case (.english, .backToToday): return "Back to today"
        case (.chinese, .emptyMonth): return "本月暂无记录，选择日期开始记账。"
        case (.english, .emptyMonth): return "No records this month. Choose a date to start."
        case (.chinese, .records): return "笔记录"
        case (.english, .records): return "records"
        case (.chinese, .activeDays): return "活跃"
        case (.english, .activeDays): return "active"
        case (.chinese, .days): return "天"
        case (.english, .days): return "days"
        case (.chinese, .monthlyExpense): return "本月支出"
        case (.english, .monthlyExpense): return "Monthly expense"
        case (.chinese, .income): return "收入"
        case (.english, .income): return "Income"
        case (.chinese, .expense): return "支出"
        case (.english, .expense): return "Expense"
        case (.chinese, .selectedDayExpense): return "当天支出"
        case (.english, .selectedDayExpense): return "Day expense"
        case (.chinese, .entriesUnit): return "笔"
        case (.english, .entriesUnit): return "items"
        case (.chinese, .quickEntry): return "快速记账"
        case (.english, .quickEntry): return "Quick Entry"
        case (.chinese, .type): return "类型"
        case (.english, .type): return "Type"
        case (.chinese, .category): return "分类"
        case (.english, .category): return "Category"
        case (.chinese, .amountPlaceholder): return "金额，例如 86"
        case (.english, .amountPlaceholder): return "Amount, e.g. 86"
        case (.chinese, .note): return "备注"
        case (.english, .note): return "Note"
        case (.chinese, .save): return "保存"
        case (.english, .save): return "Save"
        case (.chinese, .dayDetails): return "当天明细"
        case (.english, .dayDetails): return "Day Details"
        case (.chinese, .emptyDay): return "当天暂无账单"
        case (.english, .emptyDay): return "No records for this day"
        case (.chinese, .emptyDayHint): return "填写金额后保存，会立即出现在左侧日期格里。"
        case (.english, .emptyDayHint): return "Enter an amount and save; it will appear on the calendar."
        case (.chinese, .invalidAmount): return "金额格式不对，输入一个大于 0 的数字。"
        case (.english, .invalidAmount): return "Invalid amount. Enter a number greater than 0."
        case (.chinese, .noRecords): return "无记录"
        case (.english, .noRecords): return "No records"
        case (.chinese, .transactionsSubtitle): return "这里和日历账本使用同一套账单数据。"
        case (.english, .transactionsSubtitle): return "Uses the same ledger data as the calendar."
        case (.chinese, .newTransaction): return "新增交易"
        case (.english, .newTransaction): return "New transaction"
        case (.chinese, .filter): return "筛选"
        case (.english, .filter): return "Filter"
        case (.chinese, .searchCategoryOrNote): return "搜索分类或备注"
        case (.english, .searchCategoryOrNote): return "Search category or note"
        case (.chinese, .emptyTransactions): return "暂无交易记录"
        case (.english, .emptyTransactions): return "No transactions yet"
        case (.chinese, .budgetSubtitle): return "管理多个互不重叠的预算周期。"
        case (.english, .budgetSubtitle): return "Manage multiple non-overlapping budget periods."
        case (.chinese, .monthlyBudget): return "周期总预算"
        case (.english, .monthlyBudget): return "Period budget"
        case (.chinese, .used): return "已用"
        case (.english, .used): return "Used"
        case (.chinese, .remaining): return "剩余"
        case (.english, .remaining): return "Remaining"
        case (.chinese, .startDate): return "开始日期"
        case (.english, .startDate): return "Start date"
        case (.chinese, .endDate): return "结束日期"
        case (.english, .endDate): return "End date"
        case (.chinese, .totalBudgetDays): return "周期天数"
        case (.english, .totalBudgetDays): return "Total days"
        case (.chinese, .elapsedDays): return "已过天数"
        case (.english, .elapsedDays): return "Elapsed days"
        case (.chinese, .remainingDays): return "剩余天数"
        case (.english, .remainingDays): return "Days left"
        case (.chinese, .averageDailyBudget): return "平均每日预算"
        case (.english, .averageDailyBudget): return "Average daily budget"
        case (.chinese, .dailyBudgetSuggestion): return "剩余每日建议"
        case (.english, .dailyBudgetSuggestion): return "Daily suggestion"
        case (.chinese, .budgetPlanList): return "预算周期"
        case (.english, .budgetPlanList): return "Budget periods"
        case (.chinese, .manageBudgets): return "管理预算"
        case (.english, .manageBudgets): return "Manage budgets"
        case (.chinese, .addBudgetPlan): return "添加预算"
        case (.english, .addBudgetPlan): return "Add budget"
        case (.chinese, .editBudgetPlan): return "编辑预算"
        case (.english, .editBudgetPlan): return "Edit budget"
        case (.chinese, .emptyBudgetPlans): return "暂无当前预算，添加一个日期周期开始跟踪。"
        case (.english, .emptyBudgetPlans): return "No current budget. Add a date period to start tracking."
        case (.chinese, .budgetOverlapError): return "预算日期不能与已有预算重叠。"
        case (.english, .budgetOverlapError): return "Budget dates cannot overlap existing periods."
        case (.chinese, .budgetAmount): return "预算金额"
        case (.english, .budgetAmount): return "Budget amount"
        case (.chinese, .cancel): return "取消"
        case (.english, .cancel): return "Cancel"
        case (.chinese, .reportsSubtitle): return "收支趋势与分类分布概览。"
        case (.english, .reportsSubtitle): return "Overview of income, expense, and category distribution."
        case (.chinese, .period): return "周期"
        case (.english, .period): return "Period"
        case (.chinese, .threeMonths): return "3 个月"
        case (.english, .threeMonths): return "3 months"
        case (.chinese, .sixMonths): return "6 个月"
        case (.english, .sixMonths): return "6 months"
        case (.chinese, .twelveMonths): return "12 个月"
        case (.english, .twelveMonths): return "12 months"
        case (.chinese, .monthlyIncomeExpense): return "月度收支"
        case (.english, .monthlyIncomeExpense): return "Monthly income and expense"
        case (.chinese, .monthAxis): return "月份"
        case (.english, .monthAxis): return "Month"
        case (.chinese, .amount): return "金额"
        case (.english, .amount): return "Amount"
        case (.chinese, .noData): return "暂无数据"
        case (.english, .noData): return "No data"
        case (.chinese, .thisMonthExpenseByCategory): return "本月支出分类"
        case (.english, .thisMonthExpenseByCategory): return "This month's expenses by category"
        case (.chinese, .noExpenseThisMonth): return "本月暂无支出"
        case (.english, .noExpenseThisMonth): return "No expenses this month"
        case (.chinese, .edit): return "编辑"
        case (.english, .edit): return "Edit"
        case (.chinese, .delete): return "删除"
        case (.english, .delete): return "Delete"
        case (.chinese, .editEntry): return "编辑账单"
        case (.english, .editEntry): return "Edit entry"
        case (.chinese, .categoryManagementSubtitle): return "管理支出和收入的分类，删除分类会将关联账单移至「其他」。"
        case (.english, .categoryManagementSubtitle): return "Manage expense and income categories. Deleted categories move related entries to Other."
        case (.chinese, .emptyCategories): return "暂无分类"
        case (.english, .emptyCategories): return "No categories yet"
        case (.chinese, .newCategoryName): return "新分类名称"
        case (.english, .newCategoryName): return "New category name"
        case (.chinese, .add): return "添加"
        case (.english, .add): return "Add"
        case (.chinese, .entryCount): return "笔账单"
        case (.english, .entryCount): return "entries"
        case (.chinese, .deleteCategory): return "删除分类"
        case (.english, .deleteCategory): return "Delete category"
        case (.chinese, .deleteAllData): return "删除全部数据"
        case (.english, .deleteAllData): return "Delete all data"
        case (.chinese, .dataManagement): return "数据管理"
        case (.english, .dataManagement): return "Data management"
        case (.chinese, .deleteAllDataHint): return "清空全部账单记录，保留语言、分类和预算设置。"
        case (.english, .deleteAllDataHint): return "Clear all entries while keeping language, categories, and budget settings."
        case (.chinese, .confirmDeleteAllTitle): return "删除全部数据？"
        case (.english, .confirmDeleteAllTitle): return "Delete all data?"
        case (.chinese, .confirmDeleteAllMessage): return "此操作会删除所有账单记录，且无法撤销。"
        case (.english, .confirmDeleteAllMessage): return "This will delete every entry and cannot be undone."
        case (.chinese, .noCategoriesHint): return "当前没有分类，请先到「分类管理」添加分类。"
        case (.english, .noCategoriesHint): return "No categories yet. Add one in Categories."
        case (.chinese, .noCategoriesAvailable): return "暂无可选分类"
        case (.english, .noCategoriesAvailable): return "No categories available"
        }
    }
}

private enum AppText {
    case ledgerSection, analysisSection, settingsSection
    case calendarLedger, transactions, reports, categoryManagement, settings
    case language, languageSubtitle
    case month, previousMonth, nextMonth, today, backToToday
    case emptyMonth, records, activeDays, days, monthlyExpense
    case income, expense, selectedDayExpense, entriesUnit
    case quickEntry, type, category, amountPlaceholder, note, save, dayDetails
    case emptyDay, emptyDayHint, invalidAmount, noRecords
    case transactionsSubtitle, newTransaction, filter, searchCategoryOrNote, emptyTransactions
    case budgetSubtitle, monthlyBudget, used, remaining
    case startDate, endDate, totalBudgetDays, elapsedDays, remainingDays
    case averageDailyBudget, dailyBudgetSuggestion
    case budgetPlanList, manageBudgets, addBudgetPlan, editBudgetPlan, emptyBudgetPlans, budgetOverlapError
    case budgetAmount, cancel
    case reportsSubtitle, period, threeMonths, sixMonths, twelveMonths
    case monthlyIncomeExpense, monthAxis, amount, noData, thisMonthExpenseByCategory, noExpenseThisMonth
    case edit, delete, editEntry, categoryManagementSubtitle, emptyCategories, newCategoryName
    case add, entryCount, deleteCategory
    case deleteAllData, dataManagement, deleteAllDataHint
    case confirmDeleteAllTitle, confirmDeleteAllMessage
    case noCategoriesHint, noCategoriesAvailable
}

private struct AppLanguageKey: EnvironmentKey {
    static let defaultValue: AppLanguage = .chinese
}

private extension EnvironmentValues {
    var appLanguage: AppLanguage {
        get { self[AppLanguageKey.self] }
        set { self[AppLanguageKey.self] = newValue }
    }
}

private extension TransactionKind {
    func title(_ language: AppLanguage) -> String {
        switch language {
        case .chinese:
            return title
        case .english:
            switch self {
            case .expense: return "Expense"
            case .income: return "Income"
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var store = LedgerStore()
    @StateObject private var windowActivity = WindowActivityObserver()
    @State private var selection: SidebarSection? = .calendar
    @AppStorage("appLanguage") private var appLanguageRaw = AppLanguage.chinese.rawValue

    private var language: AppLanguage {
        AppLanguage(rawValue: appLanguageRaw) ?? .chinese
    }

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section(language.text(.ledgerSection)) {
                    ForEach(SidebarSection.primary) { item in
                        Label(item.title(language), systemImage: item.systemImage)
                            .tag(item)
                    }
                }

                Section(language.text(.analysisSection)) {
                    ForEach(SidebarSection.secondary) { item in
                        Label(item.title(language), systemImage: item.systemImage)
                            .tag(item)
                    }
                }

                Section(language.text(.settingsSection)) {
                    ForEach(SidebarSection.settings) { item in
                        Label(item.title(language), systemImage: item.systemImage)
                            .tag(item)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(min: 190, ideal: 230)
        } detail: {
            DetailHost(selection: selection ?? .calendar)
        }
        .environmentObject(store)
        .environment(\.appLanguage, language)
        .environment(\.isWindowActive, windowActivity.isActive)
        .navigationSplitViewStyle(.balanced)
    }
}

@MainActor
private final class WindowActivityObserver: ObservableObject {
    @Published var isActive = NSApp.isActive

    private var observers: [NSObjectProtocol] = []

    init(center: NotificationCenter = .default) {
        observers = [
            center.addObserver(forName: NSApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
                MainActor.assumeIsolated {
                    self?.isActive = true
                }
            },
            center.addObserver(forName: NSApplication.didResignActiveNotification, object: nil, queue: .main) { [weak self] _ in
                MainActor.assumeIsolated {
                    self?.isActive = false
                }
            }
        ]
    }

    deinit {
        let center = NotificationCenter.default
        observers.forEach { center.removeObserver($0) }
    }
}

private struct WindowActiveKey: EnvironmentKey {
    static let defaultValue = true
}

private extension EnvironmentValues {
    var isWindowActive: Bool {
        get { self[WindowActiveKey.self] }
        set { self[WindowActiveKey.self] = newValue }
    }
}

private struct DetailHost: View {
    @Environment(\.isWindowActive) private var isWindowActive
    let selection: SidebarSection

    var body: some View {
        Group {
            switch selection {
            case .calendar:
                CalendarLedgerPage()
            case .transactions:
                TransactionsPage()
            case .reports:
                ReportsPage()
            case .categories:
                CategoriesManagementPage()
            case .preferences:
                SettingsPage()
            }
        }
        .transition(.opacity.combined(with: .scale(scale: 0.98)))
        .animation(isWindowActive ? .easeOut(duration: 0.2) : nil, value: selection)
    }
}

private enum SidebarSection: String, CaseIterable, Identifiable {
    case calendar
    case transactions
    case reports
    case categories
    case preferences

    static let primary: [SidebarSection] = [.calendar, .transactions]
    static let secondary: [SidebarSection] = [.reports]
    static let settings: [SidebarSection] = [.categories, .preferences]

    var id: String { rawValue }

    func title(_ language: AppLanguage) -> String {
        switch self {
        case .calendar: return language.text(.calendarLedger)
        case .transactions: return language.text(.transactions)
        case .reports: return language.text(.reports)
        case .categories: return language.text(.categoryManagement)
        case .preferences: return language.text(.settings)
        }
    }

    var systemImage: String {
        switch self {
        case .calendar: return "calendar"
        case .transactions: return "list.bullet.rectangle"
        case .reports: return "chart.bar"
        case .categories: return "tag"
        case .preferences: return "gearshape"
        }
    }
}

// MARK: - Shared Effects

private enum ShadowLevel {
    case card
    case panel
    case sheet

    var yOffset: CGFloat {
        switch self {
        case .card: return 4
        case .panel: return 8
        case .sheet: return 12
        }
    }

    var radius: CGFloat {
        switch self {
        case .card: return 10
        case .panel: return 18
        case .sheet: return 30
        }
    }

    var opacity: Double {
        switch self {
        case .card: return 0.06
        case .panel: return 0.08
        case .sheet: return 0.12
        }
    }
}

private struct HoverLift: ViewModifier {
    @Environment(\.isWindowActive) private var isWindowActive
    @State private var isHovering = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isWindowActive && isHovering ? 1.02 : 1.0)
            .offset(y: isWindowActive && isHovering ? -2 : 0)
            .animation(isWindowActive ? .easeOut(duration: 0.2) : nil, value: isHovering)
            .onHover { isHovering = isWindowActive && $0 }
            .onChange(of: isWindowActive) { _, active in
                if !active {
                    isHovering = false
                }
            }
    }
}

private struct AnimatedProgressBar: View {
    @Environment(\.isWindowActive) private var isWindowActive
    let ratio: Double
    let tint: Color
    @State private var animatedRatio: Double = 0

    private var displayedRatio: Double {
        isWindowActive ? animatedRatio : ratio
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(tint.opacity(0.15))
                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * displayedRatio)
            }
        }
        .frame(height: 6)
        .onAppear {
            guard isWindowActive else {
                animatedRatio = ratio
                return
            }

            withAnimation(.easeOut(duration: 0.8)) {
                animatedRatio = ratio
            }
        }
        .onChange(of: ratio) { _, newValue in
            guard isWindowActive else {
                animatedRatio = newValue
                return
            }

            withAnimation(.easeOut(duration: 0.5)) {
                animatedRatio = newValue
            }
        }
        .onChange(of: isWindowActive) { _, active in
            if !active {
                animatedRatio = ratio
            }
        }
    }
}

// MARK: - Calendar Ledger Page

private struct CalendarLedgerPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @Environment(\.isWindowActive) private var isWindowActive
    @State private var displayedMonth = Date().startOfMonth
    @State private var selectedDate = Date().startOfDay
    @State private var selectedKind: TransactionKind = .expense
    @State private var selectedCategory = "餐饮"
    @State private var amountText = ""
    @State private var noteText = ""
    @State private var contentWidth: CGFloat = 1200
    @State private var pageDirection = 1
    @State private var pageToken = 0
    @State private var snapshot = CalendarLedgerSnapshot.empty
    @State private var showingBudgetManager = false

    private let calendar = Calendar.current

    private var selectedBudgetMetrics: BudgetMetrics? {
        if let selectedPlan = store.budgetPlan(containing: selectedDate) {
            return store.budgetMetrics(for: selectedPlan, referenceDate: selectedDate)
        }

        return store.currentBudgetMetrics()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                CalendarHeader(
                    displayedMonth: displayedMonth,
                    entryCount: snapshot.monthEntryCount,
                    activeDays: snapshot.activeDays,
                    monthExpense: snapshot.monthExpense,
                    onPrevious: { movePeriod(by: -1) },
                    onNext: { movePeriod(by: 1) },
                    onToday: {
                        let nextMonth = Date().startOfMonth
                        let nextDate = Date().startOfDay
                        guard !calendar.isDate(selectedDate, inSameDayAs: nextDate) else {
                            return
                        }
                        pageDirection = calendar.compare(nextDate, to: selectedDate, toGranularity: .day) == .orderedAscending ? -1 : 1
                        updateCalendarState(animated: isWindowActive) {
                            displayedMonth = nextMonth
                            selectedDate = nextDate
                            refreshSnapshot(displayedMonth: nextMonth, selectedDate: nextDate)
                            pageToken += 1
                        }
                    }
                )

                BudgetStatusCard(
                    metrics: selectedBudgetMetrics,
                    planCount: store.budgetPlans.count,
                    onManage: { showingBudgetManager = true }
                )

                calendarContent(snapshot: snapshot, isWide: contentWidth >= 940)
            }
            .frame(maxWidth: 1560, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(key: CalendarContentWidthKey.self, value: proxy.size.width)
                }
            )
        }
        .background(AppBackground())
        .onPreferenceChange(CalendarContentWidthKey.self) { contentWidth = $0 }
        .onAppear {
            selectedCategory = store.defaultCategory(for: selectedKind)
            refreshSnapshot(displayedMonth: displayedMonth, selectedDate: selectedDate)
        }
        .onReceive(store.$entries) { _ in
            refreshSnapshot(displayedMonth: displayedMonth, selectedDate: selectedDate)
        }
        .onReceive(store.$budgetPlans) { _ in
            refreshSnapshot(displayedMonth: displayedMonth, selectedDate: selectedDate)
        }
        .onChange(of: selectedKind) { _, newValue in
            if !store.categories(for: newValue).contains(selectedCategory) {
                selectedCategory = store.defaultCategory(for: newValue)
            }
        }
        .sheet(isPresented: $showingBudgetManager) {
            BudgetManagerSheet()
                .environmentObject(store)
                .environment(\.appLanguage, language)
                .frame(minWidth: 520, minHeight: 460)
        }
    }

    @ViewBuilder
    private func calendarContent(snapshot: CalendarLedgerSnapshot, isWide: Bool) -> some View {
        if isWide {
            HStack(alignment: .top, spacing: 16) {
                calendarBoard(snapshot: snapshot)
                .frame(minWidth: 560, maxWidth: 820)
                dayPanel(snapshot: snapshot)
                .frame(width: 310)
            }
        } else {
            VStack(spacing: 16) {
                calendarBoard(snapshot: snapshot)
                dayPanel(snapshot: snapshot)
            }
        }
    }

    @ViewBuilder
    private func calendarBoard(snapshot: CalendarLedgerSnapshot) -> some View {
        CalendarBoard(days: snapshot.monthDays) { day in
            select(day)
        }
        .id(pageToken)
        .clipped()
        .conditionalCompositingGroup(isWindowActive)
        .transition(isWindowActive ? .asymmetric(
            insertion: .move(edge: pageDirection >= 0 ? .trailing : .leading).combined(with: .opacity),
            removal: .move(edge: pageDirection >= 0 ? .leading : .trailing).combined(with: .opacity)
        ) : .identity)
        .animation(isWindowActive ? .easeInOut(duration: 0.24) : nil, value: pageToken)
    }

    private func dayPanel(snapshot: CalendarLedgerSnapshot) -> some View {
        DayLedgerPanel(
            date: selectedDate,
            entries: snapshot.selectedEntries,
            selectedKind: $selectedKind,
            selectedCategory: $selectedCategory,
            amountText: $amountText,
            noteText: $noteText,
            expenseCategories: store.expenseCategories,
            incomeCategories: store.incomeCategories,
            onSave: { kind, category, amount, note in
                store.addEntry(date: selectedDate, kind: kind, category: category, amount: amount, note: note)
                return nil
            },
            onUpdate: { id, kind, category, amount, note in
                store.updateEntry(id: id, kind: kind, category: category, amount: amount, note: note)
                return nil
            },
            onDelete: { id in
                store.deleteEntry(id: id)
            }
        )
    }

    private func select(_ day: CalendarDay) {
        let nextMonth = day.date.startOfMonth
        let shouldMovePage = !calendar.isDate(day.date, equalTo: displayedMonth, toGranularity: .month)

        if shouldMovePage {
            pageDirection = nextMonth > displayedMonth ? 1 : -1
            updateCalendarState(animated: isWindowActive) {
                selectedDate = day.date
                displayedMonth = nextMonth
                refreshSnapshot(displayedMonth: nextMonth, selectedDate: day.date)
                pageToken += 1
            }
        } else {
            selectedDate = day.date
            refreshSnapshot(displayedMonth: displayedMonth, selectedDate: day.date)
        }
    }

    private func movePeriod(by value: Int) {
        pageDirection = value
        let target = calendar.date(byAdding: .month, value: value, to: displayedMonth) ?? displayedMonth
        let selectedDay = min(calendar.component(.day, from: selectedDate), calendar.range(of: .day, in: .month, for: target)?.count ?? 1)
        let nextDisplayedMonth = target.startOfMonth
        let nextSelectedDate = calendar.date(bySetting: .day, value: selectedDay, of: target)?.startOfDay ?? target.startOfDay

        updateCalendarState(animated: isWindowActive) {
            displayedMonth = nextDisplayedMonth
            selectedDate = nextSelectedDate
            refreshSnapshot(displayedMonth: nextDisplayedMonth, selectedDate: nextSelectedDate)
            pageToken += 1
        }
    }

    private func updateCalendarState(animated: Bool, _ updates: () -> Void) {
        if animated {
            withAnimation(.easeInOut(duration: 0.24), updates)
        } else {
            updates()
        }
    }

    private func refreshSnapshot(displayedMonth: Date, selectedDate: Date) {
        snapshot = makeSnapshot(displayedMonth: displayedMonth, selectedDate: selectedDate)
    }

    private func makeSnapshot(displayedMonth: Date, selectedDate: Date) -> CalendarLedgerSnapshot {
        let allEntries = store.entries
        let entriesByDay = Dictionary(grouping: allEntries, by: { calendar.startOfDay(for: $0.date) })
            .mapValues { entries in
                entries.sorted { $0.createdAt > $1.createdAt }
            }

        let monthEntries = allEntries.filter {
            calendar.isDate($0.date, equalTo: displayedMonth, toGranularity: .month)
        }

        let monthExpense = monthEntries
            .lazy
            .filter { $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)

        let activeDays = Set(monthEntries.map { calendar.startOfDay(for: $0.date) }).count
        let selectedDay = selectedDate.startOfDay
        let selectedEntries = entriesByDay[selectedDay] ?? []

        return CalendarLedgerSnapshot(
            monthDays: makeMonthDays(entriesByDay: entriesByDay, displayedMonth: displayedMonth, selectedDate: selectedDate),
            selectedEntries: selectedEntries,
            monthEntryCount: monthEntries.count,
            monthExpense: monthExpense,
            activeDays: activeDays
        )
    }

    private func makeMonthDays(entriesByDay: [Date: [LedgerEntry]], displayedMonth: Date, selectedDate: Date) -> [CalendarDay] {
        let firstDay = displayedMonth.startOfMonth
        let weekday = calendar.component(.weekday, from: firstDay)
        let mondayOffset = (weekday + 5) % 7
        let startDate = calendar.date(byAdding: .day, value: -mondayOffset, to: firstDay) ?? firstDay

        return (0..<42).compactMap { index in
            guard let date = calendar.date(byAdding: .day, value: index, to: startDate) else {
                return nil
            }
            let day = date.startOfDay

            return CalendarDay(
                date: day,
                isCurrentMonth: calendar.isDate(day, equalTo: displayedMonth, toGranularity: .month),
                isSelected: calendar.isDate(day, inSameDayAs: selectedDate),
                isToday: calendar.isDateInToday(day),
                entries: entriesByDay[day] ?? []
            )
        }
    }

}

private struct CalendarHeader: View {
    @Environment(\.appLanguage) private var language
    let displayedMonth: Date
    let entryCount: Int
    let activeDays: Int
    let monthExpense: Double
    let onPrevious: () -> Void
    let onNext: () -> Void
    let onToday: () -> Void

    var body: some View {
        GlassPanel(cornerRadius: 24) {
            ViewThatFits(in: .horizontal) {
                HStack(alignment: .center, spacing: 18) {
                    titleBlock
                    Spacer(minLength: 0)
                    controls
                }

                VStack(alignment: .leading, spacing: 14) {
                    titleBlock
                    controls
                }
            }
        }
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(displayedMonth.formatted(.dateTime.year().month(.wide).locale(language.locale)))
                .font(.system(size: 30, weight: .semibold, design: .rounded))
            Text(entryCount == 0 ? language.text(.emptyMonth) : "\(entryCount) \(language.text(.records)) · \(language.text(.activeDays)) \(activeDays) \(language.text(.days)) · \(language.text(.monthlyExpense)) \(monthExpense.currencyText)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var controls: some View {
        HStack(spacing: 8) {
            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
            }
            .buttonStyle(CalendarPageButtonStyle())
            .help(language.text(.previousMonth))

            Button(action: onNext) {
                Image(systemName: "chevron.right")
            }
            .buttonStyle(CalendarPageButtonStyle())
            .help(language.text(.nextMonth))

            Button(action: onToday) {
                Label(language.text(.today), systemImage: "dot.scope")
            }
            .help(language.text(.backToToday))
        }
        .controlSize(.regular)
    }
}

private struct CalendarPageButtonStyle: ButtonStyle {
    @Environment(\.isWindowActive) private var isWindowActive

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .foregroundStyle(configuration.isPressed ? .white : .primary)
            .frame(width: 30, height: 30)
            .background(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(configuration.isPressed ? Color.accentColor : Color(nsColor: .controlBackgroundColor).opacity(0.88))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .strokeBorder(configuration.isPressed ? Color.accentColor.opacity(0.2) : .secondary.opacity(0.18), lineWidth: 1)
            )
            .scaleEffect(isWindowActive && configuration.isPressed ? 0.88 : 1)
            .animation(isWindowActive ? .spring(response: 0.18, dampingFraction: 0.68) : nil, value: configuration.isPressed)
    }
}

private struct BudgetStatusCard: View {
    @Environment(\.appLanguage) private var language
    let metrics: BudgetMetrics?
    let planCount: Int
    let onManage: () -> Void

    var body: some View {
        GlassPanel(cornerRadius: 20, shadowLevel: .card) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(language.text(.monthlyBudget))
                            .font(.headline)
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button(action: onManage) {
                        Label(language.text(.manageBudgets), systemImage: "slider.horizontal.3")
                    }
                    .buttonStyle(.bordered)
                }

                if let metrics {
                    AnimatedProgressBar(
                        ratio: metrics.progress,
                        tint: metrics.remaining < 0 ? .red : .blue
                    )

                    ViewThatFits(in: .horizontal) {
                        HStack(spacing: 10) {
                            budgetMetricTile(title: language.text(.used), value: metrics.spent.compactCurrencyText, note: "\(Int(metrics.progress * 100))%", symbol: "arrow.up.right", tint: .orange)
                            budgetMetricTile(title: language.text(.remaining), value: metrics.remaining.compactCurrencyText, note: "\(language.text(.remainingDays)) \(metrics.remainingDays) \(language.text(.days))", symbol: "gauge.with.needle", tint: metrics.remaining < 0 ? .red : .blue)
                            budgetMetricTile(title: language.text(.dailyBudgetSuggestion), value: metrics.suggestedDailyBudget.compactCurrencyText, note: language.text(.averageDailyBudget), symbol: "sparkline", tint: .green)
                            budgetMetricTile(title: language.text(.totalBudgetDays), value: "\(metrics.dayCount)", note: "\(language.text(.elapsedDays)) \(metrics.elapsedDays)", symbol: "calendar", tint: .purple)
                        }

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 10)], spacing: 10) {
                            budgetMetricTile(title: language.text(.used), value: metrics.spent.compactCurrencyText, note: "\(Int(metrics.progress * 100))%", symbol: "arrow.up.right", tint: .orange)
                            budgetMetricTile(title: language.text(.remaining), value: metrics.remaining.compactCurrencyText, note: "\(language.text(.remainingDays)) \(metrics.remainingDays) \(language.text(.days))", symbol: "gauge.with.needle", tint: metrics.remaining < 0 ? .red : .blue)
                            budgetMetricTile(title: language.text(.dailyBudgetSuggestion), value: metrics.suggestedDailyBudget.compactCurrencyText, note: language.text(.averageDailyBudget), symbol: "sparkline", tint: .green)
                            budgetMetricTile(title: language.text(.totalBudgetDays), value: "\(metrics.dayCount)", note: "\(language.text(.elapsedDays)) \(metrics.elapsedDays)", symbol: "calendar", tint: .purple)
                        }
                    }
                } else {
                    Text(language.text(.emptyBudgetPlans))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                }
            }
        }
    }

    private var subtitle: String {
        guard let metrics else {
            return "\(language.text(.budgetPlanList)) \(planCount)"
        }

        let range = "\(dateText(metrics.plan.startDate)) - \(dateText(metrics.plan.endDate))"
        return "\(range) · \(language.text(.remaining)) \(metrics.remaining.currencyText)"
    }

    private func budgetMetricTile(title: String, value: String, note: String, symbol: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 6) {
                Image(systemName: symbol)
                    .foregroundStyle(tint)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Text(value)
                .font(.headline.weight(.semibold))
                .lineLimit(1)
            Text(note)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, minHeight: 58, alignment: .leading)
        .padding(10)
        .background(tint.opacity(0.08), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func dateText(_ date: Date) -> String {
        date.formatted(.dateTime.month().day().locale(language.locale))
    }
}

private struct BudgetManagerSheet: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @Environment(\.dismiss) private var dismiss
    @State private var editingDraft: BudgetPlanDraft?
    @State private var validationMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(language.text(.manageBudgets))
                        .font(.title3.weight(.semibold))
                    Text(language.text(.budgetSubtitle))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button(language.text(.addBudgetPlan)) {
                    editingDraft = BudgetPlanDraft.nextAvailable(after: store.budgetPlans)
                    validationMessage = nil
                }
                .buttonStyle(.borderedProminent)
            }

            if let validationMessage {
                Text(validationMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }

            if store.budgetPlans.isEmpty {
                Text(language.text(.emptyBudgetPlans))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
            } else {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(store.budgetPlans) { plan in
                            BudgetPlanRow(
                                plan: plan,
                                metrics: store.budgetMetrics(for: plan),
                                onEdit: {
                                    editingDraft = BudgetPlanDraft(plan: plan)
                                    validationMessage = nil
                                },
                                onDelete: {
                                    store.deleteBudgetPlan(id: plan.id)
                                }
                            )
                        }
                    }
                    .padding(.vertical, 2)
                }
            }

            Spacer(minLength: 0)

            HStack {
                Spacer()
                Button(language.text(.cancel)) {
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)
            }
        }
        .padding(22)
        .sheet(item: $editingDraft) { draft in
            BudgetPlanEditorSheet(
                draft: draft,
                onCancel: {
                    editingDraft = nil
                },
                onSave: { savedDraft in
                    save(savedDraft)
                }
            )
            .environmentObject(store)
            .environment(\.appLanguage, language)
            .frame(width: 360)
        }
    }

    private func save(_ draft: BudgetPlanDraft) {
        let result: BudgetValidationError?
        if let id = draft.planID {
            result = store.updateBudgetPlan(id: id, amount: draft.amount, startDate: draft.startDate, endDate: draft.endDate)
        } else {
            result = store.addBudgetPlan(amount: draft.amount, startDate: draft.startDate, endDate: draft.endDate)
        }

        if let result {
            validationMessage = validationText(for: result)
        } else {
            validationMessage = nil
            editingDraft = nil
        }
    }

    private func validationText(for error: BudgetValidationError) -> String {
        switch error {
        case .notFound:
            return error.localizedDescription
        case .overlapsExisting:
            return language.text(.budgetOverlapError)
        }
    }
}

private struct BudgetPlanRow: View {
    @Environment(\.appLanguage) private var language
    let plan: BudgetPlan
    let metrics: BudgetMetrics
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(dateText(plan.startDate)) - \(dateText(plan.endDate))")
                        .font(.headline)
                    Text("\(language.text(.used)) \(metrics.spent.compactCurrencyText) / \(plan.amount.compactCurrencyText)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(Int(metrics.progress * 100))%")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(metrics.remaining < 0 ? .red : .blue)

                Button(action: onEdit) {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.borderless)
                .help(language.text(.editBudgetPlan))

                Button(role: .destructive, action: onDelete) {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderless)
                .help(language.text(.delete))
            }

            AnimatedProgressBar(
                ratio: metrics.progress,
                tint: metrics.remaining < 0 ? .red : .blue
            )

            Text("\(language.text(.remaining)) \(metrics.remaining.compactCurrencyText) · \(language.text(.dailyBudgetSuggestion)) \(metrics.suggestedDailyBudget.compactCurrencyText)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(.secondary.opacity(0.07), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func dateText(_ date: Date) -> String {
        date.formatted(.dateTime.year().month().day().locale(language.locale))
    }
}

private struct BudgetPlanEditorSheet: View {
    @Environment(\.appLanguage) private var language
    @State private var draft: BudgetPlanDraft
    let onCancel: () -> Void
    let onSave: (BudgetPlanDraft) -> Void

    init(draft: BudgetPlanDraft, onCancel: @escaping () -> Void, onSave: @escaping (BudgetPlanDraft) -> Void) {
        _draft = State(initialValue: draft)
        self.onCancel = onCancel
        self.onSave = onSave
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(draft.planID == nil ? language.text(.addBudgetPlan) : language.text(.editBudgetPlan))
                .font(.title3.weight(.semibold))

            TextField(
                language.text(.budgetAmount),
                value: $draft.amount,
                format: .number.precision(.fractionLength(0...2))
            )
            .textFieldStyle(.roundedBorder)

            DatePicker(language.text(.startDate), selection: $draft.startDate, displayedComponents: .date)
            DatePicker(language.text(.endDate), selection: $draft.endDate, displayedComponents: .date)

            Text("\(language.text(.totalBudgetDays)) \(BudgetPlan(amount: draft.amount, startDate: draft.startDate, endDate: draft.endDate).dayCount) \(language.text(.days))")
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack {
                Button(language.text(.cancel), action: onCancel)
                    .keyboardShortcut(.cancelAction)

                Spacer()

                Button(language.text(.save)) {
                    onSave(draft)
                }
                .buttonStyle(.borderedProminent)
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(22)
    }
}

private struct BudgetPlanDraft: Identifiable {
    let id = UUID()
    var planID: UUID?
    var amount: Double
    var startDate: Date
    var endDate: Date

    init(planID: UUID? = nil, amount: Double, startDate: Date, endDate: Date) {
        self.planID = planID
        self.amount = amount
        self.startDate = startDate
        self.endDate = endDate
    }

    init(plan: BudgetPlan) {
        planID = plan.id
        amount = plan.amount
        startDate = plan.startDate
        endDate = plan.endDate
    }

    static func new(referenceDate: Date = Date(), calendar: Calendar = .current) -> BudgetPlanDraft {
        let start = calendar.startOfDay(for: referenceDate)
        let end = calendar.date(byAdding: .day, value: 6, to: start) ?? start
        return BudgetPlanDraft(amount: 0, startDate: start, endDate: end)
    }

    static func nextAvailable(after plans: [BudgetPlan], referenceDate: Date = Date(), calendar: Calendar = .current) -> BudgetPlanDraft {
        var start = calendar.startOfDay(for: referenceDate)
        let sortedPlans = plans.sorted { $0.startDate < $1.startDate }

        for plan in sortedPlans where plan.endDate >= start {
            let end = calendar.date(byAdding: .day, value: 6, to: start) ?? start
            let draftPlan = BudgetPlan(amount: 0, startDate: start, endDate: end, calendar: calendar)
            if !draftPlan.overlaps(plan) {
                continue
            }
            start = calendar.date(byAdding: .day, value: 1, to: plan.endDate) ?? start
        }

        return new(referenceDate: start, calendar: calendar)
    }
}

private struct CalendarBoard: View {
    @Environment(\.appLanguage) private var language
    let days: [CalendarDay]
    let onSelect: (CalendarDay) -> Void

    private let columns = Array(repeating: GridItem(.flexible(minimum: 64), spacing: 8), count: 7)

    private var weekdayTitles: [String] {
        language == .chinese ? ["周一", "周二", "周三", "周四", "周五", "周六", "周日"] : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }

    var body: some View {
        CalendarPanel(cornerRadius: 24) {
            VStack(spacing: 10) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(weekdayTitles, id: \.self) { title in
                        Text(title)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 24)
                            .background(.secondary.opacity(0.05), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }

                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(days) { day in
                        CalendarDayCell(day: day)
                            .onTapGesture {
                                onSelect(day)
                            }
                    }
                }
            }
        }
    }
}

private struct CalendarDayCell: View {
    @Environment(\.isWindowActive) private var isWindowActive
    @Environment(\.appLanguage) private var language
    let day: CalendarDay
    @State private var isHovering = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(day.date.formatted(.dateTime.day().locale(language.locale)))
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(day.isCurrentMonth ? .primary : .secondary)

                Spacer(minLength: 4)

                if day.isToday {
                    Text(language == .chinese ? "今" : "Now")
                        .font(.caption2.weight(.bold))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(.green.opacity(0.16), in: Capsule())
                        .foregroundStyle(.green)
                }
            }

            Spacer(minLength: 2)

            VStack(alignment: .leading, spacing: 5) {
                if let primaryCategory = day.primaryCategory {
                    Text(primaryCategory)
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(categoryColor(primaryCategory).opacity(0.12), in: Capsule())
                        .foregroundStyle(categoryColor(primaryCategory))
                        .lineLimit(1)
                } else if !day.isCurrentMonth {
                    Text(day.date.formatted(.dateTime.month().locale(language.locale)))
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }

                if day.expense > 0 {
                    amountLine(text: day.expense.compactCurrencyText, symbol: "arrow.up.right", tint: .orange)
                }

                if day.income > 0 {
                    amountLine(text: "+\(day.income.compactCurrencyText)", symbol: "arrow.down.left", tint: .green)
                }
            }

            HStack {
                if !day.entries.isEmpty {
                    Text("\(day.entries.count)")
                        .font(.caption2.weight(.bold))
                        .frame(minWidth: 20, minHeight: 20)
                        .background(day.isSelected ? .white.opacity(0.90) : .blue.opacity(0.11), in: Capsule())
                        .foregroundStyle(day.isSelected ? .blue : .primary)
                }

                Spacer(minLength: 0)

                if !day.entries.isEmpty {
                    HStack(spacing: 3) {
                        if day.expense > 0 {
                            Circle()
                                .fill(.orange)
                                .frame(width: 7, height: 7)
                        }
                        if day.income > 0 {
                            Circle()
                                .fill(.green)
                                .frame(width: 7, height: 7)
                        }
                    }
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 90, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(cellBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(cellBorder, lineWidth: day.isSelected ? 2 : 1)
        )
        .scaleEffect(isWindowActive && isHovering ? 1.018 : 1)
        .offset(y: isWindowActive && isHovering ? -1 : 0)
        .opacity(day.isCurrentMonth ? 1 : 0.42)
        .animation(isWindowActive ? .easeOut(duration: 0.16) : nil, value: isHovering)
        .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .onHover { isHovering = isWindowActive && $0 }
        .onChange(of: isWindowActive) { _, active in
            if !active {
                isHovering = false
            }
        }
    }

    @ViewBuilder
    private func amountLine(text: String, symbol: String, tint: Color) -> some View {
        HStack(spacing: 3) {
            Image(systemName: symbol)
                .font(.caption2.weight(.semibold))
            Text(text)
                .font(.caption.weight(.semibold))
                .lineLimit(1)
        }
        .foregroundStyle(tint)
    }

    private var cellBackground: AnyShapeStyle {
        if day.isSelected {
            return AnyShapeStyle(.blue.opacity(0.18))
        }

        if day.isToday {
            return AnyShapeStyle(.green.opacity(0.08))
        }

        return AnyShapeStyle(.white.opacity(isHovering ? 0.72 : 0.54))
    }

    private var cellBorder: Color {
        if day.isSelected {
            return .blue.opacity(0.62)
        }
        if day.isToday {
            return .green.opacity(0.36)
        }
        if !day.entries.isEmpty {
            return .secondary.opacity(isHovering ? 0.30 : 0.18)
        }
        return .secondary.opacity(isHovering ? 0.22 : 0.10)
    }

    private func categoryColor(_ category: String) -> Color {
        let colors: [Color] = [.orange, .green, .blue, .purple, .pink, .teal]
        let index = abs(category.hashValue) % colors.count
        return colors[index]
    }
}

private struct DayLedgerPanel: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.isWindowActive) private var isWindowActive
    let date: Date
    let entries: [LedgerEntry]
    @Binding var selectedKind: TransactionKind
    @Binding var selectedCategory: String
    @Binding var amountText: String
    @Binding var noteText: String
    let expenseCategories: [String]
    let incomeCategories: [String]
    let onSave: (_ kind: TransactionKind, _ category: String, _ amount: Double, _ note: String) -> String?
    let onUpdate: (_ id: UUID, _ kind: TransactionKind, _ category: String, _ amount: Double, _ note: String) -> String?
    let onDelete: (_ id: UUID) -> Void

    @State private var feedbackMessage: String?
    @State private var editingEntry: LedgerEntry?

    private var expense: Double {
        entries.filter { $0.kind == .expense }.map(\.amount).reduce(0, +)
    }

    private var income: Double {
        entries.filter { $0.kind == .income }.map(\.amount).reduce(0, +)
    }

    private var categories: [String] {
        selectedKind == .expense ? expenseCategories : incomeCategories
    }

    var body: some View {
        GlassPanel(cornerRadius: 24) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    HStack(spacing: 12) {
                        VStack(spacing: 2) {
                            Text(date.formatted(.dateTime.month().locale(language.locale)))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .contentTransition(.numericText())
                            Text(date.formatted(.dateTime.day().locale(language.locale)))
                                .font(.title.weight(.bold))
                                .foregroundStyle(.primary)
                                .contentTransition(.numericText())
                        }
                        .frame(width: 64, height: 64)
                        .background(.white.opacity(0.62), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .strokeBorder(.secondary.opacity(0.12), lineWidth: 1)
                        )
                        .animation(isWindowActive ? .easeOut(duration: 0.18) : nil, value: date)

                        VStack(alignment: .leading, spacing: 6) {
                            Text(date.formatted(.dateTime.weekday(.wide).locale(language.locale)))
                                .font(.headline.weight(.semibold))
                            Text(entries.isEmpty ? language.text(.emptyDay) : "\(entries.count) \(language.text(.entriesUnit))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 4) {
                        Text(language.text(.selectedDayExpense))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(expense.currencyText)
                            .font(.headline)
                            .foregroundStyle(.orange)
                        if income > 0 {
                            Text("+\(income.currencyText)")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.green)
                        }
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text(language.text(.quickEntry))
                        .font(.headline)

                    Picker(language.text(.type), selection: $selectedKind) {
                        ForEach(TransactionKind.allCases) { kind in
                            Text(kind.title(language)).tag(kind)
                        }
                    }
                    .pickerStyle(.segmented)

                    if categories.isEmpty {
                        Text(language.text(.noCategoriesHint))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 4)
                    } else {
                        Picker(language.text(.category), selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                    }

                    TextField(language.text(.amountPlaceholder), text: $amountText)
                        .textFieldStyle(.roundedBorder)

                    TextField(language.text(.note), text: $noteText)
                        .textFieldStyle(.roundedBorder)

                    Button {
                        let normalized = amountText
                            .replacingOccurrences(of: ",", with: "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        guard let amount = Double(normalized), amount > 0 else {
                            feedbackMessage = language.text(.invalidAmount)
                            return
                        }

                        updateDayPanelState {
                            let error = onSave(selectedKind, selectedCategory, amount, noteText)
                            if let error {
                                feedbackMessage = error
                            } else {
                                feedbackMessage = nil
                                amountText = ""
                                noteText = ""
                            }
                        }
                    } label: {
                        Label(language.text(.save), systemImage: "checkmark")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(categories.isEmpty || selectedCategory.isEmpty)

                    if let feedbackMessage {
                        Text(feedbackMessage)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text(language.text(.dayDetails))
                        .font(.headline)

                    if entries.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.title2)
                                .foregroundStyle(.secondary.opacity(0.75))
                            Text(language.text(.emptyDay))
                                .font(.subheadline.weight(.medium))
                            Text(language.text(.emptyDayHint))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
                        .transition(.opacity.combined(with: .scale(scale: 0.98)))
                    } else {
                        ForEach(entries) { entry in
                            LedgerEntryRow(entry: entry, onEdit: {
                                editingEntry = entry
                            }, onDelete: {
                                updateDayPanelState {
                                    onDelete(entry.id)
                                }
                            })
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.8).combined(with: .opacity),
                                removal: .scale(scale: 0.6).combined(with: .opacity)
                            ))

                            if entry.id != entries.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .animation(isWindowActive ? .spring(response: 0.28, dampingFraction: 0.82) : nil, value: entries.count)
        .sheet(item: $editingEntry) { entry in
            EntryEditorSheet(
                entry: entry,
                expenseCategories: categories(for: .expense),
                incomeCategories: categories(for: .income),
                onCancel: {
                    editingEntry = nil
                },
                onSave: { kind, category, amount, note in
                    let error = onUpdate(entry.id, kind, category, amount, note)
                    if error == nil {
                        editingEntry = nil
                    }
                    return error
                }
            )
            .frame(width: 420)
        }
    }

    private func categories(for kind: TransactionKind) -> [String] {
        let source = kind == .expense ? expenseCategories : incomeCategories
        if kind == selectedKind {
            return source
        }
        return source
    }

    private func updateDayPanelState(_ updates: () -> Void) {
        if isWindowActive {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8), updates)
        } else {
            updates()
        }
    }
}

private struct TransactionsPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @Environment(\.isWindowActive) private var isWindowActive
    @State private var searchText = ""

    private var filteredEntries: [LedgerEntry] {
        let source = store.entries.sorted { $0.date > $1.date || ($0.date == $1.date && $0.createdAt > $1.createdAt) }
        guard !searchText.isEmpty else { return source }
        return source.filter {
            $0.category.localizedCaseInsensitiveContains(searchText) ||
            $0.note.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        PageSurface {
            PageHeader(
                title: language.text(.transactions),
                subtitle: language.text(.transactionsSubtitle),
                primaryActionTitle: language.text(.newTransaction),
                primaryActionSymbol: "plus",
                secondaryActionTitle: language.text(.filter),
                secondaryActionSymbol: "line.3.horizontal.decrease.circle"
            )

            TextField(language.text(.searchCategoryOrNote), text: $searchText)
                .textFieldStyle(.roundedBorder)

            GlassPanel(cornerRadius: 20) {
                VStack(spacing: 0) {
                    if filteredEntries.isEmpty {
                        Text(language.text(.emptyTransactions))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 80, alignment: .center)
                            .transition(.opacity)
                    } else {
                        ForEach(filteredEntries) { entry in
                            LedgerEntryRow(entry: entry, onDelete: {
                                updateTransactionState {
                                    store.deleteEntry(id: entry.id)
                                }
                            })
                            .padding(.vertical, 3)
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.8).combined(with: .opacity),
                                removal: .scale(scale: 0.6).combined(with: .opacity)
                            ))

                            if entry.id != filteredEntries.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }

    private func updateTransactionState(_ updates: () -> Void) {
        if isWindowActive {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8), updates)
        } else {
            updates()
        }
    }
}

private struct ReportsPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @State private var selectedPeriod: ReportPeriod = .sixMonths

    private var months: [Date] {
        let calendar = Calendar.current
        let today = Date().startOfMonth
        let count = selectedPeriod.monthCount
        return (0..<count).compactMap { offset in
            calendar.date(byAdding: .month, value: -(count - 1 - offset), to: today)
        }.map { $0.startOfMonth }
    }

    private var monthBarData: [MonthBarDatum] {
        months.map { month in
            MonthBarDatum(
                month: month,
                income: store.totalIncome(in: month),
                expense: store.totalExpense(in: month)
            )
        }
    }

    private var categoryPieData: [CategoryPieDatum] {
        let thisMonth = Date().startOfMonth
        let entries = store.entries(in: thisMonth).filter { $0.kind == .expense }
        let grouped = Dictionary(grouping: entries, by: { $0.category })
            .mapValues { $0.map(\.amount).reduce(0, +) }
        return grouped.map { CategoryPieDatum(category: $0.key, amount: $0.value) }
            .sorted { $0.amount > $1.amount }
    }

    var body: some View {
        PageSurface {
            PageHeader(
                title: language.text(.reports),
                subtitle: language.text(.reportsSubtitle),
                primaryActionTitle: "",
                primaryActionSymbol: "",
                secondaryActionTitle: "",
                secondaryActionSymbol: ""
            ) {
                Picker(language.text(.period), selection: $selectedPeriod) {
                    ForEach(ReportPeriod.allCases) { period in
                        Text(period.title(language)).tag(period)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
            }

            ViewThatFits(in: .horizontal) {
                HStack(alignment: .top, spacing: 16) {
                    MonthBarChart(data: monthBarData)
                    CategoryPieChart(data: categoryPieData)
                }

                VStack(spacing: 16) {
                    MonthBarChart(data: monthBarData)
                    CategoryPieChart(data: categoryPieData)
                }
            }
        }
    }
}

private enum ReportPeriod: String, CaseIterable, Identifiable {
    case threeMonths
    case sixMonths
    case twelveMonths

    var id: String { rawValue }

    func title(_ language: AppLanguage) -> String {
        switch self {
        case .threeMonths: return language.text(.threeMonths)
        case .sixMonths: return language.text(.sixMonths)
        case .twelveMonths: return language.text(.twelveMonths)
        }
    }

    var monthCount: Int {
        switch self {
        case .threeMonths: return 3
        case .sixMonths: return 6
        case .twelveMonths: return 12
        }
    }
}

private struct MonthBarDatum: Identifiable {
    let month: Date
    let income: Double
    let expense: Double

    var id: Date { month }

    func label(_ language: AppLanguage) -> String {
        month.formatted(.dateTime.month(.abbreviated).locale(language.locale))
    }
}

private struct CategoryPieDatum: Identifiable {
    let category: String
    let amount: Double

    var id: String { category }
}

private struct MonthBarChart: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.isWindowActive) private var isWindowActive
    let data: [MonthBarDatum]
    @State private var chartOpacity: Double = 0

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(alignment: .leading, spacing: 14) {
                Text(language.text(.monthlyIncomeExpense))
                    .font(.headline)

                if data.isEmpty {
                    placeholder
                } else {
                    Chart(data) { item in
                        BarMark(
                            x: .value(language.text(.monthAxis), item.label(language)),
                            y: .value(language.text(.amount), item.expense)
                        )
                        .foregroundStyle(.orange.opacity(0.7))

                        BarMark(
                            x: .value(language.text(.monthAxis), item.label(language)),
                            y: .value(language.text(.amount), item.income)
                        )
                        .foregroundStyle(.green.opacity(0.7))
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic) { _ in
                            AxisValueLabel()
                        }
                    }
                    .chartYAxis {
                        AxisMarks { _ in
                            AxisValueLabel()
                        }
                    }
                    .chartLegend {
                        HStack(spacing: 14) {
                            HStack(spacing: 4) {
                                Circle().fill(.orange).frame(width: 8, height: 8)
                                Text(language.text(.expense))
                            }
                            HStack(spacing: 4) {
                                Circle().fill(.green).frame(width: 8, height: 8)
                                Text(language.text(.income))
                            }
                        }
                    }
                    .frame(height: 240)
                    .opacity(chartOpacity)
                    .onAppear {
                        guard isWindowActive else {
                            chartOpacity = 1
                            return
                        }

                        withAnimation(.easeOut(duration: 0.6)) {
                            chartOpacity = 1
                        }
                    }
                }
            }
        }
    }

    private var placeholder: some View {
        Text(language.text(.noData))
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, minHeight: 220, alignment: .center)
    }
}

private struct CategoryPieChart: View {
    @Environment(\.appLanguage) private var language
    @Environment(\.isWindowActive) private var isWindowActive
    let data: [CategoryPieDatum]
    @State private var chartOpacity: Double = 0

    var body: some View {
        GlassPanel(cornerRadius: 22) {
            VStack(alignment: .leading, spacing: 14) {
                Text(language.text(.thisMonthExpenseByCategory))
                    .font(.headline)

                if data.isEmpty {
                    Text(language.text(.noExpenseThisMonth))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, minHeight: 220, alignment: .center)
                } else {
                    Chart(data) { item in
                        SectorMark(
                            angle: .value(language.text(.amount), item.amount),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .foregroundStyle(by: .value(language.text(.category), item.category))
                    }
                    .chartLegend(position: .bottom, spacing: 8)
                    .frame(height: 260)
                    .opacity(chartOpacity)
                    .onAppear {
                        guard isWindowActive else {
                            chartOpacity = 1
                            return
                        }

                        withAnimation(.easeOut(duration: 0.6)) {
                            chartOpacity = 1
                        }
                    }
                }
            }
        }
    }
}

private struct PageSurface<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                content()
            }
            .padding(24)
        }
        .background(AppBackground())
    }
}

private struct PageHeader<Trailing: View>: View {
    let title: String
    let subtitle: String
    let primaryActionTitle: String
    let primaryActionSymbol: String
    let secondaryActionTitle: String
    let secondaryActionSymbol: String
    @ViewBuilder var trailing: () -> Trailing

    init(
        title: String,
        subtitle: String,
        primaryActionTitle: String,
        primaryActionSymbol: String,
        secondaryActionTitle: String,
        secondaryActionSymbol: String,
        @ViewBuilder trailing: @escaping () -> Trailing = { EmptyView() }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.primaryActionTitle = primaryActionTitle
        self.primaryActionSymbol = primaryActionSymbol
        self.secondaryActionTitle = secondaryActionTitle
        self.secondaryActionSymbol = secondaryActionSymbol
        self.trailing = trailing
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title2.weight(.semibold))
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            trailing()

            HStack(spacing: 8) {
                if !primaryActionTitle.isEmpty {
                    Button(action: {}) {
                        Image(systemName: primaryActionSymbol)
                    }
                    .help(primaryActionTitle)
                }

                if !secondaryActionTitle.isEmpty {
                    Button(action: {}) {
                        Image(systemName: secondaryActionSymbol)
                    }
                    .help(secondaryActionTitle)
                }
            }
            .buttonStyle(.bordered)
            .controlSize(.regular)
        }
    }
}

private struct MetricGlassTile: View {
    let title: String
    let value: String
    let note: String
    let symbol: String
    let tint: Color

    var body: some View {
        GlassPanel(cornerRadius: 20, shadowLevel: .card) {
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Image(systemName: symbol)
                        .foregroundStyle(tint)
                }

                Text(value)
                    .font(.title3.weight(.semibold))
                    .contentTransition(.numericText())

                Text(note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, minHeight: 72, alignment: .leading)
        }
        .modifier(HoverLift())
    }
}

private struct LedgerEntryRow: View {
    @Environment(\.appLanguage) private var language
    let entry: LedgerEntry
    var onEdit: (() -> Void)? = nil
    var onDelete: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: entry.kind.symbol)
                .font(.body.weight(.semibold))
                .foregroundStyle(entry.kind.tint)
                .frame(width: 30, height: 30)
                .background(entry.kind.tint.opacity(0.12), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.category)
                    .font(.body.weight(.medium))
                Text(entry.note.isEmpty ? entry.date.formatted(.dateTime.month().day().hour().minute().locale(language.locale)) : entry.note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 12)

            Text(entry.kind == .income ? "+\(entry.amount.currencyText)" : entry.amount.currencyText)
                .font(.body.weight(.semibold))
                .foregroundStyle(entry.kind.tint)

            if let onEdit {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.borderless)
                .help(language.text(.edit))
            }

            if let onDelete {
                Button(role: .destructive, action: onDelete) {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderless)
                .help(language.text(.delete))
            }
        }
        .padding(.vertical, 8)
    }
}

private struct EntryEditorSheet: View {
    @Environment(\.appLanguage) private var language
    let entry: LedgerEntry
    let expenseCategories: [String]
    let incomeCategories: [String]
    let onCancel: () -> Void
    let onSave: (_ kind: TransactionKind, _ category: String, _ amount: Double, _ note: String) -> String?

    @State private var kind: TransactionKind
    @State private var category: String
    @State private var amountText: String
    @State private var noteText: String
    @State private var feedbackMessage: String?

    init(
        entry: LedgerEntry,
        expenseCategories: [String],
        incomeCategories: [String],
        onCancel: @escaping () -> Void,
        onSave: @escaping (_ kind: TransactionKind, _ category: String, _ amount: Double, _ note: String) -> String?
    ) {
        self.entry = entry
        self.expenseCategories = expenseCategories
        self.incomeCategories = incomeCategories
        self.onCancel = onCancel
        self.onSave = onSave
        _kind = State(initialValue: entry.kind)
        _category = State(initialValue: entry.category)
        _amountText = State(initialValue: entry.amount.editingAmountText)
        _noteText = State(initialValue: entry.note)
    }

    private var categories: [String] {
        kind == .expense ? expenseCategories : incomeCategories
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(language.text(.editEntry))
                    .font(.title3.weight(.semibold))
                Text(entry.date.formatted(.dateTime.year().month().day().weekday(.wide).locale(language.locale)))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Picker(language.text(.type), selection: $kind) {
                ForEach(TransactionKind.allCases) { item in
                    Text(item.title(language)).tag(item)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: kind) { _, newKind in
                let nextCategories = newKind == .expense ? expenseCategories : incomeCategories
                if !nextCategories.contains(category) {
                    category = nextCategories.first ?? "其他"
                }
            }

            Picker(language.text(.category), selection: $category) {
                ForEach(categories, id: \.self) { item in
                    Text(item).tag(item)
                }
            }

            TextField(language.text(.amount), text: $amountText)
                .textFieldStyle(.roundedBorder)

            TextField(language.text(.note), text: $noteText)
                .textFieldStyle(.roundedBorder)

            if let feedbackMessage {
                Text(feedbackMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack {
                Button(language.text(.cancel), action: onCancel)
                    .keyboardShortcut(.cancelAction)

                Spacer()

                Button(language.text(.save)) {
                    let normalized = amountText
                        .replacingOccurrences(of: ",", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)

                    guard let amount = Double(normalized), amount > 0 else {
                        feedbackMessage = language.text(.invalidAmount)
                        return
                    }

                    let error = onSave(kind, category, amount, noteText)
                    feedbackMessage = error
                }
                .buttonStyle(.borderedProminent)
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(22)
    }
}

private struct CategoriesManagementPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @State private var selectedKind: TransactionKind = .expense
    @State private var newCategoryName = ""

    private var categories: [String] {
        store.categories(for: selectedKind)
    }

    var body: some View {
        PageSurface {
            PageHeader(
                title: language.text(.categoryManagement),
                subtitle: language.text(.categoryManagementSubtitle),
                primaryActionTitle: "",
                primaryActionSymbol: "",
                secondaryActionTitle: "",
                secondaryActionSymbol: ""
            ) {
                Picker(language.text(.type), selection: $selectedKind) {
                    ForEach(TransactionKind.allCases) { kind in
                        Text(kind.title(language)).tag(kind)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 160)
            }

            GlassPanel(cornerRadius: 22) {
                VStack(alignment: .leading, spacing: 0) {
                    if categories.isEmpty {
                        Text(language.text(.emptyCategories))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 80, alignment: .center)
                            .transition(.opacity)
                    } else {
                        ForEach(categories, id: \.self) { category in
                            CategoryRow(
                                category: category,
                                entryCount: store.entries.filter { $0.category == category && $0.kind == selectedKind }.count,
                                onDelete: {
                                    store.removeCategory(category, kind: selectedKind)
                                }
                            )

                            if category != categories.last {
                                Divider()
                            }
                        }
                    }
                }
            }

            GlassPanel(cornerRadius: 22) {
                HStack(spacing: 10) {
                    TextField(language.text(.newCategoryName), text: $newCategoryName)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            addCategory()
                        }

                    Button(language.text(.add)) {
                        addCategory()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.regular)
                    .disabled(newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func addCategory() {
        store.addCategory(newCategoryName, kind: selectedKind)
        newCategoryName = ""
    }
}

private struct CategoryRow: View {
    @Environment(\.appLanguage) private var language
    let category: String
    let entryCount: Int
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "tag")
                .font(.body)
                .foregroundStyle(.secondary)
                .frame(width: 28, height: 28)
                .background(.secondary.opacity(0.12), in: Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(category)
                    .font(.body.weight(.medium))
                Text("\(entryCount) \(language.text(.entryCount))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(role: .destructive, action: onDelete) {
                Image(systemName: "trash")
            }
            .buttonStyle(.borderless)
            .help(language.text(.deleteCategory))
        }
        .padding(.vertical, 10)
    }
}

private struct SettingsPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @AppStorage("appLanguage") private var appLanguageRaw = AppLanguage.chinese.rawValue
    @State private var showingDeleteAllAlert = false

    private var selectedLanguage: Binding<AppLanguage> {
        Binding(
            get: { AppLanguage(rawValue: appLanguageRaw) ?? .chinese },
            set: { appLanguageRaw = $0.rawValue }
        )
    }

    var body: some View {
        PageSurface {
            PageHeader(
                title: language.text(.settings),
                subtitle: language.text(.languageSubtitle),
                primaryActionTitle: "",
                primaryActionSymbol: "",
                secondaryActionTitle: "",
                secondaryActionSymbol: ""
            )

            GlassPanel(cornerRadius: 22) {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        Label(language.text(.language), systemImage: "globe")
                            .font(.headline)

                        Spacer()

                        Picker(language.text(.language), selection: selectedLanguage) {
                            ForEach(AppLanguage.allCases) { item in
                                Text(item.displayName(in: language)).tag(item)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 220)
                    }
                }
            }

            GlassPanel(cornerRadius: 22) {
                HStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .leading, spacing: 5) {
                        Label(language.text(.dataManagement), systemImage: "externaldrive.badge.xmark")
                            .font(.headline)
                        Text(language.text(.deleteAllDataHint))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button(role: .destructive) {
                        showingDeleteAllAlert = true
                    } label: {
                        Label(language.text(.deleteAllData), systemImage: "trash")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .alert(language.text(.confirmDeleteAllTitle), isPresented: $showingDeleteAllAlert) {
            Button(language.text(.delete), role: .destructive) {
                store.deleteAllEntries()
            }
            Button(language.text(.cancel), role: .cancel) {}
        } message: {
            Text(language.text(.confirmDeleteAllMessage))
        }
    }
}

private struct GlassPanel<Content: View>: View {
    @Environment(\.isWindowActive) private var isWindowActive
    let cornerRadius: CGFloat
    let shadowLevel: ShadowLevel
    @ViewBuilder var content: () -> Content

    init(cornerRadius: CGFloat, shadowLevel: ShadowLevel = .panel, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.shadowLevel = shadowLevel
        self.content = content
    }

    var body: some View {
        content()
            .padding(16)
            .background(panelBackground, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(isWindowActive ? .white.opacity(0.28) : .secondary.opacity(0.14), lineWidth: 1)
            )
            .shadow(color: .black.opacity(activeShadowOpacity * 0.5), radius: 0.5, y: 0)
            .shadow(color: .black.opacity(activeShadowOpacity * 0.7), radius: activeShadowRadius * 0.5, y: activeShadowOffset * 0.5)
            .shadow(color: .black.opacity(activeShadowOpacity), radius: activeShadowRadius, y: activeShadowOffset)
    }

    private var panelBackground: AnyShapeStyle {
        if isWindowActive {
            return AnyShapeStyle(.ultraThinMaterial)
        }

        return AnyShapeStyle(Color(nsColor: .controlBackgroundColor).opacity(0.96))
    }

    private var activeShadowOpacity: Double {
        isWindowActive ? shadowLevel.opacity : 0.025
    }

    private var activeShadowRadius: CGFloat {
        isWindowActive ? shadowLevel.radius : 4
    }

    private var activeShadowOffset: CGFloat {
        isWindowActive ? shadowLevel.yOffset : 1
    }
}

private struct CalendarPanel<Content: View>: View {
    let cornerRadius: CGFloat
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding(16)
            .background(Color(nsColor: .controlBackgroundColor).opacity(0.72), in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.secondary.opacity(0.12), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.04), radius: 10, y: 4)
    }
}

private struct AppBackground: View {
    @Environment(\.isWindowActive) private var isWindowActive

    var body: some View {
        ZStack {
            Color(nsColor: .windowBackgroundColor)

            if isWindowActive {
                LinearGradient(
                    colors: [
                        Color(nsColor: .controlAccentColor).opacity(0.08),
                        Color(nsColor: .windowBackgroundColor).opacity(0.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
        .ignoresSafeArea()
    }
}

private extension View {
    @ViewBuilder
    func conditionalCompositingGroup(_ enabled: Bool) -> some View {
        if enabled {
            compositingGroup()
        } else {
            self
        }
    }
}

private struct CalendarDay: Identifiable {
    let date: Date
    let isCurrentMonth: Bool
    let isSelected: Bool
    let isToday: Bool
    let entries: [LedgerEntry]
    let expense: Double
    let income: Double
    let primaryCategory: String?

    var id: Date { date }

    init(date: Date, isCurrentMonth: Bool, isSelected: Bool, isToday: Bool, entries: [LedgerEntry]) {
        self.date = date
        self.isCurrentMonth = isCurrentMonth
        self.isSelected = isSelected
        self.isToday = isToday
        self.entries = entries
        self.expense = entries
            .lazy
            .filter { $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)
        self.income = entries
            .lazy
            .filter { $0.kind == .income }
            .map(\.amount)
            .reduce(0, +)
        self.primaryCategory = entries.max(by: { $0.amount < $1.amount })?.category
    }
}

private struct CalendarLedgerSnapshot {
    let monthDays: [CalendarDay]
    let selectedEntries: [LedgerEntry]
    let monthEntryCount: Int
    let monthExpense: Double
    let activeDays: Int

    static let empty = CalendarLedgerSnapshot(
        monthDays: [],
        selectedEntries: [],
        monthEntryCount: 0,
        monthExpense: 0,
        activeDays: 0
    )
}

private struct CalendarContentWidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 1200

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

private extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components) ?? self
    }

    var endOfMonth: Date {
        let calendar = Calendar.current
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) ?? startOfMonth
        return calendar.date(byAdding: .day, value: -1, to: nextMonth) ?? startOfMonth
    }
}

private extension Double {
    var currencyText: String {
        formatted(.currency(code: "CNY").precision(.fractionLength(0...2)))
    }

    var editingAmountText: String {
        formatted(.number.precision(.fractionLength(0...2)).grouping(.never))
    }

    var compactCurrencyText: String {
        if self >= 10_000 {
            return "¥\(formatted(.number.precision(.fractionLength(0...1))))"
        }
        return formatted(.currency(code: "CNY").precision(.fractionLength(0...0)))
    }
}

#Preview {
    ContentView()
}
