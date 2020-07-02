import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/clientes/bloc/clientes_bloc.dart';
import 'package:panchita/src/componentes/clientes/data/clientes_repositorio.dart';
import 'package:panchita/src/componentes/home/vistas/home_page.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/data/login_repocitorio.dart';
import 'package:panchita/src/componentes/login/vistas/loading_page.dart';
import 'package:panchita/src/componentes/login/vistas/login_page.dart';
import 'package:panchita/src/componentes/login/vistas/offline_page.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/pedidos/data/pedidos_repocitorio.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/data/productos_repocitori.dart';
import 'package:panchita/src/plugins/bloc_delegate.dart';
import 'package:panchita/src/plugins/push_notifications.dart';
import 'package:panchita/src/plugins/rutas.dart';
import 'package:panchita/src/plugins/shared_preferences.dart';



void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 BlocSupervisor.delegate = SimpleBlocDelegate();
 final prefs = PreferenciasUsuario();
 await prefs.initPrefs();
 final LoginRepocitorio repologin = LoginRepocitorio();
 // ignore: close_sinks
 final LoginBloc loginbloc = LoginBloc(repo: repologin);
 
 loginbloc.firstWhere((state) => true).then((_) =>runApp(MyApp(loginbloc: loginbloc)));
 
 loginbloc.add(VericarLoginEvent());
 
 //singOut();
}

class MyApp extends StatelessWidget {

  final LoginBloc loginbloc;
  MyApp({@required this.loginbloc});

  final push = PushNotificatios();
   
 
  final ProductoRepocitorio repoProductos  = ProductoRepocitorio();
  final PedidoRepositorio   repoPedido     = PedidoRepositorio();
  final ClientesRepositorio repoClientes   = ClientesRepositorio();

  @override
  Widget build(BuildContext context) {
    push.init();
 
    return MultiBlocProvider (
          providers: [
                      BlocProvider<LoginBloc>.value(value: loginbloc),
                      BlocProvider<ProductosBloc>(
                      create: (context) => ProductosBloc(repo:repoProductos)..add(GetProductosEvent())
                      ),
                      BlocProvider<PedidosBloc>(
                      create: (context) => PedidosBloc(repocitorio: repoPedido)
                      ),
                      BlocProvider<ClientesBloc>(
                      create: (context) => ClientesBloc(repositorio: repoClientes)..add(GetClientesEvent())
                      ),
          ],
          child: MaterialApp(
        
          debugShowCheckedModeBanner: false,
          title: 'Panchita',
          theme: ThemeData(
                 iconTheme: IconThemeData(color: Colors.red),
                 appBarTheme   : AppBarTheme(
                                 elevation  : 0.0, 
                                 color      : Colors.white,
                                 brightness : Brightness.light,
                                 iconTheme  : IconThemeData(color:Colors.pink,size: 40), 
                                 textTheme  : TextTheme(title : TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 22.0,
                                                                ))
                                 ),
                
          ),
          home   : BlocBuilder<LoginBloc,LoginState>(
                   builder:(context,state){
                    if(state is AutenticandoState)
                       return LoginPage();
                    if(state is AutenticadoState){
                       context.bloc<PedidosBloc>().add(
                          GetPedidosEvent(cedula: state.usuario.cedula,vendedor:state.usuario.vendedor)
                       );
                       return HomePage();
                    }
                    if(state is OfflineState) 
                       return OfflinePage();
                       
                    return LoadingPage();
                  }
                  ),
          routes : route(),
          //initialRoute: 'login',
          ),
    );
  }
}