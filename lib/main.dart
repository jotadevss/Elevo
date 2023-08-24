import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

void main() {
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
