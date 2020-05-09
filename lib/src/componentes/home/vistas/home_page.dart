
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/componentes/productos/vistas/productos_page.dart';

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
                                 actions: <Widget>[
                                           IconButton(icon:Icon(Icons.search), onPressed:(){}),
                                           IconButton(icon:Icon(Icons.dns ), onPressed:(){})
                                 ],
           ),
           backgroundColor     : Colors.white,
           body                : _selectPage(),
      
        
        
        
       
        );
  }

  Widget _selectPage() {
         switch (currentIndex){
         
         case 0 : return ProductosPage();
                  break;

         default: return ProductosPage();
                  break;

         }

  }

Widget _drawer() {
  return Drawer(
         child: Container(
           color: Colors.red,
           child: ListView(
                  children: <Widget>[
                            DrawerHeader(
                            child: Text("Bienvenido ${usuario.nombre}"),
                            ),
                            ListTile(title: Text("Categorias")),
                            ListTile(title: Text("Marcas")),
                            ListTile(title: Text("Tus pedidos")),
                            ListTile(title: Text("Configuracion"))
                  ]
           ),
         ),
  );

}
}
