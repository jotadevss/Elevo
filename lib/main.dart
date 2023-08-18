import 'package:asp/asp.dart';
import 'package:elevo/src/core/reducer/reducer.dart';
import 'package:elevo/src/core/reducer/transaction_reduce.dart';
import 'package:elevo/src/data/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';

void main() {
  Reducers(reducers: [
    TransactionReduce(repository: TransactionRepositoryImpl()),
  ]);

  runApp(
    const RxRoot(child: Elevo()),
  );
}

class Elevo extends StatelessWidget {
  const Elevo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
