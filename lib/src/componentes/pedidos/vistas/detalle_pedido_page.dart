
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class DetallesPedidoPage extends StatefulWidget {

  final Pedido pedido;

  DetallesPedidoPage({Key key,this.pedido}) : super(key: key);

  @override
  _DetallesPedidoPageState createState() => _DetallesPedidoPageState();
}

class _DetallesPedidoPageState extends State<DetallesPedidoPage> {
   bool isVendedor;
   final Color primaryColor = Colors.teal;
  @override
  Widget build(BuildContext context) {
             final stateUsuario = BlocProvider.of<LoginBloc>(context).state;
                   if(stateUsuario is AutenticadoState)
                      isVendedor = stateUsuario.usuario.vendedor;
             return Scaffold(
                            appBar : AppBar(
                                     title: Text("Detalles del Pedido"),
                                
                                    ),
                            body   : Column(
                                     children: <Widget>[
                                              isVendedor
                                              ? ListTile(
                                              title    : Text("Cliente"),
                                              subtitle : Text(widget.pedido.cliente.nombre)
                                              )
                                              : Container(),
                                              ListTile(
                                              title    : Text("Confirmado"),
                                              subtitle : widget.pedido.confirmado
                                                         ? Text("SI")
                                                         : Text("NO"),
                                              leading  : widget.pedido.confirmado
                                                         ? Icon(Icons.check_circle_outline)
                                                         : Icon(Icons.cancel)
                                              ),
                                              Container(
                                              height : 80,
                                              margin : EdgeInsets.symmetric(horizontal: 8),
                                              width  : double.infinity,
                                              alignment: Alignment.center,
                                              child  : widget.pedido.mensaje == null 
                                                       ? Text("No hay un mensaje de pedido")
                                                       : Text(widget.pedido.mensaje),
                                              decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          color: Colors.black12
                                              ),
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