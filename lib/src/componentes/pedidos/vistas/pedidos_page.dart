
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
                    body : state.pedidos.length == 0
                           ? Center(child : Text("No hay pedidos"))
                           : ListView.builder(
                             itemCount   : state.pedidos.length,
                             itemBuilder : (BuildContext context, int i) {
                                            return ListTile(
                                                   leading  : CircleAvatar(
                                                              child           : Text("${i + 1 }"),
                                                              backgroundColor : Colors.pink,
                                                   ),
                                                   title    : Text("${state.pedidos[i].formatFecha()}"),
                                                   subtitle : Text("Total: \u0024 ${state.pedidos[i].total}"),
                                                   onTap: ()=>Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesPedidoPage(pedido: state.pedidos[i]),
                ),
              ),
                                            );
                            },
                           ),
                    )
               
           );
  }
}