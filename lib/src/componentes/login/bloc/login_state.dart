part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class AutenticandoState extends LoginState {

  final Usuario      usuario;
  final StatusLogin  registro;
  final List<Ciudad> ciudades;

  AutenticandoState({this.usuario,this.registro,this.ciudades});
  factory AutenticandoState.initial(List<Ciudad> ciudadesList)=>
          AutenticandoState(
          usuario: Usuario(
                   cedula   : '',
                   email    : '',
                   nombre   : '',
                   password : '',
                   idGoogle : '',
                   ciudad   : Ciudad(ciudad:'',ruta: '') 
                   ),
          registro: StatusLogin.inicial,
          ciudades: ciudadesList
        );

  AutenticandoState copyWith({Usuario usuario,StatusLogin  registro})
  => AutenticandoState(
     usuario  : usuario  ??  this.usuario,
     registro : registro ??  this.registro,
     ciudades : ciudades ??  this.ciudades 
     );

  @override
  List<Object> get props => [usuario,registro,ciudades];
}



class AutenticadoState extends LoginState {
  final Usuario usuario;
  AutenticadoState({this.usuario});
  @override
  List<Object> get props => [usuario];
}
class InitialState extends LoginState {}

