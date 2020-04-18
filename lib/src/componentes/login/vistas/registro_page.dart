import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/login/models/status_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';



class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  
  Usuario usuario;
  List<Ciudad> ciudades;
  double half;

  final _correoController    = TextEditingController();
  final _passwordController  = TextEditingController();
  final _nombreController    = TextEditingController();
  final _cedulaController    = TextEditingController();
  final _direccionController = TextEditingController();
  final _ciudadController    = TextEditingController();
  final _telefonoController  = TextEditingController();
  
   
  final _focoCorreo    = FocusNode();
  final _focoPassword  = FocusNode();
  final _focoNombre    = FocusNode();
  final _focoCedula    = FocusNode();
  final _focoDireccion = FocusNode();
  final _focoCiudad    = FocusNode();
  final _focoTelefono  = FocusNode();
  
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey     = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     half = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
           key: _scaffoldKey,
           body: GestureDetector(
                 onTap: ()=>FocusScope.of(context).unfocus(),
                 child: SingleChildScrollView(
                      
                           child: BlocConsumer<LoginBloc,LoginState>(
                           listener: (context,state){
                                  if(state is AutenticandoState){
                                      switch (state.registro) {
                                              case StatusLogin.registrado : _snackBar("Usuario Registrado");
                                                                            break;
                                              case StatusLogin.completo   : _snackBar("Registro Completo");
                                                                            break;
                                              case StatusLogin.duplicado : _snackBar("Usuario Ya esta Registrado");
                                                                            break;
                                              case StatusLogin.error     : _snackBar("Ocurrio un Error");
                                                                            break;
                                              default:
                                      }
                                  
                                  }
                           },
                           builder: (context,state){
                            if(state is AutenticandoState){
                                usuario = state.usuario;
                                ciudades= state.ciudades;
                            }
                          
                           return  Form(
                                   key  : _formKey,
                                   child: Container(
                                          padding: EdgeInsets.all(40),
                                          child: Column(
                                                 children: <Widget>[
                                                            logo(),
                                                            //SizedBox(height: 30),
                                                            input("Correo",_correoController,Icon(Icons.mail_outline),_focoCorreo,usuario),
                                                            SizedBox(height: 20),
                                                            input("Contraseña",_passwordController,Icon(Icons.lock),_focoPassword,usuario),
                                                            SizedBox(height: 20),
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
                                                            registroButton(),
                                                            SizedBox(height: 20),
                                                            singGoogle()
                                                            
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

Widget input(String texto, TextEditingController controller,Icon icono,foco,Usuario usuario){
        TextInputAction textinput;
         if(
         texto == 'Correo'             || 
         texto == 'Contraseña'         ||
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
                      case 'Correo'             : FocusScope.of(context).requestFocus(_focoPassword);
                                                   break;
                      case 'Contraseña'          : FocusScope.of(context).requestFocus(_focoNombre);
                                                   break;
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
                      case 'Correo'            :  usuario.email   = value;
                                                  break;
                      case 'Contraseña'         : usuario.password= value;
                                                  break;
                      case 'Nombres y apellidos': usuario.nombre = value;
                                                  break;
                      case 'Identificacion'     : usuario.cedula = value;
                                                  break;
                      case 'Direccion'          : usuario.dirrecion = value;
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
  Widget registroButton() => MaterialButton(
                             height    : 50,
                             minWidth  : double.maxFinite,
                             color     : Colors.purple,
                             child     : Text("Registrase",
                                              style: TextStyle(color: Colors.white)
                                             ),
                             onPressed :(){
                               if(_formKey.currentState.validate())
                                    BlocProvider.of<LoginBloc>(context).add(RegistroEvent(usuario: usuario));
                             },
  );

  Widget singGoogle() => Column(
                         children: <Widget>[
                         Text("o Registrese Mediante la Cuenta de"),
                         SizedBox(height: 15),
                         GestureDetector(
                         child: Card(
                                shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(20.0),
                                       ),
                                child: Padding(
                                       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                                       child: Image(
                                              height : 40,
                                              width  : 80,
                                              image  : AssetImage('assets/google.png'),
                                              ),
                                ),
                         ),
                         onTap: (){
                          BlocProvider.of<LoginBloc>(context).add(RegistroGoogleEvent());
                         },
                         ),
                         singUptext()
                         ]);

  Widget logo() =>   Container(
                     alignment: Alignment.center,
                     height: 180,
                     child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                    Image(
                                      height : 90,
                                      width  : 90,
                                      image  : AssetImage('assets/logo.png'), 
                                    ),
                                    SizedBox(height: 10),
                                    Text("Bienvenido A Panchita Clientes",
                                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),  
                                    ),
                                    SizedBox(height: 5),
                                    Text("Crea Una Cuenta")
                            ],
                            )
                     );

  

  void _snackBar(String mensaje) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(
       behavior: SnackBarBehavior.floating,
       content: Text(mensaje),
       duration: Duration(seconds: 2),
       )
     )..closed.then((razon){
        if(mensaje=='Usuario Registrado')
          Navigator.pushReplacementNamed(context, 'finish');
        if(mensaje=='Registro Completo')
          Navigator.pushReplacementNamed(context, 'login');
     });

  }
  Widget singUptext()=> Container(
                        padding : EdgeInsets.all(10),
                        child   : Center(
                                  child: RichText(
                                         text: TextSpan(
                                               text    : 'Ya tienes Una Cuenta? ',
                                               style   : TextStyle(color: Colors.black),
                                               children: <TextSpan>[
                                                         TextSpan(
                                                         text      : 'Inicia Session',
                                                         style     : TextStyle(
                                                         color     : Colors.blueAccent, fontSize: 16),
                                                         recognizer: TapGestureRecognizer()
                                                         ..onTap = () => Navigator.pushReplacementNamed(context, 'login')
                                                         )
                                                        ]
                                         )
                                  ),
                         )
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
}