import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';

class SnackbarController extends SimpleNotifier {
  final _key = GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get key => _key;

  void showSnackbar(SnackBar snackbar) {
    _key.currentState!.showSnackBar(
      snackbar,
    );
  }
}

final snackbarProvider =
    SimpleProvider((_) => SnackbarController(), autoDispose: false);
