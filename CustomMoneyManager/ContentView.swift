//
//  ContentView.swift
//  CustomMoneyManager
//
//  Created by windbylocus on 2026/5/18.
//

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
        case (.chinese, .budgets): return "预算"
        case (.english, .budgets): return "Budgets"
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
        case (.chinese, .week): return "周"
        case (.english, .week): return "Week"
        case (.chinese, .view): return "视图"
        case (.english, .view): return "View"
        case (.chinese, .previousMonth): return "上个月"
        case (.english, .previousMonth): return "Previous month"
        case (.chinese, .nextMonth): return "下个月"
        case (.english, .nextMonth): return "Next month"
        case (.chinese, .previousWeek): return "上一周"
        case (.english, .previousWeek): return "Previous week"
        case (.chinese, .nextWeek): return "下一周"
        case (.english, .nextWeek): return "Next week"
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
        case (.chinese, .budgetRemaining): return "预算剩余"
        case (.english, .budgetRemaining): return "Budget left"
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
        case (.chinese, .budgetSubtitle): return "设置总预算和各分类预算，实时跟踪支出进度。"
        case (.english, .budgetSubtitle): return "Set total and category budgets, then track spending progress."
        case (.chinese, .monthlyBudget): return "月度总预算"
        case (.english, .monthlyBudget): return "Monthly budget"
        case (.chinese, .used): return "已用"
        case (.english, .used): return "Used"
        case (.chinese, .remaining): return "剩余"
        case (.english, .remaining): return "Remaining"
        case (.chinese, .monthlyBudgetAmount): return "月预算金额"
        case (.english, .monthlyBudgetAmount): return "Monthly budget amount"
        case (.chinese, .categoryBudget): return "分类预算"
        case (.english, .categoryBudget): return "Category budgets"
        case (.chinese, .addCategory): return "添加分类"
        case (.english, .addCategory): return "Add category"
        case (.chinese, .emptyCategoryBudget): return "暂无分类预算，点右上角添加。"
        case (.english, .emptyCategoryBudget): return "No category budgets yet. Add one from the top right."
        case (.chinese, .adjustBudget): return "调整预算"
        case (.english, .adjustBudget): return "Edit budget"
        case (.chinese, .remove): return "移除"
        case (.english, .remove): return "Remove"
        case (.chinese, .adjustCategoryBudget): return "调整分类预算"
        case (.english, .adjustCategoryBudget): return "Edit category budget"
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
        case (.chinese, .deleteMonthData): return "删除月数据"
        case (.english, .deleteMonthData): return "Delete month data"
        case (.chinese, .deleteWeekData): return "删除周数据"
        case (.english, .deleteWeekData): return "Delete week data"
        case (.chinese, .confirmDeleteMonthTitle): return "删除本月数据？"
        case (.english, .confirmDeleteMonthTitle): return "Delete this month's data?"
        case (.chinese, .confirmDeleteWeekTitle): return "删除本周数据？"
        case (.english, .confirmDeleteWeekTitle): return "Delete this week's data?"
        case (.chinese, .confirmDeletePeriodMessage): return "此操作会删除当前范围内的全部账单记录，且无法撤销。"
        case (.english, .confirmDeletePeriodMessage): return "This will delete every entry in the current range and cannot be undone."
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
    case calendarLedger, transactions, budgets, reports, categoryManagement, settings
    case language, languageSubtitle
    case month, week, view, previousMonth, nextMonth, previousWeek, nextWeek, today, backToToday
    case emptyMonth, records, activeDays, days, monthlyExpense
    case income, expense, budgetRemaining, selectedDayExpense, entriesUnit
    case quickEntry, type, category, amountPlaceholder, note, save, dayDetails
    case emptyDay, emptyDayHint, invalidAmount, noRecords
    case transactionsSubtitle, newTransaction, filter, searchCategoryOrNote, emptyTransactions
    case budgetSubtitle, monthlyBudget, used, remaining, monthlyBudgetAmount
    case categoryBudget, addCategory, emptyCategoryBudget, adjustBudget, remove
    case adjustCategoryBudget, budgetAmount, cancel
    case reportsSubtitle, period, threeMonths, sixMonths, twelveMonths
    case monthlyIncomeExpense, monthAxis, amount, noData, thisMonthExpenseByCategory, noExpenseThisMonth
    case edit, delete, editEntry, categoryManagementSubtitle, emptyCategories, newCategoryName
    case add, entryCount, deleteCategory
    case deleteMonthData, deleteWeekData, confirmDeleteMonthTitle, confirmDeleteWeekTitle
    case confirmDeletePeriodMessage, deleteAllData, dataManagement, deleteAllDataHint
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
        .navigationSplitViewStyle(.balanced)
    }
}

private struct DetailHost: View {
    let selection: SidebarSection

    var body: some View {
        Group {
            switch selection {
            case .calendar:
                CalendarLedgerPage()
            case .transactions:
                TransactionsPage()
            case .budgets:
                BudgetsPage()
            case .reports:
                ReportsPage()
            case .categories:
                CategoriesManagementPage()
            case .preferences:
                SettingsPage()
            }
        }
        .transition(.opacity.combined(with: .scale(scale: 0.98)))
        .animation(.easeOut(duration: 0.2), value: selection)
    }
}

private enum SidebarSection: String, CaseIterable, Identifiable {
    case calendar
    case transactions
    case budgets
    case reports
    case categories
    case preferences

    static let primary: [SidebarSection] = [.calendar, .transactions]
    static let secondary: [SidebarSection] = [.budgets, .reports]
    static let settings: [SidebarSection] = [.categories, .preferences]

    var id: String { rawValue }

    func title(_ language: AppLanguage) -> String {
        switch self {
        case .calendar: return language.text(.calendarLedger)
        case .transactions: return language.text(.transactions)
        case .budgets: return language.text(.budgets)
        case .reports: return language.text(.reports)
        case .categories: return language.text(.categoryManagement)
        case .preferences: return language.text(.settings)
        }
    }

    var systemImage: String {
        switch self {
        case .calendar: return "calendar"
        case .transactions: return "list.bullet.rectangle"
        case .budgets: return "chart.pie"
        case .reports: return "chart.bar"
        case .categories: return "tag"
        case .preferences: return "gearshape"
        }
    }
}

private enum CalendarViewMode: String, CaseIterable {
    case month
    case week

    func title(_ language: AppLanguage) -> String {
        switch self {
        case .month: return language.text(.month)
        case .week: return language.text(.week)
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
    @State private var isHovering = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isHovering ? 1.02 : 1.0)
            .offset(y: isHovering ? -2 : 0)
            .animation(.easeOut(duration: 0.2), value: isHovering)
            .onHover { isHovering = $0 }
    }
}

private struct AnimatedProgressBar: View {
    let ratio: Double
    let tint: Color
    @State private var animatedRatio: Double = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(tint.opacity(0.15))
                RoundedRectangle(cornerRadius: 4)
                    .fill(tint)
                    .frame(width: geometry.size.width * animatedRatio)
            }
        }
        .frame(height: 6)
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                animatedRatio = ratio
            }
        }
        .onChange(of: ratio) { _, newValue in
            withAnimation(.easeOut(duration: 0.5)) {
                animatedRatio = newValue
            }
        }
    }
}

// MARK: - Calendar Ledger Page

private struct CalendarLedgerPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @State private var displayedMonth = Date().startOfMonth
    @State private var selectedDate = Date().startOfDay
    @State private var selectedKind: TransactionKind = .expense
    @State private var selectedCategory = "餐饮"
    @State private var amountText = ""
    @State private var noteText = ""
    @State private var viewMode: CalendarViewMode = .month
    @State private var contentWidth: CGFloat = 1200
    @State private var pageDirection = 1
    @State private var pageToken = 0
    @State private var snapshot = CalendarLedgerSnapshot.empty
    @State private var showingDeletePeriodAlert = false

    private let calendar = Calendar.current

    private var weekStart: Date {
        weekStart(for: selectedDate)
    }

    private func weekStart(for date: Date) -> Date {
        let weekday = calendar.component(.weekday, from: date)
        let mondayOffset = (weekday + 5) % 7
        return calendar.date(byAdding: .day, value: -mondayOffset, to: date)?.startOfDay ?? date.startOfDay
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                CalendarHeader(
                    displayedMonth: displayedMonth,
                    viewMode: $viewMode,
                    entryCount: snapshot.monthEntryCount,
                    activeDays: snapshot.activeDays,
                    monthExpense: snapshot.monthExpense,
                    weekRange: weekRangeLabel,
                    onPrevious: { movePeriod(by: -1) },
                    onNext: { movePeriod(by: 1) },
                    onDeletePeriod: { showingDeletePeriodAlert = true },
                    onToday: {
                        let nextMonth = Date().startOfMonth
                        let nextDate = Date().startOfDay
                        guard !calendar.isDate(selectedDate, inSameDayAs: nextDate) else {
                            return
                        }
                        pageDirection = calendar.compare(nextDate, to: selectedDate, toGranularity: .day) == .orderedAscending ? -1 : 1
                        withAnimation(.easeInOut(duration: 0.24)) {
                            displayedMonth = nextMonth
                            selectedDate = nextDate
                            refreshSnapshot(displayedMonth: nextMonth, selectedDate: nextDate)
                            pageToken += 1
                        }
                    }
                )

                CalendarSummaryStrip(
                    income: snapshot.monthIncome,
                    incomeCount: snapshot.incomeCount,
                    expense: snapshot.monthExpense,
                    expenseCount: snapshot.expenseCount,
                    budget: store.monthlyBudget,
                    selectedExpense: snapshot.selectedExpense,
                    selectedDate: selectedDate,
                    activeDays: snapshot.activeDays
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
        .onChange(of: selectedKind) { _, newValue in
            if !store.categories(for: newValue).contains(selectedCategory) {
                selectedCategory = store.defaultCategory(for: newValue)
            }
        }
        .alert(deletePeriodAlertTitle, isPresented: $showingDeletePeriodAlert) {
            Button(language.text(.delete), role: .destructive) {
                deleteCurrentPeriodEntries()
            }
            Button(language.text(.cancel), role: .cancel) {}
        } message: {
            Text(language.text(.confirmDeletePeriodMessage))
        }
    }

    private var weekRangeLabel: String {
        let endDate = calendar.date(byAdding: .day, value: 6, to: weekStart) ?? selectedDate
        let formatter = DateFormatter()
        formatter.locale = language.locale
        formatter.dateFormat = language == .chinese ? "M月d日" : "MMM d"
        let separator = language == .chinese ? "-" : " - "
        return "\(formatter.string(from: weekStart))\(separator)\(formatter.string(from: endDate))"
    }

    private var deletePeriodAlertTitle: String {
        viewMode == .month ? language.text(.confirmDeleteMonthTitle) : language.text(.confirmDeleteWeekTitle)
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
        ZStack {
            if viewMode == .month {
                CalendarBoard(days: snapshot.monthDays) { day in
                    select(day)
                }
            } else {
                WeekBoard(days: snapshot.weekDays) { day in
                    select(day)
                }
            }
        }
        .id("\(viewMode.rawValue)-\(pageToken)")
        .clipped()
        .compositingGroup()
        .transition(.asymmetric(
            insertion: .move(edge: pageDirection >= 0 ? .trailing : .leading).combined(with: .opacity),
            removal: .move(edge: pageDirection >= 0 ? .leading : .trailing).combined(with: .opacity)
        ))
        .animation(.easeInOut(duration: 0.24), value: pageToken)
        .animation(.easeInOut(duration: 0.18), value: viewMode)
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
            withAnimation(.easeInOut(duration: 0.24)) {
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
        let nextDisplayedMonth: Date
        let nextSelectedDate: Date

        switch viewMode {
        case .month:
            let target = calendar.date(byAdding: .month, value: value, to: displayedMonth) ?? displayedMonth
            let selectedDay = min(calendar.component(.day, from: selectedDate), calendar.range(of: .day, in: .month, for: target)?.count ?? 1)
            nextDisplayedMonth = target.startOfMonth
            nextSelectedDate = calendar.date(bySetting: .day, value: selectedDay, of: target)?.startOfDay ?? target.startOfDay
        case .week:
            let target = calendar.date(byAdding: .weekOfYear, value: value, to: weekStart) ?? selectedDate
            nextSelectedDate = target.startOfDay
            nextDisplayedMonth = target.startOfMonth
        }

        withAnimation(.easeInOut(duration: 0.24)) {
            displayedMonth = nextDisplayedMonth
            selectedDate = nextSelectedDate
            refreshSnapshot(displayedMonth: nextDisplayedMonth, selectedDate: nextSelectedDate)
            pageToken += 1
        }
    }

    private func deleteCurrentPeriodEntries() {
        let startDate: Date
        let endDate: Date

        switch viewMode {
        case .month:
            startDate = displayedMonth.startOfMonth
            endDate = calendar.date(byAdding: .month, value: 1, to: startDate) ?? startDate
        case .week:
            startDate = weekStart
            endDate = calendar.date(byAdding: .day, value: 7, to: startDate) ?? startDate
        }

        withAnimation(.easeOut(duration: 0.2)) {
            store.deleteEntries(from: startDate, to: endDate)
            refreshSnapshot(displayedMonth: displayedMonth, selectedDate: selectedDate)
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

        let monthIncome = monthEntries
            .lazy
            .filter { $0.kind == .income }
            .map(\.amount)
            .reduce(0, +)

        let monthExpense = monthEntries
            .lazy
            .filter { $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)

        let incomeCount = monthEntries.filter { $0.kind == .income }.count
        let expenseCount = monthEntries.filter { $0.kind == .expense }.count
        let activeDays = Set(monthEntries.map { calendar.startOfDay(for: $0.date) }).count
        let selectedDay = selectedDate.startOfDay
        let selectedEntries = entriesByDay[selectedDay] ?? []
        let selectedExpense = selectedEntries
            .lazy
            .filter { $0.kind == .expense }
            .map(\.amount)
            .reduce(0, +)

        return CalendarLedgerSnapshot(
            monthDays: makeMonthDays(entriesByDay: entriesByDay, displayedMonth: displayedMonth, selectedDate: selectedDate),
            weekDays: makeWeekDays(entriesByDay: entriesByDay, selectedDate: selectedDate),
            selectedEntries: selectedEntries,
            monthEntryCount: monthEntries.count,
            monthIncome: monthIncome,
            monthExpense: monthExpense,
            incomeCount: incomeCount,
            expenseCount: expenseCount,
            activeDays: activeDays,
            selectedExpense: selectedExpense
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

    private func makeWeekDays(entriesByDay: [Date: [LedgerEntry]], selectedDate: Date) -> [CalendarDay] {
        let startDate = weekStart(for: selectedDate)

        return (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: startDate) else {
                return nil
            }
            let day = date.startOfDay

            return CalendarDay(
                date: day,
                isCurrentMonth: true,
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
    @Binding var viewMode: CalendarViewMode
    let entryCount: Int
    let activeDays: Int
    let monthExpense: Double
    let weekRange: String
    let onPrevious: () -> Void
    let onNext: () -> Void
    let onDeletePeriod: () -> Void
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
            if viewMode == .month {
                Text(displayedMonth.formatted(.dateTime.year().month(.wide).locale(language.locale)))
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                Text(entryCount == 0 ? language.text(.emptyMonth) : "\(entryCount) \(language.text(.records)) · \(language.text(.activeDays)) \(activeDays) \(language.text(.days)) · \(language.text(.monthlyExpense)) \(monthExpense.currencyText)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                Text(weekRange)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                Text(displayedMonth.formatted(.dateTime.year().month(.wide).locale(language.locale)))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var controls: some View {
        HStack(spacing: 8) {
            Picker(language.text(.view), selection: $viewMode) {
                ForEach(CalendarViewMode.allCases, id: \.self) { mode in
                    Text(mode.title(language)).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 100)

            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
            }
            .buttonStyle(CalendarPageButtonStyle())
            .help(viewMode == .month ? language.text(.previousMonth) : language.text(.previousWeek))

            Button(action: onNext) {
                Image(systemName: "chevron.right")
            }
            .buttonStyle(CalendarPageButtonStyle())
            .help(viewMode == .month ? language.text(.nextMonth) : language.text(.nextWeek))

            Button(action: onToday) {
                Label(language.text(.today), systemImage: "dot.scope")
            }
            .help(language.text(.backToToday))

            Button(role: .destructive, action: onDeletePeriod) {
                Label(viewMode == .month ? language.text(.deleteMonthData) : language.text(.deleteWeekData), systemImage: "trash")
            }
            .help(viewMode == .month ? language.text(.deleteMonthData) : language.text(.deleteWeekData))
        }
        .controlSize(.regular)
    }
}

private struct CalendarPageButtonStyle: ButtonStyle {
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
            .scaleEffect(configuration.isPressed ? 0.88 : 1)
            .animation(.spring(response: 0.18, dampingFraction: 0.68), value: configuration.isPressed)
    }
}

private struct CalendarSummaryStrip: View {
    @Environment(\.appLanguage) private var language
    let income: Double
    let incomeCount: Int
    let expense: Double
    let expenseCount: Int
    let budget: Double
    let selectedExpense: Double
    let selectedDate: Date
    let activeDays: Int

    private var remainingBudget: Double {
        budget - expense
    }

    var body: some View {
        GlassPanel(cornerRadius: 20, shadowLevel: .card) {
            ViewThatFits(in: .horizontal) {
                HStack(spacing: 0) {
                    summaryItems
                }

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 8)], spacing: 8) {
                    summaryItemViews
                }
            }
        }
    }

    @ViewBuilder
    private var summaryItems: some View {
        CalendarSummaryItem(title: language.text(.income), value: income.compactCurrencyText, note: "\(incomeCount) \(language.text(.entriesUnit))", symbol: "arrow.down.left", tint: .green)
        summaryDivider
        CalendarSummaryItem(title: language.text(.expense), value: expense.compactCurrencyText, note: "\(expenseCount) \(language.text(.entriesUnit))", symbol: "arrow.up.right", tint: .orange)
        summaryDivider
        CalendarSummaryItem(title: language.text(.budgetRemaining), value: remainingBudget.compactCurrencyText, note: "\(language.text(.activeDays)) \(activeDays) \(language.text(.days))", symbol: "gauge.with.needle", tint: remainingBudget < 0 ? .red : .blue)
        summaryDivider
        CalendarSummaryItem(title: selectedDate.formatted(.dateTime.month().day().locale(language.locale)), value: selectedExpense.compactCurrencyText, note: language.text(.selectedDayExpense), symbol: "calendar", tint: .purple)
    }

    @ViewBuilder
    private var summaryItemViews: some View {
        CalendarSummaryItem(title: language.text(.income), value: income.compactCurrencyText, note: "\(incomeCount) \(language.text(.entriesUnit))", symbol: "arrow.down.left", tint: .green)
        CalendarSummaryItem(title: language.text(.expense), value: expense.compactCurrencyText, note: "\(expenseCount) \(language.text(.entriesUnit))", symbol: "arrow.up.right", tint: .orange)
        CalendarSummaryItem(title: language.text(.budgetRemaining), value: remainingBudget.compactCurrencyText, note: "\(language.text(.activeDays)) \(activeDays) \(language.text(.days))", symbol: "gauge.with.needle", tint: remainingBudget < 0 ? .red : .blue)
        CalendarSummaryItem(title: selectedDate.formatted(.dateTime.month().day().locale(language.locale)), value: selectedExpense.compactCurrencyText, note: language.text(.selectedDayExpense), symbol: "calendar", tint: .purple)
    }

    private var summaryDivider: some View {
        Rectangle()
            .fill(.secondary.opacity(0.14))
            .frame(width: 1, height: 42)
            .padding(.horizontal, 10)
    }
}

private struct CalendarSummaryItem: View {
    let title: String
    let value: String
    let note: String
    let symbol: String
    let tint: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.caption.weight(.bold))
                .foregroundStyle(tint)
                .frame(width: 28, height: 28)
                .background(tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Text(value)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                Text(note)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
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

private struct WeekBoard: View {
    @Environment(\.appLanguage) private var language
    let days: [CalendarDay]
    let onSelect: (CalendarDay) -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)

    private var weekdayTitles: [String] {
        language == .chinese ? ["周一", "周二", "周三", "周四", "周五", "周六", "周日"] : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }

    var body: some View {
        CalendarPanel(cornerRadius: 24) {
            VStack(spacing: 10) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(Array(zip(weekdayTitles, days)), id: \.1.id) { title, day in
                        VStack(spacing: 4) {
                            Text(title)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                            Text(day.date.formatted(.dateTime.day().locale(language.locale)))
                                .font(.title2.weight(.medium))
                                .foregroundStyle(day.isToday ? .blue : .primary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(day.isToday ? .green.opacity(0.10) : .secondary.opacity(0.05), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                }

                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(days) { day in
                        WeekDayCell(day: day)
                            .onTapGesture {
                                onSelect(day)
                            }
                    }
                }
            }
        }
    }
}

private struct WeekDayCell: View {
    @Environment(\.appLanguage) private var language
    let day: CalendarDay
    @State private var isHovering = false

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                if day.isToday {
                    Text(language.text(.today))
                        .font(.caption.weight(.bold))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(.green.opacity(0.16), in: Capsule())
                        .foregroundStyle(.green)
                }
                Spacer()
                if !day.entries.isEmpty {
                    Text("\(day.entries.count) \(language.text(.entriesUnit))")
                        .font(.caption2.weight(.semibold))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(.blue.opacity(day.isSelected ? 0.18 : 0.10), in: Capsule())
                        .foregroundStyle(day.isSelected ? .blue : .secondary)
                }
            }

            Spacer(minLength: 0)

            if day.expense > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.right")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                    Text(day.expense.compactCurrencyText)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.orange)
                    Spacer()
                }
            }

            if day.income > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.down.left")
                        .font(.caption2)
                        .foregroundStyle(.green)
                    Text("+\(day.income.compactCurrencyText)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.green)
                    Spacer()
                }
            }

            if day.expense == 0 && day.income == 0 {
                Text(language.text(.noRecords))
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }

            if let primaryCategory = day.primaryCategory {
                Text(primaryCategory)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 122, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(cellBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(cellBorder, lineWidth: day.isSelected ? 2 : 1)
        )
        .scaleEffect(isHovering ? 1.015 : 1)
        .offset(y: isHovering ? -1 : 0)
        .animation(.easeOut(duration: 0.16), value: isHovering)
        .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .onHover { isHovering = $0 }
    }

    private var cellBackground: AnyShapeStyle {
        if day.isSelected {
            return AnyShapeStyle(.blue.opacity(0.16))
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
        return .secondary.opacity(isHovering ? 0.24 : 0.12)
    }
}

private struct CalendarDayCell: View {
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
        .scaleEffect(isHovering ? 1.018 : 1)
        .offset(y: isHovering ? -1 : 0)
        .opacity(day.isCurrentMonth ? 1 : 0.42)
        .animation(.easeOut(duration: 0.16), value: isHovering)
        .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .onHover { isHovering = $0 }
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
                        .animation(.easeOut(duration: 0.18), value: date)

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

                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
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
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
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
        .animation(.spring(response: 0.28, dampingFraction: 0.82), value: entries.count)
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
}

private struct TransactionsPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
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
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
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
}

private struct BudgetsPage: View {
    @EnvironmentObject private var store: LedgerStore
    @Environment(\.appLanguage) private var language
    @State private var editingCategory: String?
    @State private var editingAmount = ""
    @State private var selectedBudgetCategory = ""
    @State private var budgetAmountText = ""

    private var month: Date { Date().startOfMonth }

    private var monthExpense: Double {
        store.totalExpense(in: Date())
    }

    private var budgetRatio: Double {
        min(monthExpense / max(store.monthlyBudget, 1), 1)
    }

    private var availableCategories: [String] {
        store.expenseCategories.filter { store.categoryBudgets[$0] == nil }
    }

    var body: some View {
        PageSurface {
            PageHeader(
                title: language.text(.budgets),
                subtitle: language.text(.budgetSubtitle),
                primaryActionTitle: "",
                primaryActionSymbol: "",
                secondaryActionTitle: "",
                secondaryActionSymbol: ""
            )

            GlassPanel(cornerRadius: 22) {
                VStack(alignment: .leading, spacing: 14) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(language.text(.monthlyBudget))
                                .font(.headline)
                            Text("\(language.text(.used)) \(monthExpense.currencyText)，\(language.text(.remaining)) \((store.monthlyBudget - monthExpense).currencyText)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        Text("\(Int(budgetRatio * 100))%")
                            .font(.title2.weight(.semibold))
                            .foregroundStyle(monthExpense > store.monthlyBudget ? .red : .blue)
                    }

                    AnimatedProgressBar(
                        ratio: budgetRatio,
                        tint: monthExpense > store.monthlyBudget ? .red : .blue
                    )

                    TextField(
                        language.text(.monthlyBudgetAmount),
                        value: Binding(
                            get: { store.monthlyBudget },
                            set: { store.updateMonthlyBudget($0) }
                        ),
                        format: .number.precision(.fractionLength(0...2))
                    )
                    .textFieldStyle(.roundedBorder)
                }
            }

            GlassPanel(cornerRadius: 22) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(language.text(.categoryBudget))
                            .font(.headline)

                        Spacer()

                        if !availableCategories.isEmpty {
                            Menu {
                                ForEach(availableCategories, id: \.self) { cat in
                                    Button(cat) {
                                        selectedBudgetCategory = cat
                                        budgetAmountText = ""
                                    }
                                }
                            } label: {
                                Label(language.text(.addCategory), systemImage: "plus")
                                    .font(.subheadline)
                            }
                            .menuStyle(.borderlessButton)
                            .fixedSize()
                        }
                    }
                    .padding(.bottom, 14)

                    if store.categoryBudgets.isEmpty {
                        Text(language.text(.emptyCategoryBudget))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                            .transition(.opacity)
                    } else {
                        ForEach(Array(store.categoryBudgets.keys.sorted()), id: \.self) { category in
                            let budget = store.categoryBudgets[category] ?? 0
                            let spent = store.categorySpending(category: category, in: month)
                            let ratio = min(spent / max(budget, 1), 1)

                            VStack(spacing: 8) {
                                HStack {
                                    Text(category)
                                        .font(.body.weight(.medium))

                                    Spacer()

                                    Text("\(spent.compactCurrencyText) / \(budget.compactCurrencyText)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)

                                    Button {
                                        editingCategory = category
                                        editingAmount = budget.editingAmountText
                                    } label: {
                                        Image(systemName: "pencil")
                                    }
                                    .buttonStyle(.borderless)
                                    .help(language.text(.adjustBudget))

                                    Button(role: .destructive) {
                                        store.setCategoryBudget(category: category, amount: 0)
                                    } label: {
                                        Image(systemName: "xmark.circle")
                                    }
                                    .buttonStyle(.borderless)
                                    .help(language.text(.remove))
                                }

                                AnimatedProgressBar(
                                    ratio: ratio,
                                    tint: spent > budget ? .red : .green
                                )
                            }
                            .padding(.vertical, 8)

                            if category != store.categoryBudgets.keys.sorted().last {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
        .sheet(item: Binding(
            get: { editingCategory.map { BudgetEditTarget(category: $0) } },
            set: { editingCategory = $0?.category }
        )) { target in
            VStack(alignment: .leading, spacing: 16) {
                Text("\(language.text(.adjustCategoryBudget)): \(target.category)")
                    .font(.title3.weight(.semibold))

                TextField(language.text(.budgetAmount), text: $editingAmount)
                    .textFieldStyle(.roundedBorder)
                    .onAppear {
                        editingAmount = (store.categoryBudgets[target.category] ?? 0).editingAmountText
                    }

                HStack {
                    Button(language.text(.cancel)) {
                        editingCategory = nil
                    }
                    .keyboardShortcut(.cancelAction)

                    Spacer()

                    Button(language.text(.save)) {
                        if let amount = Double(editingAmount.replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespacesAndNewlines)) {
                            store.setCategoryBudget(category: target.category, amount: amount)
                        }
                        editingCategory = nil
                    }
                    .buttonStyle(.borderedProminent)
                    .keyboardShortcut(.defaultAction)
                }
            }
            .padding(22)
            .frame(width: 340)
        }
        .onChange(of: selectedBudgetCategory) { _, category in
            guard !category.isEmpty else { return }
            store.setCategoryBudget(category: category, amount: 1000)
            selectedBudgetCategory = ""
        }
    }
}

private struct BudgetEditTarget: Identifiable {
    let category: String
    var id: String { category }
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
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.28), lineWidth: 1)
            )
            .shadow(color: .black.opacity(shadowLevel.opacity * 0.5), radius: 0.5, y: 0)
            .shadow(color: .black.opacity(shadowLevel.opacity * 0.7), radius: shadowLevel.radius * 0.5, y: shadowLevel.yOffset * 0.5)
            .shadow(color: .black.opacity(shadowLevel.opacity), radius: shadowLevel.radius, y: shadowLevel.yOffset)
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
    var body: some View {
        ZStack {
            Color(nsColor: .windowBackgroundColor)

            LinearGradient(
                colors: [
                    Color(nsColor: .controlAccentColor).opacity(0.08),
                    Color(nsColor: .windowBackgroundColor).opacity(0.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        .ignoresSafeArea()
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
    let weekDays: [CalendarDay]
    let selectedEntries: [LedgerEntry]
    let monthEntryCount: Int
    let monthIncome: Double
    let monthExpense: Double
    let incomeCount: Int
    let expenseCount: Int
    let activeDays: Int
    let selectedExpense: Double

    static let empty = CalendarLedgerSnapshot(
        monthDays: [],
        weekDays: [],
        selectedEntries: [],
        monthEntryCount: 0,
        monthIncome: 0,
        monthExpense: 0,
        incomeCount: 0,
        expenseCount: 0,
        activeDays: 0,
        selectedExpense: 0
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
