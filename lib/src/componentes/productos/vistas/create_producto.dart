import 'package:flutter/material.dart';

class NewProductoPage extends StatefulWidget {
  NewProductoPage({Key key}) : super(key: key);

  @override
  _NewProductoPageState createState() => _NewProductoPageState();
}

class _NewProductoPageState extends State<NewProductoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
                   title: Text("Crear Producto"),
           ),
    );
  }
}