import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';
import 'home_page.dart';


class RootPage extends StatefulWidget {

  RootPage(this.auth);

  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus{
  notSignedIn, 
  signedIn
}


class _RootPageState extends State<RootPage> {
  

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();

    // método sempre chamado antes de qualquer widget
    // será muito importante para checar se o usuário está logado antes
    // current state

    widget.auth.currentUser().then((userId) {

     setState(() {
      
       _authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;

     });


  });

  }
   


  void _signedIn(){
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
     _authStatus = AuthStatus.notSignedIn; 
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    
    switch (_authStatus) {
      case AuthStatus.notSignedIn :
    return new LoginPage(
      
       auth: widget.auth,
       onSignedIn: _signedIn,
    
       ) ;
    // se não estiver logado, redireciona para a pagina de login

    case AuthStatus.signedIn :

    return new HomePage(

      auth: widget.auth,
      onSignedOut: _signedOut,


    );
    }
    

    
  }
}