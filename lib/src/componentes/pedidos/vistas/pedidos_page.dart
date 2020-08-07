
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/pedidos/vistas/detalle_pedido_page.dart';

class PedidosPage extends StatefulWidget {
  PedidosPage({Key key}) : super(key: key);

  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PedidosBloc,PedidosState>(
           builder: (context,state)=>
                    Scaffold(
                    body : state.loading
                           ? Center(child: CircularProgressIndicator())
                           : state.pedidos.length == 0
                             ? Center(child : Text("No hay pedidos"))
                             : ListView.builder(
                               itemCount   : state.pedidos.length,
                               itemBuilder : (BuildContext context, int i) {
                                              return ListTile(
                                                     leading  : state.pedidos[i].enviado
                                                               ? Icon(Icons.cloud_done)
                                                               :SizedBox(child: CircularProgressIndicator(strokeWidth: 2),height:25,width: 25),
                                                     title    : Text("${state.pedidos[i].formatFecha()}"),
                                                     subtitle : Text("Total: \u0024 ${state.pedidos[i].total}"),
                                                     trailing : state.pedidos[i].confirmado
                                                                ? Icon(Icons.check,color:Colors.green)
                                                                : Icon(Icons.cancel,color: Colors.red),
                                                     onTap: ()=>Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                builder: (context) => DetallesPedidoPage(pedido: state.pedidos[i])
                                                                ),
                                                     ),
                                              );
                              },
                             ),
                    )
               
           );
  }
}