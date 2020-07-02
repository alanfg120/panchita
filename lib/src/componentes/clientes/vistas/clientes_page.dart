import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/clientes/bloc/clientes_bloc.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
import 'package:panchita/src/componentes/clientes/vistas/cretate_client_page.dart';
import 'package:panchita/src/componentes/clientes/vistas/detalles_cliente_page.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';


class ClientesPage extends StatefulWidget {
  final bool select;
  ClientesPage({Key key,this.select = false}) : super(key: key);

  @override
  _ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
 
   final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar               :  widget.select 
                               ? AppBar(
                                 title: Text(
                                        "Selecionar Cliente",
                                         style: TextStyle(color:Colors.black)
                                        )
                                 ) 
                               : null,
       key                  : _scaffoldKey,
       body                 : BlocConsumer<ClientesBloc,ClientesState>(
                              listener: (context,state){
                                   if(state.eliminado)
                                     _snackBar("Cliente Eliminado");
                              },
                              builder: (context,state){
                                       if(state.loading)
                                         return Center(child: CircularProgressIndicator());
                                       else return  state.clientes.length == 0
                                               ? Center(child:Text('No hay clientes'))
                                               : ListView.builder(
                                                 itemCount   : state.clientes.length,
                                                 itemBuilder :(context,i){
                                                      return Dismissible(
                                                              direction   : DismissDirection.endToStart,
                                                              key         : Key(state.clientes[i].cedula), 
                                                              background  : Container(
                                                                            padding: EdgeInsets.all(10),
                                                                                  alignment: Alignment.centerRight,
                                                                                  color :Colors.red,
                                                                                  child :Text("Eliminar",style:TextStyle(color:Colors.white)),
                                                                                  ),
                                                             onDismissed  : (d)=> context.bloc<ClientesBloc>().add(DeleteClienteEvent(
                                                                                                                   index : i,
                                                                                                                   id    : state.clientes[i].id
                                                                                                                   )
                                                                                                                   ),
                                                             child        : ListTile(
                                                                            title: Text(state.clientes[i].nombre),
                                                                            subtitle: Text(state.clientes[i].cedula),
                                                                            trailing: widget.select
                                                                                      ? null
                                                                                      : IconButton(
                                                                                      icon      : Icon(Icons.edit), 
                                                                                      onPressed : ()=>_updateCliente(state.clientes[i]),
                                                                                      color     : Colors.green,
                                                                                      ),
                                                                            onTap   : ()=>_selectCliente(state.clientes[i]),
                                                                           ),
                                                      );
                                        }
                                        );
                              },
                              ),
       floatingActionButton : FloatingActionButton(
                              onPressed       : ()=>Navigator.pushNamed(context, 'create_cliente'),
                              child           : Icon(Icons.add),
                              backgroundColor : Colors.pink,
                              ),
    );
  }

 _snackBar(String mensaje) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
        content : Text(mensaje),
        duration: Duration(seconds: 2),
        )
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
     if(widget.select)
      context.bloc<PedidosBloc>().add(
         SelectClienteEvent(cliente: cliente)
      );
     else  Navigator.push(
           context, MaterialPageRoute(
                    builder: (context)=> DetallesClientePage(cliente:cliente)
           )
     );
  }
}