import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/clientes/bloc/clientes_bloc.dart';
import 'package:panchita/src/componentes/clientes/models/cliente_model.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/plugins/custom_icon_icons.dart';

class CreateClientePage extends StatefulWidget {

  final bool update;
  final Cliente  cliente;

  CreateClientePage({Key key,this.update = false,this.cliente}) : super(key: key);
  @override
  _CreateClientePageState createState() => _CreateClientePageState();
}

class _CreateClientePageState extends State<CreateClientePage> {

   @override
   void initState() { 
     super.initState();
     if(widget.update)  _setCliente(widget.cliente);
    }
   List<Ciudad> ciudades = List();
   String ruta;
 
  final _nombreController     = TextEditingController();
  final _cedulaController     = TextEditingController();
  final _telefonoController   = TextEditingController();
  final _direccionController  = TextEditingController();
  final _ciudadController     = TextEditingController();
 

  final _focoNombre    = FocusNode();
  final _focoCedula    = FocusNode();
  final _focoTelefono  = FocusNode();
  final _focoDireccion = FocusNode();
  final _focoCiudad    = FocusNode();


  final _scaffoldKey  = GlobalKey<ScaffoldState>();
  final _formKey      = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
         ciudades = context.bloc<LoginBloc>().ciudades;
         return Scaffold(
           appBar: AppBar(
                   title: Text("${ widget.update ? 'Actualizar' : 'Crear'} Cliente",style: TextStyle(color:Colors.black))),
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                        child: BlocConsumer<ClientesBloc,ClientesState>(
                               listener: (context,state){
                                    if(state.agregado)
                                        _snackBar("Cliente Agregado");
                                    if(state.duplicado)
                                        _snackBar("Cliente Ya Existe");
                                    if(state.actulizado)
                                        _snackBar("Cliente Actulizado");
                               },
                               builder: (context,state){
                                 
                                     
                               return  Form(
                                       key  : _formKey,
                                       child: Container(
                                              padding: EdgeInsets.all(33),
                                              child: Column(
                                                 children: <Widget>[
                                                            input("Nombre",_nombreController,Icon(CustomIcon.account_outline),_focoNombre),
                                                            SizedBox(height: 20),
                                                            input("Cedula",_cedulaController,Icon(Icons.credit_card),_focoCedula),
                                                            SizedBox(height: 20),
                                                            input("Telefono",_telefonoController,Icon(Icons.phone_android),_focoTelefono),
                                                            SizedBox(height: 20),
                                                            input("Direccion",_direccionController,Icon(Icons.markunread_mailbox),_focoDireccion),
                                                            SizedBox(height: 20),
                                                            input("Ciudad",_ciudadController,Icon(Icons.map),_focoCiudad),
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
                 case 'Nombre'     : textinput=TextInputAction.next;
                                     break;
                 case 'Cedula'     : textinput=TextInputAction.next;
                                     break;
                 case 'Telefono'   : textinput=TextInputAction.next;
                                     break;
                 case 'Categorias' : textinput=TextInputAction.next;
                                     break;
                 case 'Ciudad'     : textinput=TextInputAction.done;
                                     break;
                 default:            break;
         }
        
       return TextFormField(
       readOnly   : texto == 'Ciudad'  ?  true : false,
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
                      case 'Nombre'     : FocusScope.of(context).requestFocus(_focoCedula);
                                          break;
                      case 'Cedula'     : FocusScope.of(context).requestFocus(_focoTelefono);
                                           break;
                      case 'Telefono'   : FocusScope.of(context).requestFocus(_focoDireccion);
                                          break;
                      case 'Direccion'  : FocusScope.of(context).requestFocus(_focoCiudad);
                                          break;
                                          
                      case 'Ciudad'     : if(_formKey.currentState.validate())
                                          _createCliente(update:widget.update);
                                          break;
                      default           : break;    
                    }
       },
      /*  onChanged:(value){
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

       }, */   
       validator: (value){
                   if(value.isEmpty) return "Es requerido";
                   return null;
       }, 
       onTap: (){
              if(texto == 'Ciudad')
               _selectInput(context, ciudades);
          
       },        
      );
 }
  Widget registroButton() => MaterialButton(
                             height    : 50,
                             minWidth  : double.maxFinite,
                             color     : Colors.pink,
                             child     : widget.update 
                                         ? Text("Actulizar Cliente",
                                               style: TextStyle(color: Colors.white)
                                             )
                                         : Text("Guardar Cliente",
                                               style: TextStyle(color: Colors.white)
                                             ),
                             onPressed :(){
                                if(_formKey.currentState.validate())
                                      _createCliente(update: widget.update);
                                   
                             },
  );


 _selectInput(BuildContext context,List<Ciudad> items) {
     showModalBottomSheet(
     context: context, 
     builder:(context){
        return Container(
               padding: EdgeInsets.all(20),
               height: MediaQuery.of(context).size.height *0.5,
               child : ListView.builder(
                       itemCount: items.length,
                       itemBuilder:(context,index){
                    
                           return ListTile(
                                title: Text(items[index].ciudad),
                                onTap: (){
                                   _ciudadController.text =items[index].ciudad;
                                   ruta = items[index].ruta;
                                   Navigator.pop(context);
                                   },
                                );
                   
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
     )..closed.then((_){
         if(mensaje == "Cliente Agregado" || mensaje == "Cliente Actulizado")
            Navigator.pop(context);
     });
 }
/* 
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


  } */
/*    _resetForm(){
   _nombreController.clear();    
   _ciudadController.clear();
   _telefonoController.clear();    
   _direccionController.clear();    
   _ciudadController.clear(); 
  }
 */
  _createCliente({bool update = false}){
     final cliente = Cliente(
                     id        :  widget.update ? widget.cliente.id : '',
                     nombre    : _nombreController.text,
                     cedula    : _cedulaController.text,
                     telefono  : _telefonoController.text,
                     direccion : _direccionController.text,
                     ciudad    : Ciudad(
                                ciudad : _ciudadController.text,
                                ruta   : ruta
                                )
                     );
     
     if(update)
       context.bloc<ClientesBloc>().add(
       UpdateClienteEvent(cliente: cliente)
     );
     else context.bloc<ClientesBloc>().add(
       CreateClienteEvent(cliente: cliente)
     );

  }

   _setCliente(Cliente cliente) {
      _nombreController.text    = cliente.nombre;
      _cedulaController.text    = cliente.cedula;    
      _ciudadController.text    = cliente.ciudad.ciudad;
      _telefonoController.text  = cliente.telefono;    
      _direccionController.text = cliente.direccion;
       ruta                     = cliente.ciudad.ruta;
    }
  
}