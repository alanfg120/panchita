

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/widgets/producto_card.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';

class SearchProductoPage extends StatefulWidget {
  SearchProductoPage({Key key}) : super(key: key);

  @override
  _SearchProductoPageState createState() => _SearchProductoPageState();
}

class _SearchProductoPageState extends State<SearchProductoPage> {
   final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           key    : _scaffoldKey,
           appBar : AppBar(
                    title: TextField(
                           style      : TextStyle(fontSize: 18),
                           //controller : controller,
                           autofocus  : true,
                           decoration : InputDecoration(
                                        hintText: "Buscar Producto",
                                        hintStyle: TextStyle(fontSize: 15),
                                        border: InputBorder.none
                                        ),
                           onChanged  : (value) {
                            context.bloc<ProductosBloc>().add(SearchProductoEvent(query: value));
                           } 
                    ),
                    actions: <Widget>[
                              _card()
                    ],
           ),
           body   : BlocBuilder<ProductosBloc,ProductosState>(
                    builder: (context,state){
                              if(state.resultSearch.length==0)
                                 return Center(child: Text("No hay resultados"));
                              else  return ListView.builder(
                                           itemCount: state.resultSearch.length,
                                           itemBuilder: (context,i){
                                                         return ProductoCard(
                                                                id: i,
                                                                producto: state.resultSearch[i],
                                                         );
                                           },
                                           );
                    }
           )
    );
  }


 

  Widget _card()
          => BlocBuilder<PedidosBloc,PedidosState>(
               builder    : (context,state)
               =>Badge (
               animationType : BadgeAnimationType.fade,
               showBadge     : state.productos.length == 0 ? false : true,
               badgeContent  : Text('${state.productos.length}',style: TextStyle(color: Colors.white)),
               position      : BadgePosition.topRight(right: 5,top: 2) ,
               badgeColor    : Colors.red,
               child         : IconButton(
                               icon           : Icon(CustomIcon.cart_outline,color: Colors.pink),
                               onPressed       : (){
                                    Navigator.pushNamed(context, 'carrito');
                               },
               ),
              ),
          );
}