import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  bool loading = true;

  void changeLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
