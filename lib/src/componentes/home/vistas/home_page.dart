

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/home/widgets/menu_drawer_widget.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/componentes/login/vistas/userSetting_page.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';

import 'package:panchita/src/componentes/pedidos/vistas/pedidos_page.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/vistas/productos_page.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';
import 'package:panchita/src/plugins/push_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  void initState() {
    onmessage = push.onmessageStream.listen((data) {});
    onresume  = push.onresumeStream.listen((data) {});
    super.initState();
  }

  @override
  void dispose() {
     onmessage?.cancel();
     onresume?.cancel();
     super.dispose();
  }

  final push = PushNotificatios();
  StreamSubscription onmessage;
  StreamSubscription onresume;
  int currentIndex=0;
  Usuario usuario;
  @override
  Widget build(BuildContext context) {

  onmessage.onData((data) { 
    context.bloc<PedidosBloc>().add(
      ConfirmPedidoEvent(id: data['id'],mensaje: data['mensaje'])
    );
   }); 

   onresume.onData((data) { 
    context.bloc<PedidosBloc>().add(
      ConfirmPedidoEvent(id: data['id'],mensaje: data['mensaje'])
    );
   }); 

   final state = BlocProvider.of<LoginBloc>(context).state;
            if(state is AutenticadoState){
              usuario = state.usuario;
             }
     
    return Scaffold(  
           drawer              : _drawer(),
           
           appBar              : AppBar(
                                 actions: currentIndex == 0
                                          ? <Widget>[
                                           IconButton(
                                           icon      :Icon(Icons.search), 
                                           onPressed : (){
                                                        Navigator.pushNamed(context, 'buscar_producto');
                                           }
                                           ),
                                           IconButton(icon:Icon(CustomIcon.filter_menu_outline), onPressed:(){})
                                           ]
                                          : null,
                                 title  : _titulo()
           ),
           backgroundColor     : Colors.white,
           body                : _selectPage(currentIndex),
      
        
        
        
       
        );
  }

  Widget _selectPage(int page) {
         setState(()=>currentIndex = page);
         switch (currentIndex){
         
         case 0 : context.bloc<ProductosBloc>().add(GetCategoriasEvent());
                  return ProductosPage();
                  break;
         case 1 : context.bloc<ProductosBloc>().add(GetMarcasEvent());
                  return ProductosPage();
                  break;
         case 2 : return PedidosPage();
                  break;
         case 3 : return UserSettingPage();
                  break;

         default: return ProductosPage();
                  break;

         }

  }

Widget _drawer() {
  return Drawer(
         child: Container(
           color: Colors.white,
           child: ListView(
                  children: <Widget>[
                            _drawerHeader(),
                            ItemDrawer(
                            icono  : CustomIcon.format_list_checkbox,
                            titulo : "Categorias",
                            page   : 0,
                            ontap  : (page)=>_selectPage(page)
                            ),
                            ItemDrawer(
                            icono  : CustomIcon.tag_text_outline,
                            titulo : "Marcas",
                            page   : 1,
                            ontap  : (page)=>_selectPage(page)
                            ),
                            ItemDrawer(
                            icono  : CustomIcon.basket_outline,
                            titulo : "Tus Pedidos",
                            page   : 2,
                            ontap  : (page)=>_selectPage(page)
                            ),
                            ItemDrawer(
                            icono    : Icons.add_box,
                            titulo   : "Crear Productos",
                            page     : 4,
                            ontap    : (page)=>_selectPage(page),
                            activate : usuario.vendedor,
                            ),
                            ItemDrawer(
                            icono  : CustomIcon.cog_outline,
                            titulo : "Configuracion",
                            page   : 3,
                            ontap  : (page)=>_selectPage(page)
                            ),
                           ]
           ),
         ),
  );

}

  Widget _titulo() {
      if(currentIndex == 2)
         return Text("Tus Pedidos");
      if(currentIndex == 3)
         return Text("Configuracion");
      return null;
  }

 Widget _drawerHeader(){
        return    DrawerHeader(
                            child     :Align(
                                       child: Text("Bienvenido ${usuario.nombre}",style: TextStyle(color: Colors.white)),
                                       alignment: Alignment.bottomCenter,
                                       ),
                            decoration: BoxDecoration(
                                         gradient: LinearGradient(colors: [
                                         Colors.pink,
                                         Colors.pink[400],
                                         Colors.pink[300]
                                       ]),
                                        image: DecorationImage(image: AssetImage('assets/logo.png'),fit: BoxFit.cover)
                            ),
                            );

 }
}
