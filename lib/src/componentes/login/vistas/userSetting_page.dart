
import 'package:flutter/material.dart';


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
                   onTap: (){},
                   )
                 ],
           )
    );
  }

 

 
}