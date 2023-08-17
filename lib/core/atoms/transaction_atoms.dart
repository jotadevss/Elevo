import 'package:asp/asp.dart';
import 'package:elevo/core/dto/input_transaction.dto.dart';
import 'package:elevo/core/dto/output_transaction.dto.dart';

// Atoms
final transactionState = Atom<List<OutputTransactionDTO>>([]);

// Actions
final loadTransactionAction = Atom.action();
final createTransactionAction = Atom<InputTransactionDTO?>(null);
final deleteTransactionAction = Atom<String?>(null);
