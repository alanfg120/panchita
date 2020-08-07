import 'package:flutter/material.dart';
import 'package:panchita/src/componentes/clientes/vistas/buscar_cliente_page.dart';
import 'package:panchita/src/componentes/clientes/vistas/cretate_client_page.dart';
import 'package:panchita/src/componentes/login/vistas/editUser_page.dart';
import 'package:panchita/src/componentes/login/vistas/finishRegistro_page.dart';
import 'package:panchita/src/componentes/login/vistas/login_page.dart';
import 'package:panchita/src/componentes/login/vistas/registro_page.dart';
import 'package:panchita/src/componentes/login/vistas/ruta_change_page.dart';
import 'package:panchita/src/componentes/login/vistas/userSetting_page.dart';
import 'package:panchita/src/componentes/pedidos/vistas/compra_page.dart';
import 'package:panchita/src/componentes/pedidos/vistas/pedidos_page.dart';
import 'package:panchita/src/componentes/productos/vistas/producto_page.dart';
import 'package:panchita/src/componentes/productos/vistas/search_producto_page.dart';



Map<String, WidgetBuilder> route() {
  
  return <String, WidgetBuilder>{
   'login'           : (context) => LoginPage(),
   'registro'        : (context) => RegistroPage(),
   'finish'          : (context) => FinishRegistroPage(),
   //'home'            : (context) => HomePage(),
   'producto'        : (context) => ProductoPage(),
   'carrito'         : (context) => CompraPage(),
   'buscar_producto' : (context) => SearchProductoPage(),
   'pedidos'         : (context) => PedidosPage(),
   'setting'         : (context) => UserSettingPage(),
   'editdatos'       : (context) => EditUserPage(),
   'change_ruta'     : (context) => ChangeRutaPage(),
   'create_cliente'  : (context) => CreateClientePage(),
   'buscar_cliente'  : (context) => BuscarClientePage()
    
    };
}
