import 'package:flutter/material.dart';
import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class DetallesPedidoPage extends StatefulWidget {

  final Pedido pedido;

  DetallesPedidoPage({Key key,this.pedido}) : super(key: key);

  @override
  _DetallesPedidoPageState createState() => _DetallesPedidoPageState();
}

class _DetallesPedidoPageState extends State<DetallesPedidoPage> {
  
   final Color primaryColor = Colors.teal;
  @override
  Widget build(BuildContext context) {
  
                    
                     return Scaffold(
                            appBar : AppBar(
                                     title: Text("Detalles del Pedido"),
                                
                                    ),
                            body   : Column(
                                     children: <Widget>[
                                              ListTile(
                                              title    : Text(widget.pedido.nombreCliente),
                                              subtitle : Text("Nombre"),
                                              leading  : Icon(Icons.people),
                                              ),
                                              ListTile(
                                              title    : Text(widget.pedido.cedula),
                                              subtitle : Text("Cedula"),
                                              leading  : Icon(Icons.credit_card)
                                              ),
                                              ListTile(
                                              title    : Text(widget.pedido.direccion),
                                              subtitle : Text("Direccion"),
                                              leading  : Icon(Icons.map),
                                              ),
                                              ListTile(
                                              leading  : Text("No"),
                                              title    : Text("Productos"),
                                              trailing : Text("Subtotal"),
                                              ),
                                              Expanded(
                                              child: listaProductos(widget.pedido.productos)
                                              ),
                                              SafeArea(
                                              child: ListTile(
                                                     title    : Text(
                                                                "Total",
                                                                style: TextStyle(
                                                                       fontSize   : 20,
                                                                       fontWeight : FontWeight.bold
                                                                       )
                                                                ),
                                                     leading  : Icon(Icons.monetization_on),
                                                     trailing : Text(
                                                                "\u0024 ${widget.pedido.total}",
                                                                style: TextStyle(fontWeight: FontWeight.bold)
                                                                ),
                                              ),
                                            ),
                                  ],
                                )
                             
                          
                                         
                     );

          
  
  }
 listaProductos(List<Producto> productos) {

    return ListView.separated(
           separatorBuilder: (context,i)=>Divider(height: 1),
           itemCount: productos.length,
           itemBuilder: (context,i){
                        return ListTile(
                               title: Text(productos[i].nombre),
                               subtitle: Text('Cantidad: ${productos[i].cantidadCompra}\nPrecio Unit: \u0024 ${productos[i].precioFinal}'),
                               leading: Text('${i+1}'),
                               trailing: Text(productos[i].getSubtotal().toString()),
                        );
           },
    );
  }


}