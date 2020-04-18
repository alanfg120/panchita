part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistroGoogleEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
class FinishRegistroGoogleEvent extends LoginEvent {
  final Usuario usuario;
  FinishRegistroGoogleEvent({this.usuario});
  @override
  List<Object> get props => [usuario];
}

class AuthEvent extends LoginEvent {
  final Usuario usuario;
  AuthEvent({this.usuario});
  @override
  List<Object> get props => [usuario];
}
class AuthGoogleEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class RegistroEvent extends LoginEvent {
  final Usuario usuario;
  RegistroEvent({this.usuario});
  @override
  List<Object> get props => [usuario];
}
class GetCiudadesEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LogOutEvent extends LoginEvent{}

class VericarLoginEvent extends LoginEvent{}