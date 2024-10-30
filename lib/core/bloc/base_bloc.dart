import 'package:flutter/material.dart';
import 'package:pokedex/core/locator.dart';
import 'package:pokedex/core/service/dialog_service.dart';

class BaseBloc with ChangeNotifier {
  var state;
  var isLoading = false;
  var dialogService = locator<DialogService>();

  BaseBloc({this.isLoading = false, this.state});

  initState(initialState) {
    state = initialState;
  }

  refresh() {
    notifyListeners();
  }

  changeState(state) {
    state = state;
    notifyListeners();
  }

  setLoading(isLoading) {
    if (isLoading != isLoading) {
      isLoading = isLoading;
    }
    notifyListeners();
  }

  isNullOrEmpty(String? val) {
    return val == null || val.length == 0;
  }
}
