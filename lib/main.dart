import 'package:asp/asp.dart';
import 'package:elevo/src/app.dart';
import 'package:elevo/src/binds.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  reducers;
  controllers;

  runApp(
    const RxRoot(child: Elevo()),
  );
}
