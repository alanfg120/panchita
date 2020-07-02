

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
import 'package:panchita/src/componentes/clientes/vistas/buscar_cliente_page.dart';
import 'package:panchita/src/componentes/clientes/vistas/clientes_page.dart';

import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/pedidos/models/pedido_model.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/componentes/productos/widgets/producto_dialogo.dart';

class CompraPage extends StatefulWidget {
  CompraPage({Key key}) : super(key: key);

  @override
  _CompraPageState createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
    
    Usuario usuario;
    String ruta;
    String observacion;
    Producto productoActual;
   final _scafKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  // _snackBar("mensaje");
     final state = BlocProvider.of<LoginBloc>(context).state;
      if (state is AutenticadoState) {
         usuario = state.usuario;
         ruta    = state.usuario.ciudad.ruta;
    }

    return  BlocConsumer<PedidosBloc, PedidosState>(
                      listener : (context,state){
                                 if(!state.sendPedido){
                                     Navigator.pop(context);
                                     _snackBar("Pedido Realizado");
                                 }
                            
                      },
                      listenWhen :(previos,current){
                           if(previos.sendPedido==current.sendPedido)
                              return false;
                           return true;
                      } ,
                      builder: (context, state) =>
                                Scaffold(
                                key    :  _scafKey,
                                appBar :  AppBar(title: Text("Tu Pedido",style: TextStyle(color:Colors.black),)),
                                body   :  state.productos.length == 0 
                                          ? Center(child: Text("Ningun producto agregado"))
                                          : Column(
                                            children: <Widget>[
                                                 usuario.vendedor
                                                 ? ListTile(
                                                   title    : Text("${state.cliente == null ? 'Seleciona Cliente' : state.cliente.nombre}"),
                                                   subtitle : state.cliente == null ? null : Text("Cliente Selecionado"),
                                                   trailing : Icon(Icons.add,color: Colors.pink),
                                                   onTap    : ()=>_selectCliente(),
                                                 )
                                                 :Container(),
                                                 Expanded(child: _listaProductos(state.productos))

                                            ],
                                          ),
                                 bottomSheet: ListTile(
                                              contentPadding : EdgeInsets.all(20),
                                              title          : Text("Total"),
                                              trailing       : Text(
                                                               "\u0024 ${state.total}",
                                                               style: TextStyle(fontWeight: FontWeight.bold),
                                                               ),
                                 ),
                                 floatingActionButton: RaisedButton(
                                                       color     : Colors.red,
                                                       onPressed : state.productos.length == 0
                                                                   ? null
                                                                   : ()=> _confirmarPedido(state.productos),
                                                       child     : Text("Confirmar ",style: TextStyle(color: Colors.white)),
                                                       shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                 ),
                                 floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       )
    );

    
  }

  _confirmarPedido(List<Producto> productos) {

       showDialog(
       barrierDismissible : false,
       context            : context,
       builder            : (context) =>
                             BlocBuilder<PedidosBloc,PedidosState>(
                             builder:(context,state)=>
                                      AlertDialog(
                                      title   : state.sendPedido
                                                ? Text("Enviado su Pedido")
                                                : Text("Comfirma tu Pedido"),
                                      content : state.sendPedido 
                                                ? Container(
                                                  height   : 100,
                                                  alignment: Alignment.center,
                                                  child    : CircularProgressIndicator()
                                                )
                                                : TextField(
                                                 autofocus  : true,
                                                 maxLines   : 4,
                                                 onChanged  : (value) => observacion = value,   
                                                 decoration : InputDecoration(
                                                              border     : OutlineInputBorder(),
                                                              helperText : 'Escriba alguna observacion(Opcional)'
                                                 ),
                                                 ),
                                       actions : state.sendPedido
                                                 ? null
                                                 : <Widget>[
                                                 RaisedButton(
                                                 color     : Colors.red,
                                                 child     : Text("Confirmar",style:TextStyle(color:Colors.white)),
                                                 onPressed : ()=>_sendPedido(productos),
                                                 ),
                                                 OutlineButton(
                                                 child     : Text("Cancelar",style:TextStyle(color:Colors.red)),
                                                 onPressed : ()=>Navigator.pop(context)
                                                 )      
                                      ],
                                     )
                              )   
                             
       );

  }

  _editCantidad() {
      showModalBottomSheet(
        context: context,
        builder: (context) => 
                 DialogProducto(producto: productoActual)
    );

  }

    _sendPedido(List<Producto> productos) {
   
    final pedido  = Pedido(
    cliente       : usuario.vendedor
                    ? context.bloc<PedidosBloc>().state.cliente
                    : Cliente(
                      nombre    : usuario.nombre,
                      cedula    : usuario.cedula,
                      ciudad    : usuario.ciudad,
                      direccion : usuario.direccion,
                      telefono  : usuario.telefono
                      ),
    token         : usuario.token,
    confirmado    : false,
    fecha         : DateTime.now(),
    productos     : productos,
    observacion   : observacion,
    total         : context.bloc<PedidosBloc>().state.total,
    cedulaVendedor: usuario.vendedor ? usuario.cedula : ''
    );

    context.bloc<PedidosBloc>().add(
            SendPedidoEvent(
            pedido : pedido   
            )
    );
    productos.forEach((p){
      context.bloc<ProductosBloc>().add(
              ResetCantidadEvent(codigo: p.codigo)
      );
    });
  }
 _snackBar(String mensaje) {
   _scafKey.currentState.showSnackBar(
    SnackBar(
    content  : Text(mensaje),
    behavior : SnackBarBehavior.floating,
    duration : Duration(seconds: 2),
    )
   )..closed.then((_){
      Navigator.pop(context);
   });
 }

 Widget _listaProductos(List<Producto> productos) {
    return ListView.builder(
           padding     : EdgeInsets.only(bottom: 130),
           itemCount   : productos.length,
           itemBuilder : (context, i) {
                          return Dismissible (
                                   direction   : DismissDirection.endToStart,
                                   key         : Key(productos[i].codigo), 
                                   background  : Container(
                                                 padding: EdgeInsets.all(10),
                                                 alignment: Alignment.centerRight,
                                                 color :Colors.red,
                                                 child :Text("Eliminar",style:TextStyle(color:Colors.white)),
                                                 ),
                                   onDismissed : (d){
                                                  context.bloc<PedidosBloc>().add(
                                                          DeleteProductoEvent(
                                                          index : i,
                                                          ruta  : ruta
                                                          )
                                                  );
                                                  context.bloc<ProductosBloc>().add(
                                                          ResetCantidadEvent(
                                                          codigo: productos[i].codigo  
                                                          )
                                                  );
                                   },
                                   child       : ListTile(
                                                 isThreeLine    : true,

                                                 leading        : CircleAvatar(
                                                                  radius          : 30,
                                                                  backgroundImage : productos[i].foto == ''
                                                                                    ? AssetImage('assets/image.gif')
                                                                                    : CachedNetworkImageProvider(productos[i].foto),
                                                 ),      
                                                 title          : Text(productos[i].nombre),
                                                 subtitle       : Text(
                                                                  'Cantidad: ${productos[i].cantidadCompra}\nPrecio Unit: \u0024 ${productos[i].getPrecio(ruta)}'
                                                                  ),
                                                 trailing       : Text(
                                                                  '\u0024 ${productos[i].getSubtotal(ruta)}',
                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                 ),      
                                                 onTap          : (){
                                                                  productoActual = productos[i];
                                                                  _editCantidad();
                                                 },
                                                 //contentPadding : EdgeInsets.all(7),
                                   ),
                          );
           }
    );
 }

  _selectCliente() {
    Navigator.push(
    context,MaterialPageRoute(
            builder:(context)=>BuscarClientePage(select: true)
            )
    );
  }

 
}
