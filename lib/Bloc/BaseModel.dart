import 'package:flutter/foundation.dart';

enum ViewState { busy, idle, noData, dataAvailable }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  bool _disposed = false;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
