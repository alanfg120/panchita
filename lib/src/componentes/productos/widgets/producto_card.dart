import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/componentes/productos/vistas/producto_page.dart';
import 'package:panchita/src/componentes/productos/widgets/producto_dialogo.dart';

class ProductoCard extends StatefulWidget {
  final Producto producto;
  final int id;

  const ProductoCard({Key key, this.producto, this.id}) : super(key: key);

  @override
  _ProductoCardState createState() => _ProductoCardState();
}

class _ProductoCardState extends State<ProductoCard> {
  String ruta;
  double heigthDialog;

  @override
  Widget build(BuildContext context) {

    final state = BlocProvider.of<LoginBloc>(context).state;
    if (state is AutenticadoState) ruta = state.usuario.ciudad.ruta;

  
    return Container(
           margin     : EdgeInsets.only(bottom: 8),
           decoration : BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
           ),
           child      : Row(
                        children: <Widget>[
                                  _imageCard(),    
                                  _precioCard(),
                                  _addProducto(),
                        ],
        ));
  }

  _navigation() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProductoPage(id: widget.id, producto: widget.producto)));
  }

  _dialogCompra() {
       showModalBottomSheet(
        context: context,
        builder: (context) => 
                 DialogProducto(producto: widget.producto)
    );
  }
   
  Widget _imageCard()
         => ClipRRect(
            borderRadius : BorderRadius.circular(6),
            child        : Hero(
                           tag   : widget.id.toString(),
                           child : GestureDetector(
                                   onTap : _navigation,
                                   child : FadeInImage.assetNetwork(
                                           fit         : BoxFit.cover,
                                           height      : 100,
                                           width       : 100,
                                           placeholder : 'assets/image.gif',
                                           image       : widget.producto.foto
                                   ),
                           ),
            )
            );
 
  Widget _precioCard()
         =>  Container(
             margin : EdgeInsets.only(left: 10),
             height : 90,
             child  : Column(
                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                      children          : <Widget>[
                                           Text(
                                           widget.producto.nombre,
                                           style : TextStyle(
                                                   fontWeight : FontWeight.bold,
                                                   fontSize   : 15
                                                   )
                                           ),
                                           Container(
                                           height    : 28,
                                           width     : 90,
                                           alignment : Alignment.center,
                                           decoration: BoxDecoration(
                                                       borderRadius : BorderRadius.circular(25),
                                                       color        : Colors.red
                                           ),
                                           child     : Text(
                                                       '\u0024 ${widget.producto.getPrecio(ruta)}',
                                                       style : TextStyle(
                                                               color      : Colors.white,
                                                               fontSize   : 14,
                                                               fontWeight : FontWeight.bold),
                                           ),
                                           )
                      ],
            ),
         );

  Widget _addProducto()
         =>   Expanded(
              child: Container(
                     alignment : Alignment.centerRight,
                     child     : MaterialButton(
                     color     : Colors.white,
                     onPressed : _dialogCompra,
                     child     : Icon(
                                 Icons.add,
                                 color: Colors.red,
                     ),
                     shape     : CircleBorder(side: BorderSide(color: Colors.red)),
                  )),
            );


}
