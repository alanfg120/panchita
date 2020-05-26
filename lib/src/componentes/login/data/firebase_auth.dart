import 'package:firebase_auth/firebase_auth.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/plugins/firebase_service.dart';
import 'package:panchita/src/plugins/push_notifications.dart';
import 'package:panchita/src/plugins/sing_google.dart';

class AuthService {
   final push = PushNotificatios();

  Future<Usuario> signInGoogle() async {
    try {
      final user = await singGoogle();
      if (!await userExist('usuarios', user.uid)) {
         final token = await push.getoken();
        return Usuario(
            token    : token ,
            nombre   : user.displayName,
            idGoogle : user.uid,
            email    : user.email,
            ciudad   : Ciudad());
      }
      return Usuario(idGoogle: '');
    } catch (e) {
      return Usuario();
    }
  }

  Future<bool> singOutGoogle({FirebaseUser user}) async {
    try {
      singOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> authGoogle() async {
    try {
      final user = await singGoogle();
      if (await userExist('usuarios', user.uid))
        return user.uid;
      else
        return "NO_REGISTRADO";
    } catch (e) {
      print('errorUser : $e');
      return "ERROR_NO_AUTH";
    }
  }

  Future<String> registro(String email, String password) async {
    final uid = await singIn(email, password);
    if (await userExist('usuario', uid))
      return "EXISTE";
    else
      return uid;
  }

  Future<String> auth(String email, String password) async {
    return await logIn(email, password);
  }
  Future logOut() async {
    return  singOut();
  }

  
}
