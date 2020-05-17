

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/componentes/pedidos/vistas/pedidos_page.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/vistas/productos_page.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  int currentIndex=0;
  Usuario usuario;
  @override
  Widget build(BuildContext context) {
   
   final state = BlocProvider.of<LoginBloc>(context).state;
            if(state is AutenticadoState)
               usuario = state.usuario;

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
                                 title  : currentIndex == 1
                                          ? Text("Tus pedidos")
                                          : null
           ),
           backgroundColor     : Colors.white,
           body                : _selectPage(),
      
        
        
        
       
        );
  }

  Widget _selectPage() {
         switch (currentIndex){
         
         case 0 : return ProductosPage();
                  break;
         case 1 : return PedidosPage();
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
                            DrawerHeader(
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
                            ),
                            ListTile(
                            leading : Icon(CustomIcon.format_list_checkbox,color: Colors.pink[300]),
                            title   : Text("Categorias"),
                            onTap   : (){
                              setState(() {
                                currentIndex = 0;
                              });
                              context.bloc<ProductosBloc>().add(
                                GetCategoriasEvent()
                              );
                              Navigator.pop(context);
                            },
                            ),
                            ListTile(
                            leading : Icon(CustomIcon.tag_text_outline,color: Colors.pink[300]),
                            title   : Text("Marcas"),
                            onTap   : (){
                              setState(() {
                                currentIndex = 0;
                              });
                               context.bloc<ProductosBloc>().add(
                                GetMarcasEvent()
                              );
                                Navigator.pop(context);
                            },
                            ),
                            ListTile(
                            leading : Icon(CustomIcon.basket_outline,color: Colors.pink[300]),  
                            title   : Text("Tus pedidos"),
                            onTap   : (){
                              setState(() {
                                currentIndex = 1;
                              });
                              Navigator.pop(context);
                            },
                            ),
                            ListTile(
                            leading : Icon(CustomIcon.cog_outline,color: Colors.pink[300]),  
                            title   : Text("Configuracion"),
                            onTap   : (){},
                            )
                  ]
           ),
         ),
  );

}
}
