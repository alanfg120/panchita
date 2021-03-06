import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/pedidos/bloc/pedidos_bloc.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';

class CreateProductoPage extends StatefulWidget {
  CreateProductoPage({Key key}) : super(key: key);
  @override
  _CreateProductoPageState createState() => _CreateProductoPageState();
}

class _CreateProductoPageState extends State<CreateProductoPage> {


  List  categorias  = List(); 
  List  marcas      = List(); 
 
  final _codigoController     = TextEditingController();
  final _categoriasController = TextEditingController();
  final _marcasController     = TextEditingController();
  final _nombreController     = TextEditingController();
  final _precioUnoController  = TextEditingController();
  final _precioDosController  = TextEditingController();
  final _precioTresController = TextEditingController();

  final _focoCodigo      = FocusNode();
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

         categorias = context.bloc<ProductosBloc>().categorias;
         marcas     = context.bloc<ProductosBloc>().marcas;

    return Scaffold(
          
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                        child: BlocConsumer<ProductosBloc,ProductosState>(
                               listener: (context,state){
                                       if(state.productoAdd)
                                          _dialogConfirm();
                                       if(state.existProducto)
                                          _snackBar("Ya existe el producto o estas desconectado");
                               },
                               builder: (context,state){
                               return  Form(
                                       key  : _formKey,
                                       child: Container(
                                              padding: EdgeInsets.all(33),
                                              child: Column(
                                                 children: <Widget>[
                                                            input("Codigo",_codigoController,Icon(CustomIcon.barcode),_focoCodigo),
                                                            SizedBox(height: 20),
                                                            input("Nombre",_nombreController,Icon(CustomIcon.card_text),_focoNombre),
                                                            SizedBox(height: 20),
                                                            input("Categorias",_categoriasController,Icon(CustomIcon.format_list_checkbox),_focoCategorias),
                                                            SizedBox(height: 20),
                                                            input("Marcas",_marcasController,Icon(CustomIcon.tag_text_outline),_focoMarcas),
                                                            SizedBox(height: 20),
                                                            input("Precio Uno",_precioUnoController,Icon(CustomIcon.cash_usd_outline),_focoPrecioUno),
                                                            SizedBox(height: 20),
                                                            input("Precio Dos",_precioDosController,Icon(CustomIcon.cash_usd_outline),_focoPrecioDos),
                                                            SizedBox(height: 20),
                                                            input("Precio Tres",_precioTresController,Icon(CustomIcon.cash_usd_outline),_focoPrecioTres),
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

Widget input(String texto, TextEditingController controller,Icon icono,foco){
  
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
                 default:            break;
         }
        
       return TextFormField(
       readOnly   : texto == 'Categorias' || texto == 'Marcas' ?  true : false,
       textInputAction: textinput,
       keyboardType: texto == 'Precio Uno' || texto == 'Precio Dos' || texto == 'Precio Tres' ? TextInputType.numberWithOptions(signed: false,decimal: false) : TextInputType.text,
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
                      case 'Nombre'     : FocusScope.of(context).requestFocus(_focoCategorias);
                                          break;
                      case 'Categorias' : FocusScope.of(context).requestFocus(_focoMarcas);
                                          break;
                      case 'Marcas'     : FocusScope.of(context).requestFocus(_focoPrecioUno);
                                          break;
                      case 'Precio Uno' : FocusScope.of(context).requestFocus(_focoPrecioDos);
                                          break;
                      case 'Precio Dos' : FocusScope.of(context).requestFocus(_focoPrecioTres);
                                          break;
                      case 'Precio Tres': _createProducto();
                                          break;
                      default           : break;    
                    }
       },
       validator: (value){
                   if(value.isEmpty) return "Es requerido";
                   return null;
       }, 
       onTap: (){
              if(texto == 'Categorias')
               _selectInput(context, categorias, 'categorias');
              if(texto == 'Marcas')
               _selectInput(context, marcas, 'marcas');
       },        
      );
 }
  Widget registroButton() => MaterialButton(
                             height    : 50,
                             minWidth  : double.maxFinite,
                             color     : Colors.pink,
                             child     : Text("Guardar Producto",
                                               style: TextStyle(color: Colors.white)
                                             ),
                             onPressed :(){
                                if(_formKey.currentState.validate())
                                      _createProducto();
                                   
                             },
  );


 _selectInput(BuildContext context,List items,String preferencia) {
     showModalBottomSheet(
     context: context, 
     builder:(context){
        return Container(
               padding: EdgeInsets.all(20),
               height: MediaQuery.of(context).size.height *0.5,
               child : ListView.builder(
                       itemCount: items.length,
                       itemBuilder:(context,index){
                       if(items[index] != 'Todos')
                           return ListTile(
                                title: Text(items[index]),
                                onTap: (){
                                   if(preferencia == 'categorias'){
                                       _categoriasController.text = items[index];
                                        
                                   }
                                   if(preferencia == 'marcas'){
                                      _marcasController.text = items[index]; 
                                     
                                   }
                                      
                                   Navigator.pop(context);
                                   },
                                );
                        else return Container();
                       } 
                       )
               );
     });
  } 


  void _snackBar(String mensaje) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(
       content  : Text(mensaje),
       duration : Duration(seconds: 2),
       action   : SnackBarAction(label: "Aceptar", onPressed: (){})
       )
     );
 }

  void _dialogConfirm() {

    showDialog(
    context: context,
    child: AlertDialog(
           title: Text('Producto Agregado'),
           content: Text('Desea agregar este producto al pedido'),
           actions: <Widget>[
                      RaisedButton(
                      color     : Colors.red,
                      child     : Text("Si",style:TextStyle(color:Colors.white)),
                      onPressed : (){
                           Navigator.pop(context); 
                           _createProducto(agregar: true);
                          _resetForm();              
                      },
                      ),
                      OutlineButton(
                      child     : Text("No",style:TextStyle(color:Colors.red)),
                      onPressed : (){ 
                       Navigator.pop(context);
                       _resetForm();
                      }
                      )   
           ],
    )
    );


  }
   _resetForm(){
   _codigoController.clear();    
   _categoriasController.clear();
   _marcasController.clear();    
   _nombreController.clear();    
   _precioUnoController.clear(); 
   _precioDosController.clear();
   _precioTresController.clear();
  }

  _createProducto({bool agregar = false}){
      final   producto = Producto(
                    codigo         : _codigoController.text,
                    nombre         : _nombreController.text,
                    cantidadCompra : 1,
                    categoria      : _categoriasController.text,
                    marca          : _marcasController.text,
                    precioUno      : int.parse(_precioUnoController.text),
                    precioDos      : int.parse(_precioDosController.text),
                    precioTres     : int.parse(_precioTresController.text),
                    foto           : ''
   ); 
   if(agregar)
     context.bloc<PedidosBloc>().add(
     AddProductoEvent(producto: producto)
     );
   else context.bloc<ProductosBloc>().add(
     CreateProductoEvent(producto: producto)
    );
  }
  
}