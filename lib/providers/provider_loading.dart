import 'package:flutter/material.dart';

class ProviderLoading extends ChangeNotifier {
  bool loading = false;

  void switchLoadingState(bool newValue) {
    loading = newValue;
    notifyListeners();
  }
}
