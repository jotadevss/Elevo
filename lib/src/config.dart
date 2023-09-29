import 'package:elevo/src/binds.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/auth_logic.dart';
import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> initializeConfigurations() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  reducers;
  controllers;
}

void verifyStatusApp() {
  startLoadingAction.call();
  verifyStatusAppAction.call();
  checkAuthAction.call();
  getAllTransactionAction.call();
  stopLoadingAction.call();
}
