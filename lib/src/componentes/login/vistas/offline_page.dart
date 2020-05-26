import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';

class OfflinePage extends StatefulWidget {
  OfflinePage({Key key}) : super(key: key);

  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Center(
             child: Column(
                   mainAxisSize:  MainAxisSize.max,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text("No hay Conexion a Internet"),
                     SizedBox(height: 20),
                     RaisedButton(
                     color    : Colors.pink,
                     child    : Text("Reintentar",style: TextStyle(color: Colors.white)),
                     onPressed:(){
                       BlocProvider.of<LoginBloc>(context).add(
                          VericarLoginEvent()
                       );
                     }
                     )
                   ],
             ),
           )
    );
  }
}