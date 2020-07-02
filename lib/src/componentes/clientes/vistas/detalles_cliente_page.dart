import 'package:flutter/material.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';

class DetallesClientePage extends StatefulWidget {
  final Cliente cliente;
  DetallesClientePage({Key key, this.cliente}) : super(key: key);

  @override
  _DetallesClientePageState createState() => _DetallesClientePageState();
}

class _DetallesClientePageState extends State<DetallesClientePage> {
  double padding = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text("Detalles del  Cliente"),
           ),
           body  : ListView(
                   children: <Widget>[
                      ListTile(
                      leading        : Icon(Icons.person,color: Colors.pink),
                      title          : Text(widget.cliente.nombre),
                      subtitle       : Text("Nombre"),
                      ),
                      ListTile(
                
                      leading        : Icon(Icons.credit_card,color: Colors.pink),
                      title          : Text(widget.cliente.cedula),
                      subtitle       : Text("Cedula"),
                      ),
                      ListTile(
             
                      leading        : Icon(Icons.phone_android,color: Colors.pink),
                      title          : Text(widget.cliente.telefono),
                      subtitle       : Text("Telefono"),
                      ),
                      ListTile(
       
                      leading        : Icon(Icons.map,color: Colors.pink),
                      title          : Text(widget.cliente.ciudad.ciudad),
                      subtitle       : Text("Ciudad"),
                      ),
                      ListTile(
    
                      leading        : Icon(Icons.markunread_mailbox,color: Colors.pink),
                      title          : Text(widget.cliente.direccion),
                      subtitle       : Text("Direccion"),
                      ),
                   ]
                   ),
    ); 
  }
}