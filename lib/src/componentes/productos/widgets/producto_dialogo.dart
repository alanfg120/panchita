import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class DialogProducto extends StatefulWidget {

  final Producto producto;
  final int cantidadActual;

  DialogProducto({Key key,this.producto,this.cantidadActual}) : super(key: key);

  @override
  _DialogProductoState createState() => _DialogProductoState();
}

class _DialogProductoState extends State<DialogProducto> {

  String ruta;
  @override
  Widget build(BuildContext context) {
     
    
     final state       = BlocProvider.of<LoginBloc>(context).state;
     final blocCompras = BlocProvider.of<PedidosBloc>(context).add;

    if (state is AutenticadoState) ruta = state.usuario.ciudad.ruta;
        final heigthDialog = MediaQuery.of(context).size.height * 0.5;

         
    return Container(
           alignment : Alignment.topLeft,
           padding   : EdgeInsets.all(10),
           height    : heigthDialog,
           child     : Column(
                       mainAxisSize : MainAxisSize.max,
                       children     : <Widget>[
                                       Expanded(
                                       flex  : 4,
                                       child : Stack(
                                               children: <Widget>[
                                                         CircleAvatar(
                                                         radius          : 80,
                                                         backgroundImage : NetworkImage(widget.producto.foto),
                                                         ),
                                                         Positioned(
                                                         bottom : 8,
                                                         right  : 8,
                                                         child  : Container(
                                                                  height    : 20,
                                                                  width     : 60,
                                                                  alignment : Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                              borderRadius : BorderRadius.circular(25),
                                                                              color        : Colors.red
                                                                  ),
                                                                  child: Text(
                                                                         '\u0024 ${widget.producto.getPrecio(ruta)}',
                                                                         style: TextStyle(
                                                                                color      : Colors.white,
                                                                                fontSize   : 12,
                                                                                fontWeight : FontWeight.bold),
                                                                  ),
                                                         )
                                                         )
                                               ]
                                       )
                                       ),
                                       Expanded(
                                       flex  : 1,
                                       child : Container(
                                               margin  : EdgeInsets.all(2),
                                               alignment: Alignment.centerLeft,
                                               child: Text(
                                                      '${widget.producto.nombre}',
                                                      style: TextStyle(
                                                             fontSize   : 15, 
                                                             fontWeight : FontWeight.bold
                                                      ),
                                               ),
                                       ),
                                       ),
                                       Expanded(
                                       flex  : 2,
                                       child : Container(
                                               margin  : EdgeInsets.all(2),
                                               alignment : Alignment.topLeft,
                                               child     : widget.producto.descripcion == null
                                                           ? Text("No hay descripcion")
                                                           : Text("${widget.producto.descripcion}"),
                                               )
                                       ),
                                       Expanded(
                                       flex  : 2,
                                       child : Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: <Widget>[
                                                         IconButton(
                                                         icon: Icon(
                                                               Icons.remove_circle,
                                                               color : Colors.grey, 
                                                               size  : 40
                                                         ),
                                                         onPressed: ()=>setState(() {
                                                                     if(widget.producto.cantidadCompra>1)
                                                                     widget.producto.cantidadCompra--;
                                                         }),
                                                         ),
                                                         Text('${widget.producto.cantidadCompra}'),
                                                         IconButton(
                                                         icon: Icon(
                                                               Icons.add_circle,
                                                               color : Colors.green, 
                                                               size  : 40
                                                         ),
                                                         onPressed: ()=>setState(()=>
                                                                       widget.producto.cantidadCompra++
                                                                       )
                                                         ),
                                               ],
                                       ),
                                       ),
                                       Expanded(
                                       flex  : 1,
                                       child : RaisedButton(
                                               onPressed : () {
                                                           blocCompras(AddProductoEvent(
                                                                       producto : widget.producto,
                                                                       ruta     : ruta,
                                                                       )
                                                           );
                                                           Navigator.pop(context);
                                               },
                                               color     : Colors.pink,
                                               child     : Text(
                                                           "Agregar al Carro",
                                                            style: TextStyle(color: Colors.white),
                                               ),
                                               shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                       ),
                                       )
                       ],
           ),
    );
  }
}