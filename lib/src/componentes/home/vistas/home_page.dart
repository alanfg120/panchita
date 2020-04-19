import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
           backgroundColor: Colors.purple[100],
           body      : Center(child: Text("Home")),
        bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          backgroundColor: Colors.purple[100],
          buttonBackgroundColor: Colors.white,
          height: 55,
          items: <Widget>[
         
        
            Icon(Icons.add_shopping_cart, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.settings, size: 30),
    
          ],
          onTap: (index) {
            print(index);
          },
        ),
        //floatingActionButton: FloatingActionButton(onPressed: (){},backgroundColor: Colors.white,child: Icon(Icons.shopping_cart,color: Colors.black,)),
       
        );
  }
}
