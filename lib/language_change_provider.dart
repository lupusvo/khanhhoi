import 'package:flutter/cupertino.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale _currentLocale = new Locale('vi');

  Locale get currentLocale => _currentLocale;

  void changeLocale(String _locale) {
    _currentLocale = new Locale(_locale);
    notifyListeners();
  }
}
