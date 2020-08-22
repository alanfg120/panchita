import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/status_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
   Usuario usuario;
  final _correoController    = TextEditingController();
  final _passwordController  = TextEditingController();

   
  final _focousuario   = FocusNode();
  final _focopassword  = FocusNode();

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
                            /*  if(state is AuthenticationSuccessState)
                                Navigator.pushReplacementNamed(context, 'home'); */
                             if(state is AutenticandoState){
                                if(state.registro==StatusLogin.incompleto)
                                  Navigator.pushNamed(context, 'finish');
                                if(state.registro==StatusLogin.error)
                                 _snackBar("Ocurrio un error");
                                if(state.registro==StatusLogin.incorrectos)
                                 _snackBar("Datos Incorrectos");
                                if(state.registro==StatusLogin.no_registrado)
                                 _snackBar("Usuario no registrado");
                             }
                           },
                           builder: (context,state){
                             if(state is AutenticandoState){
                                  usuario  = state.usuario;
                                  _correoController.text   = state.usuario.email;
                                  _passwordController.text = state.usuario.password;
                             }
                         
                           
                           return  Form(
                                   key  : _formKey,
                                   child: Container(
                                          padding: EdgeInsets.all(33),
                                          child: Column(
                                                 children: <Widget>[
                                                            logo(),
                                                            //SizedBox(height: 30),
                                                            input("Correo",_correoController,Icon(Icons.mail_outline),_focousuario,usuario),
                                                            SizedBox(height: 20),
                                                            input("Contraseña",_passwordController,Icon(Icons.lock),_focopassword,usuario),
                                                            SizedBox(height: 10),
                                                            olvidoPassword(),
                                                            SizedBox(height: 20),
                                                            registroButton(),
                                                            SizedBox(height: 20),
                                                            singGoogle(),
                                                            singUptext()
                                                            
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
         if(texto == 'Correo')
               textinput=TextInputAction.next;
         else  textinput=TextInputAction.done;
        
       return TextFormField(
       textInputAction: textinput,
       focusNode  : foco,
       obscureText: texto == 'Contraseña' ? true : false,
       controller : controller,
       decoration : InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: icono,
                    hintText: texto,
                    border: OutlineInputBorder()
                    ),
       onEditingComplete:(){
                    switch (texto) {
                      case 'Correo'    : FocusScope.of(context).requestFocus(_focopassword);
                                          break;
                      case 'Contraseña' :  if(_formKey.currentState.validate())
                                             BlocProvider.of<LoginBloc>(context).add(AuthEvent(usuario: usuario));
                                          break;
                   
                      default           :  break;    
                    }
       },
       onChanged:(value){
                   switch (texto) {
                      case 'Correo'    :  usuario.email   = value;
                                          break;
                      case 'Contraseña' : usuario.password   = value;
                                          break;
                    
                      default           : break;    
                    }

       },  
       validator: (value){
                    Pattern pattern = r'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$';
                    RegExp   regex = new RegExp(pattern);
                    if(value.isEmpty) return "Es requerido";
                    if(texto== 'Correo') 
                      if(!regex.hasMatch(value))
                        return "No es un correo valido";
                   
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
                                     BlocProvider.of<LoginBloc>(context).add(AuthEvent(usuario: usuario));
                             },
  );

  Widget singGoogle() => Column(
                         children: <Widget>[
                         Text("o Ingresa Mediante la Cuenta de"),
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
                         BlocProvider.of<LoginBloc>(context).add(AuthGoogleEvent());
                         },
                         ),
                         
                         ]);

  Widget logo() =>   Container(
                     alignment: Alignment.center,
                     height: 180,
                     child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                    Container(
                                     height     : 100,
                                     width      : 250,
                                     decoration : BoxDecoration(
                                                  image: DecorationImage(
                                                         image : AssetImage('assets/logoLogin.png'),
                                                         fit   : BoxFit.cover
                                                         ),
                                     ),  
                                    ),
                                    SizedBox(height: 10),
                                    Text("Bienvenido Panchita Cliente",
                                    style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),  
                                    ),
                                    SizedBox(height: 5),
                                    Text("Ingresa y gestiona tus Pedidos")
                            ],
                            )
                     );

  void _snackBar(String mensaje) {
     _scaffoldKey.currentState.showSnackBar(
       SnackBar(content: Text(mensaje))
     );

  }
  Widget olvidoPassword()=> Container(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                   child: Text("Olvidaste tu Contraseña?"),
                                   onTap: (){print("object");},
                            ),
                           );

  Widget singUptext()=> Container(
                        padding : EdgeInsets.all(10),
                        child   : Center(
                                  child: RichText(
                                         text: TextSpan(
                                               text    : 'No tienes Una Cuenta?',
                                               style   : TextStyle(color: Colors.black),
                                               children: <TextSpan>[
                                                         TextSpan(
                                                         text      : ' Registrate',
                                                         style     : TextStyle(
                                                         color     : Colors.blueAccent, fontSize: 16),
                                                         recognizer: TapGestureRecognizer()
                                                         ..onTap = () => Navigator.pushReplacementNamed(context, 'registro')
                                                         )
                                                        ]
                                         )
                                  ),
                         )
                        );


}