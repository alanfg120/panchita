import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/componentes/productos/widgets/producto_card.dart';

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
                                           child   : Text("Categorias", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
                                           ),
                                           _listCategorias(state.categorias),
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
                                                                           ? Colors.red
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
          => Badge (
             animationType : BadgeAnimationType.slide,
             showBadge     : true,
             badgeContent  : Text("2",style: TextStyle(color: Colors.red)),
             position      :BadgePosition.topRight(right: 0) ,
             badgeColor    : Colors.white,
             child         : FloatingActionButton(
                             child           : Icon(Icons.shopping_cart),
                             backgroundColor : Colors.red,
                             onPressed       :(){},
             ),
        );

  Widget _listProductos(List<Producto> productos) 
         =>Expanded(
           child: ListView.builder(
                  padding     : EdgeInsets.all(10),
                  itemCount   : productos.length,
                  itemBuilder : (context,index)
                                 => ProductoCard(
                                    id: index,
                                    producto: productos[index],
                                 )
                  )
           );
}
