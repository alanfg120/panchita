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
 //prefs.eraseall();
 runApp(MyApp());
 //singOut();
}

class MyApp extends StatelessWidget {

 
  final push = PushNotificatios();
  
  final LoginRepocitorio    repologin      = LoginRepocitorio();
  final ProductoRepocitorio repoProductos  = ProductoRepocitorio();
  final PedidoRepositorio   repoPedido     = PedidoRepositorio();
  final ClientesRepositorio repoClientes   = ClientesRepositorio();

  @override
  Widget build(BuildContext context) {
    push.init();
 
    return MultiBlocProvider (
          providers: [
                      BlocProvider<LoginBloc>(
                      create: (context) => LoginBloc(repo:repologin)..add(VericarLoginEvent())
                      ),
                      BlocProvider<ProductosBloc>(
                      create: (context) => ProductosBloc(repo:repoProductos)..add(GetCategoriasEvent())
                                                                            ..add(GetProductosEvent())
                      ),
                      BlocProvider<PedidosBloc>(
                      create: (context) => PedidosBloc(repocitorio: repoPedido)
                      ),
                      BlocProvider<ClientesBloc>(
                      create: (context) => ClientesBloc(repositorio: repoClientes)
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
                                 textTheme  : TextTheme(headline1 : TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 25.0,
                                                                ))
                                 ),
                
          ),
          home   : BlocBuilder<LoginBloc,LoginState>(
                   builder:(context,state){
                    if(state is AutenticandoState)
                       return LoginPage();
                    if(state is AutenticadoState){
                       context.bloc<PedidosBloc>().add(
                          GetPedidosEvent(cedula: state.usuario.cedula)
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