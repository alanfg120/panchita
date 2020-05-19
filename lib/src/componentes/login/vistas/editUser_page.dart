import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';

class EditUserPage extends StatefulWidget {
  EditUserPage({Key key}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
    
  Usuario usuario;
  List<Ciudad> ciudades;
  double half;

  
 
  final _nombreController    = TextEditingController();
  final _cedulaController    = TextEditingController();
  final _direccionController = TextEditingController();
  final _ciudadController    = TextEditingController();
  final _telefonoController  = TextEditingController();
  
   
 

  final _focoNombre    = FocusNode();
  final _focoCedula    = FocusNode();
  final _focoDireccion = FocusNode();
  final _focoCiudad    = FocusNode();
  final _focoTelefono  = FocusNode();

  final _formKey         = GlobalKey<FormState>();
  final _scaffoldKey     = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc,LoginState>(
           listener:(context,state){
                 if(state is AutenticadoState){
                    if(state.edit)_snakBar("Datos Actualizados");
                      
                 }
           },
           builder:(context,state){
                     if(state is AutenticadoState){
                          usuario = state.usuario;
                          ciudades= state.ciudades;
                          _nombreController.text = usuario.nombre;
                          _cedulaController.text = usuario.cedula;
                          _direccionController.text  = usuario.direccion;
                          _telefonoController.text   = usuario.telefono;
                          _ciudadController.text     = usuario.ciudad.ciudad;
                      }
                       
                    return Scaffold(
                    key: _scaffoldKey,
                    appBar : AppBar(
                             title: Text("Edita tus datos"),
                    ),
                    body:SingleChildScrollView (
                         child: Form(
                                     key  : _formKey,
                                     child: Container(
                                            padding: EdgeInsets.all(40),
                                            child: Column(
                                                   children: <Widget>[
                                                              input("Nombres y apellidos",_nombreController,Icon(Icons.person_outline),_focoNombre,usuario),
                                                              SizedBox(height: 20),
                                                              input("Identificacion",_cedulaController,Icon(Icons.credit_card),_focoCedula,usuario),
                                                              SizedBox(height: 20),
                                                              input("Direccion",_direccionController,Icon(Icons.map),_focoDireccion,usuario),
                                                              SizedBox(height: 20),
                                                              input("Telefono",_telefonoController,Icon(Icons.phone),_focoTelefono,usuario),
                                                              SizedBox(height: 20),
                                                              input("Ciudad",_ciudadController,Icon(Icons.location_searching),_focoCiudad,usuario),
                                                              SizedBox(height: 20),
                                                              editButton(),
                                                              SizedBox(height: 20),
                                                 
                                                              
                                                             ],
                                              ),
                                     ),
                            ),
                    ),
                    );
                 }      );
  }
  Widget input(String texto, TextEditingController controller,Icon icono,foco,Usuario usuario){
        TextInputAction textinput;
         if(
         texto == 'Nombres y apellidos'||
         texto == 'Identificacion'     || 
         texto == 'Direccion'          ||
         texto == 'Telefono'          

        )
               textinput=TextInputAction.next;
         else  textinput=TextInputAction.done;
        
       return TextFormField(
       textInputAction: textinput,
       readOnly   : texto == 'Ciudad' ? true : false,
       focusNode  : foco,
       obscureText: texto == 'Contraseña' ? true : false,
       controller : controller,
       decoration : InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: texto == 'Ciudad' ? IconButton(icon: Icon(Icons.add),onPressed: ()=>_addCiudad(context,half)): null,
                    helperText: texto == 'Ciudad' ? 'Agrege tu lugar de residencia' : null,
                    prefixIcon: icono,
                    hintText: texto,
                    border: OutlineInputBorder()
                    ),
       onEditingComplete:(){
                    switch (texto) {
                     
                      case 'Nombres y apellidos' : FocusScope.of(context).requestFocus(_focoCedula);
                                                   break;
                      case 'Identificacion'      : FocusScope.of(context).requestFocus(_focoDireccion);
                                                   break;
                      case 'Direccion'           : FocusScope.of(context).requestFocus(_focoCiudad);
                                                   break;
                      case 'Telefono'            : FocusScope.of(context).requestFocus(_focoCiudad);
                                                   break;
                      default                    : break;    
                    }
       },
       onChanged:(value){
                   switch (texto) {
                      case 'Nombres y apellidos': usuario.nombre = value;
                                                  break;
                      case 'Identificacion'     : usuario.cedula = value;
                                                  break;
                      case 'Direccion'          : usuario.direccion = value;
                                                  break;
                      case 'Telefono'           : usuario.telefono = value;
                                                  break;
                      default                   : break;    
                    }

       },
       validator:   texto != 'Telefono' ?
                   (value){
                    Pattern pattern = r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$';
                    RegExp   regex = new RegExp(pattern);
                    if(value.isEmpty) return "Es requerido";
                    if(texto== 'Correo') 
                      if(!regex.hasMatch(value))
                        return "No es Correo Valido";
                   
                    return null;
                   }:
                   null,            
       );
 }
   Widget editButton() => MaterialButton(
                             height    : 50,
                             minWidth  : double.maxFinite,
                             color     : Colors.pink,
                             child     : Text("Editar",
                                              style: TextStyle(color: Colors.white)
                                             ),
                             onPressed :(){
                               if(_formKey.currentState.validate())
                                    BlocProvider.of<LoginBloc>(context).add(EditUsuarioEvent(usuario: usuario));
                             },
  );
 _addCiudad(BuildContext context,double half) {
     showModalBottomSheet(
     context: context, 
     builder:(context){
        return Container(
               padding: EdgeInsets.all(20),
               height: half,
               child : ListView.builder(
                       itemCount: ciudades.length,
                       itemBuilder:(context,index){
                         return ListTile(
                                title: Text(ciudades[index].ciudad),
                                onTap: (){
                                  _ciudadController.text = ciudades[index].ciudad;
                                   usuario.ciudad = Ciudad(ruta:ciudades[index].ruta,ciudad: ciudades[index].ciudad);
                                   Navigator.pop(context);
                                   },
                                );
                       } 
                       )
               );
     });
  }

  void _snakBar(String mensaje) { 
     _scaffoldKey.currentState.showSnackBar(
        SnackBar(
         content  : Text(mensaje),
         duration : Duration(seconds: 2),
        )
     )..closed.then((_){
         Navigator.pop(context);
     });
  } 
}