import 'package:asp/asp.dart';
import 'package:elevo/src/app.dart';
import 'package:elevo/src/binds.dart';
import 'package:flutter/material.dart';

void main() async {
  reducers;
  controllers;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const RxRoot(child: Elevo()),
  );
}
