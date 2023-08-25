import 'package:flutter/material.dart';

class AppRouter {
  static const String INITIAL_SCREEN_ROUTER = '/initial';
  static const String DELETED_SCREEN_ROUTER = '/deleted';
  static const String ERROR_SCREEN_ROUTER = '/error';
  static const String INPUT_SUCCESS_SCREEN_ROUTER = '/input-success';

  static Map<String, Widget Function(BuildContext)> routes = {
    INITIAL_SCREEN_ROUTER: (context) => Container(),
    DELETED_SCREEN_ROUTER: (context) => Container(),
    ERROR_SCREEN_ROUTER: (context) => Container(),
    INPUT_SUCCESS_SCREEN_ROUTER: (context) => Container(),
  };
}
