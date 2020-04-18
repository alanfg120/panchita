import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panchita/src/componentes/login/bloc/login_bloc.dart';
import 'package:panchita/src/componentes/login/models/ciudad_model.dart';
import 'package:panchita/src/componentes/login/models/usuario_model.dart';



class FinishRegistroPage extends StatefulWidget {
  FinishRegistroPage({Key key}) : super(key: key);

  @override
  _FinishRegistroPageState createState() => _FinishRegistroPageState();
}

class _FinishRegistroPageState extends State<FinishRegistroPage> {
  
  Usuario usuario;
  double half;
  List<Ciudad> ciudades;

  final _nombreController    = TextEditingController();
  final _cedulaController    = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController  = TextEditingController();
  final _ciudadController    = TextEditingController();

  final _focoNombre     = FocusNode();
  final _focoCedula     = FocusNode();
  final _focoDireccion  = FocusNode();
  final _focoTelefono   = FocusNode();
  final _focoCiudad     = FocusNode();

  final  _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey      = GlobalKey<FormState>();

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
                                if(state is AutenticadoState)
                                   Navigator.pushReplacementNamed(context, 'home');
                           },
                           builder: (context,state){

                           if(state is AutenticandoState){
                              _nombreController.text    = state.usuario.nombre;
                               usuario = state.usuario;
                               ciudades= state.ciudades;
                           }
                             
                          
                           return  Form(
                                   key: _formKey,
                                   child: Container(
                                          padding: EdgeInsets.all(40),
                                          child: Column(
                                                 children: <Widget>[
                                                            logo(),
                                                            //SizedBox(height: 30),
                                                           
                                                            input("Nombre y apellidos",_nombreController,Icon(Icons.person_outline),_focoNombre,usuario),
                                                            SizedBox(height: 20),
                                                            input("Identificacion",_cedulaController,Icon(Icons.credit_card),_focoCedula,usuario),
                                                            SizedBox(height: 20),
                                                            input("Direccion",_direccionController,Icon(Icons.map),_focoDireccion,usuario),
                                                            SizedBox(height: 20),
                                                            input("Telefono",_telefonoController,Icon(Icons.phone),_focoTelefono,usuario),
                                                            SizedBox(height: 20),
                                                            input("Ciudad",_ciudadController,Icon(Icons.location_city),_focoCiudad,usuario),
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

Widget input(String texto, TextEditingController controller,Icon icono,foco,Usuario usuario){
        TextInputAction textinput;
         if(texto == 'Nombre y apellidos' || 
            texto == 'Identificacion'     ||
            texto == 'Direccion'          ||
            texto == 'Telefono'           
            )
               textinput=TextInputAction.next;
         else  textinput=TextInputAction.done;
        
       return TextFormField(
       textInputAction: textinput,
       focusNode  : foco,
       readOnly   : texto == 'Ciudad' ?     true : false,
       obscureText: texto == 'Contraseña' ? true : false,
       controller : controller,
       decoration : InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    helperText: texto == 'Ciudad' ? "Seleciona Tu ciudad": null,
                    prefixIcon: icono,
                    suffixIcon: texto == 'Ciudad' ? IconButton(icon: Icon(Icons.add),onPressed: ()=>_addCiudad(context,half)) : null,
                    hintText: texto,
                    border: OutlineInputBorder()
                    ),
       onEditingComplete:(){
                    switch (texto) {
                      case 'Nombre y apellidos': FocusScope.of(context).requestFocus(_focoCedula);
                                                 break;
                      case 'Identificacion'    : FocusScope.of(context).requestFocus(_focoDireccion);
                                                 break;
                      case 'Direccion'         : FocusScope.of(context).requestFocus(_focoTelefono);
                                                 break;
                      case 'Telefono'          : FocusScope.of(context).requestFocus(_focoCiudad);
                                                 break;
                      default           :  break;    
                    }
       },
       onChanged:(value){
                   switch (texto) {
                      case 'Nombre y apellidos' : usuario.email     = value;
                                                  break;
                      case 'Identificacion'     : usuario.cedula    = value;
                                                  break;
                      case 'Direccion'          : usuario.dirrecion = value;
                                                  break;
                      case 'Telefono'           : usuario.telefono = value;
                                                  break;
                      default                   : break;    
                    }

       },      
       validator: (value)=>value.isEmpty ? "Es requerido":null,   
       );
 }
  Widget registroButton() => MaterialButton(
                             height    : 50,
                             minWidth  : double.maxFinite,
                             color     : Colors.purple,
                             child     : Text("Completar",
                                              style: TextStyle(color: Colors.white)
                                             ),
                             onPressed :(){
                              if(_formKey.currentState.validate()){
                                 context.bloc<LoginBloc>().add(FinishRegistroGoogleEvent(usuario:usuario));
                              }
                             },
  );

 

  Widget logo() =>   Container(
                     alignment: Alignment.center,
                     height: 180,
                     child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                    Image(
                                      height : 90,
                                      width  : 90,
                                      image  : AssetImage('assets/logo.jpg'), 
                                    ),
                                    SizedBox(height: 10),
                                    Text("Panchita Clientes",
                                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),  
                                    ),
                                    SizedBox(height: 5),
                                    Text("Completa tu registro")
                            ],
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