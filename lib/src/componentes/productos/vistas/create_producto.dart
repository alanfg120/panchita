import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/productos/bloc/productos_bloc.dart';
import 'package:panchita/src/componentes/productos/models/producto_model.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';

class CreateProductoPage extends StatefulWidget {
  CreateProductoPage({Key key}) : super(key: key);
  @override
  _CreateProductoPageState createState() => _CreateProductoPageState();
}

class _CreateProductoPageState extends State<CreateProductoPage> {

  Producto producto = Producto(foto:'',cantidadCompra: 1,descripcion: '');
  List  categorias  = List(); 
  List  marcas      = List(); 
 
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

         categorias = context.bloc<ProductosBloc>().categorias;
         marcas     = context.bloc<ProductosBloc>().marcas;

    return Scaffold(
         
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                        child: BlocConsumer<ProductosBloc,ProductosState>(
                               listener: (context,state){
                             
                               },
                               builder: (context,state){
                               return  Form(
                                       key  : _formKey,
                                       child: Container(
                                              padding: EdgeInsets.all(33),
                                              child: Column(
                                                 children: <Widget>[
                                                            input("Codigo",_codigoController,Icon(CustomIcon.barcode),_focoCodigo,producto),
                                                            SizedBox(height: 20),
                                                            input("Nombre",_nombreController,Icon(CustomIcon.card_text),_focoNombre,producto),
                                                            SizedBox(height: 20),
                                                            input("Categorias",_categoriasController,Icon(CustomIcon.format_list_checkbox),_focoCategorias,producto),
                                                            SizedBox(height: 20),
                                                            input("Marcas",_marcasController,Icon(CustomIcon.tag_text_outline),_focoMarcas,producto),
                                                            SizedBox(height: 20),
                                                            input("Precio Uno",_precioUnoController,Icon(CustomIcon.cash_usd_outline),_focoPrecioUno,producto),
                                                            SizedBox(height: 20),
                                                            input("Precio Dos",_precioDosController,Icon(CustomIcon.cash_usd_outline),_focoPrecioDos,producto),
                                                            SizedBox(height: 20),
                                                            input("Precio Tres",_precioTresController,Icon(CustomIcon.cash_usd_outline),_focoPrecioTres,producto),
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
                 default:            break;
         }
        
       return TextFormField(
       readOnly   : texto == 'Categorias' || texto == 'Marcas' ?  true : false,
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
                      case 'Precio Tres': _dialogConfirm();
                                          break;
                      default           : break;    
                    }
       },
       onChanged:(value){
                    switch (texto) {
                      case 'Codigo'     : producto.codigo = value;
                                          break;
                      case 'Nombre'     : producto.nombre = value;
                                          break;
                      case 'Categorias' : producto.categoria = value;
                                          break;
                      case 'Marcas'     : producto.marca = value;
                                          break;
                      case 'Precio Uno' : producto.precioUno = int.parse(value);
                                          break;
                      case 'Precio Dos' : producto.precioDos = int.parse(value);
                                          break;
                      case 'Precio Tres': producto.precioTres = int.parse(value);
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
                                    _dialogConfirm();
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
                                       producto.categoria= items[index]; 
                                   }
                                   if(preferencia == 'marcas'){
                                      _marcasController.text = items[index]; 
                                      producto.marca=items[index];
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
       SnackBar(content: Text(mensaje))
     );
 }

  void _dialogConfirm() {
    showDialog(
    context: context,
    child: AlertDialog(
           title: Text('Agregar producto'),
           content: Text('Desea agregar este producto al pedido'),
           actions: <Widget>[
                      RaisedButton(
                      color     : Colors.red,
                      child     : Text("Si",style:TextStyle(color:Colors.white)),
                      onPressed : (){},
                      ),
                      OutlineButton(
                      child     : Text("No",style:TextStyle(color:Colors.red)),
                      onPressed : ()=>Navigator.pop(context)
                      )   
           ],
    )
    );
  }


}