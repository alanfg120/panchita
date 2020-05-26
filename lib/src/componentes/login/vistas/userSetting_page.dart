


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';


class UserSettingPage extends StatefulWidget {
  UserSettingPage({Key key}) : super(key: key);

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {


  @override
  Widget build(BuildContext context) {
 
   return Scaffold(
           body: ListView(
                 children: <Widget>[
                   ListTile(
                   leading : Icon(Icons.edit),
                   title   : Text("Edita tus datos personales"),
                   subtitle: Text("Nombre,Ciudad..."),
                   onTap: ()=>Navigator.pushNamed(context, 'editdatos'),
                   ),
                   ListTile(
                   leading : Icon(Icons.power_settings_new),
                   title   : Text("Cerrar Sesion"),
                   onTap: (){
                     BlocProvider.of<LoginBloc>(context).add(
                       LogOutEvent()
                     );
                   },
                   )
                 ],
           )
    );
  }

 

 
}