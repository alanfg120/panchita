import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del token
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get vendedor {
    return _prefs.getBool('vendedor') ?? false;
  }

  set vendedor(bool value) {
    _prefs.setBool('vendedor', value);
  }

  eraseall()  async {
    try {
       await this._prefs.clear();
    } catch (e) {
      print(e);
    }
    
  }
}
