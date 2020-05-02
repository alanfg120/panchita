import 'package:flutter/material.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class ProductoPage extends StatefulWidget {
  final Producto producto;
  final int id;
  final String ruta;
  ProductoPage({Key key,this.producto,this.id,this.ruta}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
    
 final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
          body: CustomScrollView(
                slivers: <Widget>[
                  _silverAppbar(),
                  _detallesProduto()
                ],
          ),
         persistentFooterButtons: <Widget>[
           RaisedButton(
           onPressed : _dialogo,
           color     : Colors.purple,
           child     : Text("Agregar al carro"),
           shape     : RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
           ),
        
         ],
    );
  }


  Widget _silverAppbar() 
         => SliverAppBar(
            iconTheme       : IconThemeData(color: Colors.white),
            backgroundColor : Colors.purple,
            floating        : false,
            pinned          : true,
            expandedHeight  : 300.0,
            centerTitle     : true,
            flexibleSpace   : FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              centerTitle : true,
                              title       : Text(
                                           widget.producto.nombre,
                                           style    : TextStyle(
                                           color    : Colors.white,
                                           fontSize : 16.0
                                           )
                             ),
                             background  : Center(
                                           child: Hero(
                                                  tag  : widget.id.toString(),
                                                  child: widget.producto.foto == null
                                                         ? CircleAvatar(
                                                           radius         : 50.0,
                                                           backgroundColor: Colors.purple,
                                                           child          : Text(
                                                                            widget.producto.nombre[0],
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                   color   : Colors.white,
                                                                                   fontSize: 50.0
                                                                            )
                                                           ),
                                                          foregroundColor: Colors.white,
                                                          )
                                                          : CircleAvatar(
                                                            radius         : 100.0,
                                                            backgroundImage: NetworkImage(widget.producto.foto)
                                                          ),
                                            )
                             ),
                       ),    
         );

  Widget _detallesProduto()
         => SliverList(
            delegate: SliverChildListDelegate([
            ListTile(
            leading : Icon(Icons.credit_card),
            title   : Text(widget.producto.codigo),
            subtitle: Text("Categoria"),
            ),
            ListTile(
            leading : Icon(Icons.monetization_on),
            title   : Text(widget.producto.precioDos.toString()),
            subtitle: Text("Precio"),
            ),
            ListTile(
            leading : Icon(Icons.format_list_numbered),
            title   : Text(widget.producto.cantidad.toString()),
            subtitle: Text("Cantidad Disponible"),
            ),
            ListTile(
            leading : Icon(Icons.list),
            title   : Text(widget.producto.categoria),
            subtitle: Text("Categoria"),
            ),
          
            ListTile(
            leading : Icon(Icons.location_city),
            title   : Text(widget.producto.marca),
            subtitle: Text("Marca"),
            ),
            ListTile(
            leading : Icon(Icons.format_align_justify),
            title   : Text(widget.producto.descripcion),
            subtitle: Text("Descripcion"),
            ),
            
            ])
            );
 
  _dialogo(){
      showDialog(
      context: context,
      child  : AlertDialog(
               title   : Text(widget.producto.nombre),
               content : Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         mainAxisSize: MainAxisSize.min,
                         children: <Widget>[
                               TextField(
                               controller   : _controller,
                               autofocus    : true,
                               keyboardType : TextInputType.phone,
                               decoration   : InputDecoration(
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                                              labelStyle: TextStyle(color: Colors.purple),
                                              labelText: "cantidad",
                                              helperText: "Escriba la cantidad"
                               ),
                               onChanged: (value){},
                               )
                         ],
               ),
               actions : <Widget>[
                 RaisedButton(onPressed: (){},child:Text("Agregar"))
               ],
               )
      );
  }

}