import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/dto/pie_chart_dto.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/category_logic.dart';
import 'package:elevo/src/core/logic/transaction/expenses_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Atoms
final overviewSectionsAtom = Atom<List<PieChartSectionData>>([]);
final overviewDtoAtom = Atom<List<PieChartDTO>>([]);

final incomesSectionsAtom = Atom<List<PieChartSectionData>>([]);
final incomesDtoAtom = Atom<List<PieChartDTO>>([]);

final expensesSectionAtom = Atom<List<PieChartSectionData>>([]);
final expensesDtosAtom = Atom<List<PieChartDTO>>([]);

// Actions
final loadOverviewDashboardAction = Atom.action();
final loadIncomesDashboardAction = Atom.action();
final loadExpensesDashboardAction = Atom.action();

class DashboardLogic extends Reducer {
  DashboardLogic() {
    on(() => [loadOverviewDashboardAction], loadOverviewDashboard);
    on(() => [loadIncomesDashboardAction], loadIncomesDashboard);
    on(() => [loadExpensesDashboardAction], loadExpensesDashboard);
  }

  void _generateOverviewDtos() {
    // Creates a list of PieChartDTO objects for the overview dashboard.
    //
    // The PieChartDTO objects represent the different types of transactions
    // and their respective values.
    final dtoList = [
      PieChartDTO(
        id: TypeTransaction.income.name,
        color: kPrimaryColor,
        percent: 0,
        label: "Incomes",
        value: IncomesTransactions.totalCurrentMonthIncomesValue,
      ),
      PieChartDTO(
        id: TypeTransaction.expense.name,
        color: kSecondaryColor,
        percent: 0,
        label: "Expenses",
        value: ExpensesTransactions.totalCurrentMonthExpensesValue,
      ),
    ];

    // Sorts the PieChartDTO objects in descending order by value.
    dtoList.sort((a, b) => a.value.compareTo(b.value));

    // Updates the overviewDtoAtom with the sorted PieChartDTO objects.
    overviewDtoAtom.value = dtoList.reversed.toList();
  }

  void _generateIncomesDtos() {
    // This function generates a list of PieChartDTO objects for the incomes categories.
    // Generates a list of PieChartDTO objects, one for each incomes category.
    final dotList = List<PieChartDTO>.generate(getIncomesCategories.length, (index) {
      // Gets the title the current incomes category
      final labelCategory = getIncomesCategories[index].title;

      // Gets the ID of the current incomes category.
      final categoryId = getIncomesCategories[index].id;

      // Gets the list of incomes transactions for the current incomes category.
      final transactions = IncomesTransactions.currentMonthIncomes.where((tr) => tr.category == categoryId).toList();

      // Calculates the total amount of incomes for the current incomes category.
      final totalAmount = transactions.fold(0.0, (previousValue, transaction) => previousValue + transaction.value).roundToDouble();

      // Gets the color for the current incomes category.
      final color = chartColors[index];

      // Creates a PieChartDTO object for the current incomes category.
      final pieChartDto = PieChartDTO(
        label: labelCategory,
        id: categoryId,
        color: color,
        value: totalAmount,
        percent: calcPercent(IncomesTransactions.totalCurrentMonthIncomesValue, totalAmount).isNaN
            ? 0
            : calcPercent(IncomesTransactions.totalCurrentMonthIncomesValue, totalAmount).round(),
      );

      // Returns the PieChartDTO object.
      return pieChartDto;
    });

    dotList.sort((a, b) => a.value.compareTo(b.value));
    incomesDtoAtom.value = dotList.reversed.toList();
  }

  void _generateExpensesDtos() {
    // This function generates a list of PieChartDTO objects for the expenses categories.
    // Generates a list of PieChartDTO objects, one for each expenses category.
    final dtoList = List<PieChartDTO>.generate(getExpensesCategories.length, (index) {
      // Gets the title the current expenses category
      final labelCategory = getExpensesCategories[index].title;

      // Gets the ID of the current expenses category.
      final categoryId = getExpensesCategories[index].id;

      // Gets the list of expenses transactions for the current expenses category.
      final transactions = ExpensesTransactions.currentMonthExpenses.where((tr) => tr.category == categoryId).toList();

      // Calculates the total amount of expenses for the current expenses category.
      final totalAmount = transactions.fold(0.0, (previousValue, transaction) => previousValue + transaction.value).roundToDouble();

      // Gets the color for the current expenses category.
      final color = chartColors[index];

      // Creates a PieChartDTO object for the current expenses category.
      final pieChartDto = PieChartDTO(
        label: labelCategory,
        id: categoryId,
        color: color,
        value: totalAmount,
        percent: calcPercent(ExpensesTransactions.totalCurrentMonthExpensesValue, totalAmount).isNaN
            ? 0
            : calcPercent(ExpensesTransactions.totalCurrentMonthExpensesValue, totalAmount).round(),
      );

      // Returns the PieChartDTO object.
      return pieChartDto;
    });

    dtoList.sort((a, b) => a.value.compareTo(b.value));
    expensesDtosAtom.value = dtoList.reversed.toList();
  }

  void loadOverviewDashboard() {
    // Starts the loading indicator.
    startLoadingAction.call();

    // Generates a list of PieChartDTO objects for the overview dashboard.
    _generateOverviewDtos();

    // Creates a list of PieChartSectionData objects, one for each PieChartDTO object.
    final sectionList = overviewDtoAtom.value
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          // Calculates the percentage of the total transactions for the given transaction type.
          final value = (data.id == TypeTransaction.income.name)
              ? calcPercent(totalTransactionsValue, IncomesTransactions.totalCurrentMonthIncomesValue).round()
              : calcPercent(totalTransactionsValue, ExpensesTransactions.totalCurrentMonthExpensesValue).round();

          // Updates the PieChartDTO object with the calculated percentage.
          final updatedValue = overviewDtoAtom.value[index].copyWith(percent: value.round());
          overviewDtoAtom.value[index] = updatedValue;

          // Creates a PieChartSectionData object for the PieChartDTO object.
          final section = PieChartSectionData(
            color: data.color,
            radius: 12,
            titleStyle: TextStyle(color: Colors.transparent),
            value: value.toDouble(),
          );
          return MapEntry(index, section);
        })
        .values
        .toList();

    // Updates the overviewSectionsAtom with the list of PieChartSectionData objects.
    overviewSectionsAtom.value = sectionList;

    // Stops the loading indicator.
    stopLoadingAction.call();
  }

  void loadIncomesDashboard() {
    // Starts the loading indicator.
    startLoadingAction.call();

    // Generates a list of PieChartDTO objects for the incomes dashboard.
    _generateIncomesDtos();

    // Creates a list of PieChartSectionData objects, one for each PieChartDTO object.
    final sectionList = incomesDtoAtom.value
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          // Gets the percentage of the total incomes for the given income category.
          final value = data.percent;

          // Creates a PieChartSectionData object for the PieChartDTO object.
          final section = PieChartSectionData(
            color: data.color,
            radius: 12,
            titleStyle: TextStyle(color: Colors.transparent),
            value: value.toDouble(),
          );
          return MapEntry(index, section);
        })
        .values
        .toList();

    // Updates the incomesSectionsAtom with the list of PieChartSectionData objects.
    incomesSectionsAtom.value = sectionList;

    // Stops the loading indicator.
    stopLoadingAction.call();
  }

  void loadExpensesDashboard() {
    // Starts the loading indicator.
    startLoadingAction.call();

    // Generates a list of PieChartDTO objects for the expenses dashboard.
    _generateExpensesDtos();

    // Creates a list of PieChartSectionData objects, one for each PieChartDTO object.
    final sectionList = expensesDtosAtom.value
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          // Gets the percentage of the total expenses for the given expense category.
          final value = data.percent;

          // Creates a PieChartSectionData object for the PieChartDTO object.
          final section = PieChartSectionData(
            color: data.color,
            radius: 12,
            titleStyle: TextStyle(color: Colors.transparent),
            value: value.toDouble(),
          );
          return MapEntry(index, section);
        })
        .values
        .toList();

    // Updates the expensesSectionAtom with the list of PieChartSectionData objects.
    expensesSectionAtom.value = sectionList;

    // Stops the loading indicator.
    stopLoadingAction.call();
  }

  double calcPercent(double totalAmount, double value) {
    // Calculates the percentage of `value` relative to `totalAmount`.
    //
    // Args:
    //   totalAmount: The total value.
    //   value: The value to calculate the percentage of.
    //
    // Returns:
    //   The percentage of `value` relative to `totalAmount`.

    return (value / totalAmount) * 100;
  }
}
