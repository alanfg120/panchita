import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/home/vistas/home_page.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/data/login_repocitorio.dart';
import 'package:panchita/src/componentes/login/vistas/login_page.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/pedidos/data/pedidos_repocitorio.dart';
import 'package:panchita/src/componentes/pedidos/vistas/compra_page.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/data/productos_repocitori.dart';
import 'package:panchita/src/componentes/productos/vistas/loading_page.dart';
import 'package:panchita/src/plugins/bloc_delegate.dart';
import 'package:panchita/src/plugins/rutas.dart';
import 'package:panchita/src/plugins/shared_preferences.dart';
import 'package:panchita/src/plugins/sing_google.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 BlocSupervisor.delegate = SimpleBlocDelegate();
final prefs = PreferenciasUsuario();
 await prefs.initPrefs();
 runApp(MyApp());
 singOut();
}

class MyApp extends StatelessWidget {
 
  final LoginRepocitorio   repologin       = LoginRepocitorio();
  final ProductoRepocitorio repoProductos  = ProductoRepocitorio();
  final PedidoRepositorio   repoPedido     = PedidoRepositorio();
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider (
          providers: [
                      BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(repo:repologin)..add(VericarLoginEvent()),
                      ),
                      BlocProvider<ProductosBloc>(
                      create: (context) => ProductosBloc(repo:repoProductos)..add(GetCategoriasEvent())
                                                                            ..add(GetMarcasEvent())
                                                                            ..add(GetProductosEvent())
                      ),
                      BlocProvider<PedidosBloc>(
                      create: (context) => PedidosBloc(repocitorio: repoPedido)
                      ),
                      
                     
                     ],
          child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          title: 'Panchita',
          theme: ThemeData(
                 iconTheme: IconThemeData(color: Colors.white),
                 appBarTheme   : AppBarTheme(
                                 elevation  : 0.0, 
                                 color      : Colors.white,
                                 brightness : Brightness.dark,
                                 iconTheme  : IconThemeData(color:Colors.red[400],size: 40), 
                                 textTheme  : TextTheme(title : TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 25.0,
                                                                ))
                                 ),
               
          ),
          home   : BlocBuilder<LoginBloc,LoginState>(
                  builder:(context,state){
                    if(state is AutenticandoState)
                       return LoginPage();
                   if(state is AutenticadoState)
                       return HomePage();
                     return LoadingPage();
                  }
                  ),
          routes : route(),
          //initialRoute: 'login',
          ),
    );
  }
}