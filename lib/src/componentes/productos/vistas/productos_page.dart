import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';

import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/componentes/productos/widgets/producto_card.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({Key key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
 

  int selectCategoria = -1;
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: BlocBuilder<ProductosBloc, ProductosState>(
            builder: (context, state) => 
                     Column(
                     crossAxisAlignment : CrossAxisAlignment.start,
                     children           : <Widget>[
                                           Padding(
                                           padding : EdgeInsets.all(15.0),
                                           child   : Text(state.preferencia, style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
                                           ),
                                           _listCategorias(state.preferencias),
                                            Padding(
                                           padding : EdgeInsets.all(15.0),
                                           child   : Text("Productos", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
                                           ),
                                           _listProductos(state.productos)
                                          ]
                    )
        ),
        floatingActionButton: _card(),
    );
  }

  Widget _listCategorias(List categorias)
          => Container(
             margin: EdgeInsets.all(8),
             alignment: Alignment.center,
             height : 35,
             child  : ListView.builder(
                   
                      scrollDirection : Axis.horizontal,
                      itemCount       : categorias.length,
                      itemBuilder     : (context, index) 
                                        =>GestureDetector(
                                          child: Container(
                                                 height    : 72,
                                                 width     : 100,
                                                 alignment : Alignment.center,
                                                 margin    : EdgeInsets.only(left: 5),
                                                 decoration: BoxDecoration(
                                                             borderRadius: BorderRadius.circular(20),
                                                             color       : selectCategoria == index
                                                                           ? Colors.pink
                                                                           : Colors.white,
                                          
                                                 ),
                                                 child: Text(
                                                        categorias[index],
                                                        textAlign : TextAlign.center,
                                                        style     : TextStyle(
                                                                    color     : selectCategoria == index
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                    fontSize   : 12,
                                                                    fontWeight : FontWeight.w700
                                                        )

                                                 )
                                          ),
                                          onTap: ()=>
                                            setState(() {
                                                selectCategoria = index;
                                            })
                                          
                                        )
             ),
          );

  Widget _card()
          => BlocBuilder<PedidosBloc,PedidosState>(
               builder: (context,state)
               =>Badge (
               animationType : BadgeAnimationType.slide,
               showBadge     : state.productos.length == 0 ? false : true,
               badgeContent  : Text('${state.productos.length}',style: TextStyle(color: Colors.white)),
               position      : BadgePosition.topRight(right: 0) ,
               badgeColor    : Colors.red,
               child         : FloatingActionButton(
                               child           : Icon(CustomIcon.cart_outline,color: Colors.pink),
                               backgroundColor : Colors.white,
                               onPressed       : (){
                                    Navigator.pushNamed(context, 'carrito');
                               },
               ),
        ),
          );

  Widget _listProductos(List<Producto> productos) 
         =>Expanded(
           child: ListView.builder(
                  padding     : EdgeInsets.only(bottom: 40,top: 10),
                  itemCount   : productos.length,
                  itemBuilder : (context,index)
                                 => ProductoCard(
                                    id: index,
                                    producto: productos[index],
                                 )
                  )
           );
}
