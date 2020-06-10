import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';

class CreateProductoPage extends StatefulWidget {
  CreateProductoPage({Key key}) : super(key: key);
  @override
  _CreateProductoPageState createState() => _CreateProductoPageState();
}

class _CreateProductoPageState extends State<CreateProductoPage> {

  Producto producto = Producto();
 
  final _codigoController     = TextEditingController();
  final _cantidadController   = TextEditingController();
  final _categoriasController = TextEditingController();
  final _marcasController     = TextEditingController();
  final _nombreController     = TextEditingController();
  final _precioUnoController  = TextEditingController();
  final _precioDosController  = TextEditingController();
  final _precioTresController = TextEditingController();

  final _focoCodigo      = FocusNode();
  final _focoCantidad    = FocusNode();
  final _focoCategorias  = FocusNode();
  final _focoMarcas      = FocusNode();
  final _focoNombre      = FocusNode();
  final _focoPrecioUno   = FocusNode();
  final _focoPrecioDos   = FocusNode();
  final _focoPrecioTres  = FocusNode();

  final _scaffoldKey  = GlobalKey<ScaffoldState>();
  final _formKey      = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                        child: BlocConsumer<LoginBloc,LoginState>(
                               listener: (context,state){
                             
                               },
                               builder: (context,state){
                               return  Form(
                                       key  : _formKey,
                                       child: Container(
                                              padding: EdgeInsets.all(33),
                                              child: Column(
                                                 children: <Widget>[
                                                            input("Codigo",_codigoController,Icon(Icons.mail_outline),_focoCodigo,producto),
                                                            SizedBox(height: 20),
                                                            input("Nombre",_nombreController,Icon(Icons.lock),_focoNombre,producto),
                                                            SizedBox(height: 20),
                                                            input("Cantidad",_cantidadController,Icon(Icons.mail_outline),_focoCantidad,producto),
                                                            SizedBox(height: 20),
                                                            input("Categorias",_categoriasController,Icon(Icons.lock),_focoCategorias,producto),
                                                            SizedBox(height: 20),
                                                            input("Marcas",_marcasController,Icon(Icons.lock),_focoMarcas,producto),
                                                            SizedBox(height: 20),
                                                            input("Precio Uno",_precioUnoController,Icon(Icons.lock),_focoPrecioUno,producto),
                                                            SizedBox(height: 20),
                                                            input("Precio Dos",_precioDosController,Icon(Icons.lock),_focoPrecioDos,producto),
                                                            SizedBox(height: 20),
                                                            input("Precio Tres",_precioTresController,Icon(Icons.lock),_focoPrecioTres,producto),
                                                            SizedBox(height: 20),
                                                            registroButton(),
                                                            SizedBox(height: 20),
                                                          ],
                                            ),
                                   ),
                                   );
                           },
                           ),
                         ),
                   ),
           );
            
  
  }

Widget input(String texto, TextEditingController controller,Icon icono,foco,Producto producto){
  
        TextInputAction textinput;
         switch (texto) {
                 case 'Codido'     : textinput=TextInputAction.next;
                                     break;
                 case 'Nombre'     : textinput=TextInputAction.next;
                                     break;
                 case 'Cantidad'   : textinput=TextInputAction.next;
                                     break;
                 case 'Categorias' : textinput=TextInputAction.next;
                                     break;
                 case 'Marcas'     : textinput=TextInputAction.next;
                                     break;
                 case 'Precio Uno' : textinput=TextInputAction.next;
                                     break;
                 case 'Precio Dos' : textinput=TextInputAction.next;
                                     break;
                 case 'Precio Tres': textinput=TextInputAction.done;
                                     break;
                 default:
         }
        
       return TextFormField(
       textInputAction: textinput,
       focusNode  : foco,
       controller : controller,
       decoration : InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: icono,
                    hintText: texto,
                    border: OutlineInputBorder()
                    ),
       onEditingComplete:(){
                    switch (texto) {
                      case 'Codigo'     : FocusScope.of(context).requestFocus(_focoNombre);
                                          break;
                      case 'Nombre'     : FocusScope.of(context).requestFocus(_focoCantidad);
                                          break;
                      case 'Cantidad'   : FocusScope.of(context).requestFocus(_focoCategorias);
                                          break;
                      case 'Categorias' : FocusScope.of(context).requestFocus(_focoMarcas);
                                          break;
                      case 'Marcas'     : FocusScope.of(context).requestFocus(_focoPrecioUno);
                                          break;
                      case 'Precio Uno' : FocusScope.of(context).requestFocus(_focoPrecioDos);
                                          break;
                      case 'Precio Dos' : FocusScope.of(context).requestFocus(_focoPrecioTres);
                                          break;
                      case 'Precio Tres': print('hola');
                                          break;
                      default           : break;    
                    }
       },
       onChanged:(value){
                    switch (texto) {
                      case 'Codigo'     : producto.codigo = texto;
                                          break;
                      case 'Nombre'     : producto.nombre = texto;
                                          break;
                      case 'Cantidad'   : producto.cantidad = int.parse(texto);
                                          break;
                      case 'Categorias' : producto.categoria = texto;
                                          break;
                      case 'Marcas'     : producto.marca = texto;
                                          break;
                      case 'Precio Uno' : producto.precioUno = int.parse(texto);
                                          break;
                      case 'Precio Dos' : producto.precioDos = int.parse(texto);
                                          break;
                      case 'Precio Tres': producto.precioTres = int.parse(texto);
                                          break;
                      default           : break;    
                    }

       },  
       validator: (value){
                   if(value.isEmpty) return "Es requerido";
                   return null;
       },         
      );
 }
  Widget registroButton() => MaterialButton(
                             height    : 50,
                             minWidth  : double.maxFinite,
                             color     : Colors.purple,
                             child     : Text("Ingresar",
                                               style: TextStyle(color: Colors.white)
                                             ),
                             onPressed :(){
                                if(_formKey.currentState.validate())
                                     print('ok');
                             },
  );





  void _snackBar(String mensaje) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text(mensaje))
     );
 }


}