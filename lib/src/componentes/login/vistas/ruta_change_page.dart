import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';

class ChangeRutaPage extends StatefulWidget {
  ChangeRutaPage({Key key}) : super(key: key);

  @override
  _ChangeRutaPageState createState() => _ChangeRutaPageState();
}

class _ChangeRutaPageState extends State<ChangeRutaPage> {
  int select = -1;
  @override
  Widget build(BuildContext context) {
       final state = context.bloc<LoginBloc>().state;
       if(state is AuthenticationSuccessState)
           select = int.parse(state.usuario.ciudad.ruta);
    return Scaffold(
           appBar: AppBar(
                   title: Text("Escoje la Ruta",style: TextStyle(color:Colors.black)),
           
           ),
           body: ListView(
                 children: <Widget>[
                           ListTile(
                           title: Text('Ruta 1'),
                           trailing: Radio(
                                     value      : 1, 
                                     groupValue : select, 
                                     onChanged  : (value)=>_changeRadioButton(value),
                                     activeColor: Colors.pink,
                                     )
                           ),
                           ListTile(
                           title: Text('Ruta 2'),
                           trailing: Radio(
                                     value      : 2, 
                                     groupValue : select, 
                                     onChanged  : (value)=>_changeRadioButton(value),
                                     activeColor: Colors.pink,
                                     )
                           ),
                           ListTile(
                           title: Text('Ruta 3'),
                           trailing: Radio(
                                     value      : 3, 
                                     groupValue : select, 
                                     onChanged  : (value)=>_changeRadioButton(value),
                                     activeColor: Colors.pink,
                                     )
                           )
                 ],
           ),
    );
}

 void  _changeRadioButton(int value) {
       setState(() {
          select = value;
       });
       BlocProvider.of<LoginBloc>(context).add(
         ChangeRutaEvent(ruta:value.toString())
       ); 
  }
}