import 'package:flutter/foundation.dart';

class HomeChangeNotifier extends ChangeNotifier {
  final bool _isChange = true;
  bool get isChange => _isChange;

  void notitfyHome() {
    notifyListeners();
  }
}
