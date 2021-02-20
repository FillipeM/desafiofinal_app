import 'package:desafiofinal_app/Screens/cart_page.dart';
import 'package:desafiofinal_app/Screens/index.dart';
import 'package:desafiofinal_app/Screens/login.dart';
import 'package:desafiofinal_app/model/usuario.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  Usuario _user = Usuario();
  CustomDrawer(Usuario this._user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "Home",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Index(user: _user),
                  ));
            },
          ),
          ListTile(
            title: Text("Carrinho", style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(user: _user),
                  ));
            },
          ),
          ListTile(
            title: Text(
              "Sair",
              style: TextStyle(fontSize: 18),
            ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
            },
          )
        ],
      ),
    );
  }
}
