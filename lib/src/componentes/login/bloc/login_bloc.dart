import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:panchita/src/componentes/login/data/firebase_auth.dart';
import 'package:panchita/src/componentes/login/data/login_repocitorio.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/login/models/status_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/plugins/internet_check.dart';
import 'package:panchita/src/plugins/push_notifications.dart';
import 'package:panchita/src/plugins/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthService auth = AuthService();
  final prefs = PreferenciasUsuario();
  final push = PushNotificatios();
  List<Ciudad> ciudades;
  String token;
  LoginRepocitorio repo;

  LoginBloc({this.repo}) : super(InitialState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is RegistroGoogleEvent) yield* _registroGoogle(state);
    if (event is FinishRegistroGoogleEvent) yield* _finishregistroGoogle(event);
    if (event is AuthGoogleEvent) yield* _authGoogle(state);
    if (event is AuthEvent) yield* _auth(event, state);
    if (event is RegistroEvent) yield* _registro(event, state);
    if (event is VericarLoginEvent) yield* _verificarLogin(state);
    if (event is EditUsuarioEvent) yield* _editUsuario(event, state);
    if (event is LogOutEvent) yield* _logOut(event, state);
    if (event is ChangeRutaEvent) yield* _changeRuta(event, state);
  }

  Stream<LoginState> _registroGoogle(AutenticandoState state) async* {
    final usuario = await auth.signInGoogle();
    if (usuario.idGoogle == null) {
      yield state.copyWith(usuario: usuario, registro: StatusLogin.error);
      yield state.copyWith(usuario: usuario, registro: StatusLogin.inicial);
    } else if (usuario.idGoogle == '') {
      if (await auth.singOutGoogle()) {
        yield state.copyWith(usuario: usuario, registro: StatusLogin.duplicado);
        yield state.copyWith(usuario: usuario, registro: StatusLogin.inicial);
      }
    } else {
      yield state.copyWith(usuario: usuario, registro: StatusLogin.registrado);
      yield state.copyWith(usuario: usuario, registro: StatusLogin.inicial);
      repo.setUsuario(usuario);
      prefs.token = usuario.idGoogle;
    }
  }

  Stream<LoginState> _finishregistroGoogle(
      FinishRegistroGoogleEvent event) async* {
    repo.updateUsuario(event.usuario);
    yield AuthenticationSuccessState(usuario: event.usuario);
  }

  Stream<LoginState> _authGoogle(AutenticandoState state) async* {
    final uid = await auth.authGoogle();
    if (uid == "ERROR_NO_AUTH") {
      yield state.copyWith(registro: StatusLogin.error);
      yield state.copyWith(registro: StatusLogin.inicial);
    } else if (uid == "NO_REGISTRADO") {
      if (await auth.singOutGoogle()) {
        yield state.copyWith(registro: StatusLogin.no_registrado);
        yield state.copyWith(registro: StatusLogin.inicial);
      }
    } else {
      final usuario = await repo.getUsuario(uid);

      if (usuario.cedula == null) {
        yield state.copyWith(
            usuario: usuario, registro: StatusLogin.incompleto);
        yield state.copyWith(usuario: usuario, registro: StatusLogin.inicial);
      } else {
        if (usuario.token == token)
          yield AuthenticationSuccessState(usuario: usuario);
        else {
          repo.updateToken(token, usuario.idGoogle);
          usuario.token = token;
          yield AuthenticationSuccessState(usuario: usuario);
        }
        prefs.token = usuario.idGoogle;
      }
    }
  }

  Stream<LoginState> _auth(AuthEvent event, AutenticandoState state) async* {
    final uid = await auth.auth(event.usuario.email, event.usuario.password);

    if (uid == "ERROR_WRONG_PASSWORD") {
      yield state.copyWith(registro: StatusLogin.incorrectos);
      yield state.copyWith(registro: StatusLogin.inicial);
    } else if (uid == "ERROR_USER_NOT_FOUND") {
      yield state.copyWith(registro: StatusLogin.no_registrado);
      yield state.copyWith(registro: StatusLogin.inicial);
    } else {
      final usuario = await repo.getUsuario(uid);
      if (usuario.token == token)
        yield AuthenticationSuccessState(usuario: usuario);
      else {
        repo.updateToken(token, usuario.idGoogle);
        usuario.token = token;
        yield AuthenticationSuccessState(usuario: usuario);
      }
      prefs.token = usuario.idGoogle;
      prefs.vendedor = usuario.vendedor;
    }
  }

  Stream<LoginState> _registro(
      RegistroEvent event, AutenticandoState state) async* {
    final uid = await auth.registro(event.usuario.email, event.usuario.password);
    if (uid == 'EXISTE') {
      yield state.copyWith(
          usuario: event.usuario, registro: StatusLogin.duplicado);
      yield state.copyWith(
          usuario: event.usuario, registro: StatusLogin.inicial);
    } else {
      event.usuario.idGoogle = uid;
      event.usuario.token = token;
      repo.setUsuario(event.usuario);
      yield state.copyWith(
          usuario: event.usuario, registro: StatusLogin.completo);
      yield state.copyWith(
          usuario: event.usuario, registro: StatusLogin.inicial);
    }
  }

  Stream<LoginState> _verificarLogin(LoginState state) async* {

    token         = await push.getoken();
    ciudades      = await repo.getCiudades();
    bool internet = await internetCheck();

    if (internet && prefs.token != '') {
      final usuario = await repo.getUsuario(prefs.token);
      yield AuthenticationSuccessState(usuario: usuario, ciudades: ciudades);
    }
    if (internet && prefs.token == '') {
      yield AutenticandoState.initial(ciudades);
    }
    if (!internet && prefs.vendedor) {
      final usuario = await repo.getUsuario(prefs.token);
      yield AuthenticationSuccessState(usuario: usuario, ciudades: ciudades);
    }
    if (!internet && !prefs.vendedor) {
      yield OfflineState();
    }

    /* if (await internetCheck()) {

      if (prefs.token != '') {
        final usuario = await repo.getUsuario(prefs.token);
        yield AutenticadoState(usuario: usuario, ciudades: ciudades);
      } else
        yield AutenticandoState.initial(ciudades);

    } else if (prefs.vendedor) {

      final usuario = await repo.getUsuario(prefs.token);
      yield AutenticadoState(usuario: usuario, ciudades: ciudades);

    } else
      yield OfflineState(); */
  }

  Stream<LoginState> _editUsuario(
      EditUsuarioEvent event, AuthenticationSuccessState state) async* {
    repo.updateUsuario(event.usuario);
    yield state.copyWith(usuario: event.usuario, edit: true);
    yield state.copyWith(edit: false);
  }

  Stream<LoginState> _logOut(LogOutEvent event, LoginState state) async* {
    await prefs.eraseall();
    auth.logOut();
    yield AutenticandoState.initial(ciudades);
  }

  Stream<LoginState> _changeRuta(
      ChangeRutaEvent event, AuthenticationSuccessState state) async* {
    state.usuario.ciudad.ruta = event.ruta;
    yield state.copyWith(usuario: state.usuario);
  }
}
