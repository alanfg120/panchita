import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';



class UserSettingPage extends StatefulWidget {
  UserSettingPage({Key key}) : super(key: key);

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  Usuario usuario;
  @override
  Widget build(BuildContext context) {

    final state = context.bloc<LoginBloc>().state;
    if(state is AutenticadoState)
          usuario = state.usuario;

   return Scaffold(
           body: ListView(
                 children: <Widget>[
                   ListTile(
                   leading : Icon(Icons.edit),
                   title   : Text("Edita tus datos personales"),
                   subtitle: Text("Nombre,Ciudad..."),
                   onTap: ()=>Navigator.pushNamed(context, 'editdatos'),
                   ),
                   usuario.vendedor ?
                    ListTile(
                   leading : Icon(Icons.map),
                   title   : Text("Escojer Ruta"),
                   isThreeLine: true,
                   subtitle: Text("escoje la ruta para ajustar los precios     (solo vendedores)"),
                   onTap: ()=>Navigator.pushNamed(context, 'change_ruta'),
                   )
                   : Container(),
                   ListTile(
                   leading : Icon(Icons.power_settings_new),
                   title   : Text("Cerrar Sesion"),
                  
                   onTap: (){
                     context.bloc<LoginBloc>().add(
                      LogOutEvent()
                     );
                   //  Navigator.pushNamed(context, 'login');
                   },
                   ),
                 ],
           )
    );
  }

 

 
}