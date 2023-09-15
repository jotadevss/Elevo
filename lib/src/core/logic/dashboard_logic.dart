import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/dto/pie_chart_dto.dart';
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

final incomesDtosAtom = Atom<List<PieChartDTO>>([]);
final expensesDtosAtom = Atom<List<PieChartDTO>>([]);

// Actions
final loadDashboardAction = Atom.action();

class DashboardReducer extends Reducer {
  DashboardReducer() {
    on(() => [loadDashboardAction], loadDashboard);
  }

  void loadDashboard() {
    loadOverviewDashboard();
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

  double calcPercent(double totalAmount, double value) {
    return (value / totalAmount) * 100;
  }
}
