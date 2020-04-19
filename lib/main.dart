import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/data/login_repocitorio.dart';
import 'package:panchita/src/componentes/login/vistas/login_page.dart';
import 'package:panchita/src/plugins/bloc_delegate.dart';
import 'package:panchita/src/plugins/rutas.dart';
import 'package:panchita/src/plugins/sing_google.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 BlocSupervisor.delegate = SimpleBlocDelegate();
 runApp(MyApp());
 singOut();
}

class MyApp extends StatelessWidget {
 
  final LoginRepocitorio     repologin    = LoginRepocitorio();
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
          providers: [
                      BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(repo:repologin)..add(GetCiudadesEvent()),
                      ),
                      
                     
                     ],
          child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          title: 'Panchita',
          theme: ThemeData(
                 iconTheme: IconThemeData(color: Colors.purple),
                 appBarTheme   : AppBarTheme(
                                 elevation  : 0.0, 
                                 color      : Colors.purple[100],
                                 brightness : Brightness.dark,
                                 iconTheme  : IconThemeData(color:Colors.white,size: 40), 
                                 textTheme  : TextTheme(title : TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 25.0,
                                                                ))
                                 ),
               
          ),
          home   : LoginPage(),
          routes : route(),
          initialRoute: 'home',
          ),
    );
  }
}