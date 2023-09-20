import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/dto/pie_chart_dto.dart';
import 'package:elevo/src/core/logic/category_logic.dart';
import 'package:elevo/src/core/logic/transaction/expenses_logic.dart';
import 'package:elevo/src/core/logic/transaction/incomes_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Atoms
final overviewSectionsAtom = Atom<List<PieChartSectionData>>([]);
final overviewDtoAtom = Atom<List<PieChartDTO>>([
  PieChartDTO(id: TypeTransaction.income.name, color: kPrimaryColor, percent: 0),
  PieChartDTO(id: TypeTransaction.expense.name, color: kSecondaryColor, percent: 0),
]);

final incomesSectionsAtom = Atom<List<PieChartSectionData>>([]);
final incomesDtoAtom = Atom<List<PieChartDTO>>([]);

final expensesSectionAtom = Atom<List<PieChartSectionData>>([]);
final expensesDtosAtom = Atom<List<PieChartDTO>>([]);

// Actions
final loadDashboardAction = Atom.action();

class DashboardLogic extends Reducer {
  DashboardLogic() {
    on(() => [loadDashboardAction], loadDashboard);
  }

  void loadDashboard() {
    loadOverviewDashboard();
  }

  void _generateIncomesDtos() {
    // This function generates a list of PieChartDTO objects for the incomes categories.
    // Generates a list of PieChartDTO objects, one for each incomes category.
    incomesDtoAtom.value = List<PieChartDTO>.generate(getIncomesCategories.length, (index) {
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
        id: categoryId,
        color: color,
        percent: calcPercent(IncomesTransactions.totalCurrentMonthIncomesValue, totalAmount).round(),
      );

      // Returns the PieChartDTO object.
      return pieChartDto;
    });
  }

  void _generateExpensesDtos() {
    // This function generates a list of PieChartDTO objects for the expenses categories.
    // Generates a list of PieChartDTO objects, one for each expenses category.
    expensesDtosAtom.value = List<PieChartDTO>.generate(getExpensesCategories.length, (index) {
      // Gets the ID of the current expenses category.
      final categoryId = getIncomesCategories[index].id;

      // Gets the list of expenses transactions for the current expenses category.
      final transactions = ExpensesTransactions.currentMonthExpenses.where((tr) => tr.category == categoryId).toList();

      // Calculates the total amount of expenses for the current expenses category.
      final totalAmount = transactions.fold(0.0, (previousValue, transaction) => previousValue + transaction.value).roundToDouble();

      // Gets the color for the current expenses category.
      final color = chartColors[index];

      // Creates a PieChartDTO object for the current expenses category.
      final pieChartDto = PieChartDTO(
        id: categoryId,
        color: color,
        percent: calcPercent(ExpensesTransactions.totalCurrentMonthExpensesValue, totalAmount).round(),
      );

      // Returns the PieChartDTO object.
      return pieChartDto;
    });
  }

  void loadOverviewDashboard() {
    overviewSectionsAtom.value = overviewDtoAtom.value
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = (data.id == TypeTransaction.income.name)
              ? calcPercent(totalTransactionsValue, IncomesTransactions.totalCurrentMonthIncomesValue)
              : calcPercent(totalTransactionsValue, ExpensesTransactions.totalCurrentMonthExpensesValue);

          final updatedValue = overviewDtoAtom.value[index].copyWith(percent: value.round());
          overviewDtoAtom.value[index] = updatedValue;

          final section = PieChartSectionData(
            color: data.color,
            radius: 12,
            titleStyle: TextStyle(color: Colors.transparent),
            value: value,
          );
          return MapEntry(index, section);
        })
        .values
        .toList();
  }

  void loadIncomesDashboard() {}

  double calcPercent(double totalAmount, double value) {
    return (value / totalAmount) * 100;
  }
}
