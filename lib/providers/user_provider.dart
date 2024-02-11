import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void updateUser(User? user) {
    _user = user;
    notifyListeners();
  }
}
