import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
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
    if (state is AuthenticationSuccessState) ruta = state.usuario.ciudad.ruta;

  
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
          )
        );
  }

  _navigation() {
  /*   Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProductoPage(id: widget.id, producto: widget.producto))); */
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
                                   child : widget.producto.foto == null || widget.producto.foto == ''
                                          ? Container(
                                            width: 90,
                                            height: 90,
                                            child: Icon(Icons.not_interested)
                                            )
                                          : CachedNetworkImage(
                                          height      : 90,
                                          width       : 90,
                                          imageUrl    : widget.producto.foto,
                                          placeholder : (context, url) => Image(
                                                                          height : 90,
                                                                          width  : 90,
                                                                          image  : AssetImage("assets/image.gif"),
                                          ),
                                          errorWidget : (context, url, error) => Container(
                                                                                 alignment: Alignment.center,
                                                                                 width: 90,
                                                                                 height: 90,
                                                                                 child: Icon(Icons.not_interested)
                                                                                 ),
                                    ),
                           ),
            )
            );
 
  Widget _precioCard()
         =>  Container(
            
             margin : EdgeInsets.only(left: 10),
             height : 90,
             width  : 180,
             child  : Column(
                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children          : <Widget>[
                                           Text(
                                           widget.producto.nombre,
                                           style : TextStyle(
                                                   fontWeight : FontWeight.bold,
                                                   fontSize   : 13
                                                   ),
                                           overflow: TextOverflow.ellipsis,
                                           ),
                                           Container(
                                           height    : 28,
                                           width     : 90,
                                           alignment : Alignment.center,
                                           decoration: BoxDecoration(
                                                       borderRadius : BorderRadius.circular(25),
                                                       color        : Colors.pink
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
                                 color: Colors.pink,
                     ),
                     shape     : CircleBorder(side: BorderSide(color: Colors.pink)),
                  )),
            );


}
