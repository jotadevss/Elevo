import 'dart:math';

import 'package:asp/asp.dart';
import 'package:elevo/core/atoms/transaction_atoms.dart';
import 'package:elevo/core/dto/output_transaction.dto.dart';
import 'package:elevo/core/reducer/app_atom.dart';
import 'package:elevo/data/repositories/transaction_repository.dart';
import 'package:elevo/domain/entity/transaction.dart';

class TransactionReduce extends Reducer {
  TransactionReduce({required this.repository}) {
    on(() => [loadTransactionAction], loadTransaction);
    on(() => [createTransactionAction], addTransaction);
    on(() => [deleteTransactionAction], deleteTransactionById);
  }

  final ITransactionRepository repository;

  Future<void> loadTransaction() async {
    // Active loading state in UI
    isLoading.value = true;

    // Making the request the transaction in repository [SQL]
    final result = await repository.getAllTransactions();

    // Handling the response when request completed
    result.fold((transactions) {
      // Change transaction [Entity] to output transaction for UI [DTO]
      final dtos = List.generate(
        transactions.length,
        (i) => OutputTransactionDTO(
          id: transactions[i].id,
          value: transactions[i].value,
          type: transactions[i].type,
          category: transactions[i].category,
          createAt: transactions[i].createAt,
          frequency: transactions[i].frequency,
        ),
      );
      // Update the state for application
      transactionState.value = dtos;
    }, (_) => _);

    // Turn off the loading state in UI
    isLoading.value = false;
  }

  Future<void> addTransaction() async {
    // Active loading state in UI
    isLoading.value = true;

    // Taking the input transaction in action [DTO]
    final input = createTransactionAction.value!;

    // Creating the ID of transaction
    final id = (Random().nextDouble() * 1000).toString();

    // Convereting the [DTO] to [Entity] for add in Database
    final transaction = TransactionEntity(
      id: id,
      value: input.value,
      type: input.type,
      category: input.category,
      createAt: input.createAt,
      frequency: input.frequency,
    );

    // Making the add transaction request in Database
    final result = await repository.createTransaction(transaction);

    // Handling the response when request completed
    result.fold((_) => _, (error) {
      // Error handler here...
    });

    // Turn off the loading state in UI
    isLoading.value = false;
  }

  Future<void> deleteTransactionById() async {
    // Taking the id in action
    final id = deleteTransactionAction.value!;

    // Making the delete transaction request in Database
    final result = await repository.deleteTransaction(id);

    // Handling the response when request completed
    result.fold((_) => _, (error) {
      // Error handler here...
    });
  }
}
