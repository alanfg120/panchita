import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/clientes/bloc/clientes_bloc.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
import 'package:panchita/src/componentes/clientes/vistas/cretate_client_page.dart';
import 'package:panchita/src/componentes/clientes/vistas/detalles_cliente_page.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';

class BuscarClientePage extends StatefulWidget {
  final bool select;
  BuscarClientePage({Key key,this.select =false}) : super(key: key);
 
  @override
  _BuscarClientePageState createState() => _BuscarClientePageState();
}

class _BuscarClientePageState extends State<BuscarClientePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar : AppBar(
                    title: TextField(
                           style      : TextStyle(fontSize: 18),
                           //controller : controller,
                           autofocus  : true,
                           decoration : InputDecoration(
                                        hintText: "Buscar Cliente",
                                        hintStyle: TextStyle(fontSize: 15),
                                        border: InputBorder.none
                                        ),
                           onChanged  : (value) {
                                        context.bloc<ClientesBloc>().add(
                                          SearchClienteEvent(query:value)
                                        );
                           } 
                    ),
                    actions: <Widget>[
                             
                    ],
           ),
           body: BlocBuilder<ClientesBloc,ClientesState>(
                 builder:(context,state){
                    return ListView.builder(
                           itemCount: state.searchclientes.length,
                           itemBuilder: (context,i){
                                   return Dismissible(
                                          direction   : DismissDirection.endToStart,
                                          key         : Key(state.searchclientes[i].cedula), 
                                          background  : Container(
                                                        padding: EdgeInsets.all(10),
                                                              alignment: Alignment.centerRight,
                                                              color :Colors.red,
                                                              child :Text("Eliminar",style:TextStyle(color:Colors.white)),
                                                              ),
                                         onDismissed  : (d)=> context.bloc<ClientesBloc>().add(DeleteClienteEvent(
                                                                                               index : i,
                                                                                               id    : state.searchclientes[i].id
                                                                                               )
                                                                                               ),
                                         child        : ListTile(
                                                        title: Text(state.searchclientes[i].nombre),
                                                        subtitle: Text(state.searchclientes[i].cedula),
                                                        trailing: widget.select
                                                                  ? RaisedButton(
                                                                    child     : Text("Detalles",style: TextStyle(color:Colors.white)),
                                                                    onPressed : ()=>_detallesCliente(state.searchclientes[i]),
                                                                    color     : Colors.pink,
                                                                    )
                                                                  : IconButton(
                                                                    icon      : Icon(Icons.edit), 
                                                                    onPressed : ()=>_updateCliente(state.searchclientes[i]),
                                                                    color     : Colors.green,
                                                                    ),
                                                        onTap   : ()=>_selectCliente(state.searchclientes[i]),
                                                       ),
                                                      );
                           }
                           );
                 },
                 ),
    );

    
  }
   _updateCliente(Cliente cliente) {
     Navigator.push(context,MaterialPageRoute(
                            builder: (context)=>CreateClientePage(
                                                cliente : cliente,
                                                update  :true
                                                )
                            )
     );
  }
  _selectCliente(Cliente cliente) {
     if(widget.select){
         context.bloc<PedidosBloc>().add(
         SelectClienteEvent(cliente: cliente)
      );
      Navigator.pop(context);
     }
     
     else  Navigator.push(
           context, MaterialPageRoute(
                    builder: (context)=> DetallesClientePage(cliente:cliente)
           )
     );
  }

  _detallesCliente(Cliente cliente) {
     Navigator.push(
           context, MaterialPageRoute(
                    builder: (context)=> DetallesClientePage(cliente:cliente)
           )
     );
  }
}