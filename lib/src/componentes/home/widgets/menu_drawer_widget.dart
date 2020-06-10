import 'package:flutter/material.dart';

class ItemDrawer extends StatefulWidget {
  final String titulo;
  final IconData icono;
  final int page;
  final bool activate;
  final Function(int page) ontap;

  ItemDrawer(
      {Key key, this.titulo, this.icono, this.ontap, this.page, this.activate})
      : super(key: key);

  @override
  _ItemDrawerState createState() => _ItemDrawerState();
}

class _ItemDrawerState extends State<ItemDrawer> {
  @override
  Widget build(BuildContext context) {
    
    if(widget.activate == null || widget.activate == true)
    return ListTile(
      title: Text(widget.titulo),
      leading: Icon(widget.icono, color: Colors.pink[300]),
      onTap: () {
        widget.ontap(widget.page);
        Navigator.pop(context);
      },
    );
    else return null;
  }
}
