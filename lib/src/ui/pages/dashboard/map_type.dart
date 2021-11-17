import 'package:shared_preferences/shared_preferences.dart';

class TyperMaps{
  void typerMaps() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("TyperMap", 0);
  }
}