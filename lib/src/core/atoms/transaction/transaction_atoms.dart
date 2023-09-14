import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/transaction/expenses_transaction.dart';
import 'package:elevo/src/core/atoms/transaction/incomes_transaction.dart';
import 'package:elevo/src/domain/entity/transaction.dart';

// Atoms
final cacheTransaction = Atom(<TransactionEntity>[]);
final selectedTransactionAtom = Atom<TransactionEntity?>(null);
final isEmptyTransactionState = Atom<bool>(false);

// Getters
List<TransactionEntity> get transactions => [...cacheTransaction.value];

int get totalTransactions => transactions.length;

double get totalBalance => (IncomesTransactions.totalIncomesValue - ExpensesTransactions.totalExpensesValue).roundToDouble();

bool get isNegative => totalBalance < 0;

// Actions
final getAllTransactionAction = Atom.action();
final getByIdTransactionAction = Atom<String?>(null);
final deleteTransactionAction = Atom<String?>(null);
