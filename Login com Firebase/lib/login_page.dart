import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth; // adicionando a variável do firebaseauth na classe auth

  final VoidCallback onSignedIn;



  @override
  State<StatefulWidget> createState() => new _LoginPageState();
  
}



enum FormType {
  // saber se o usuario vai fazer login ou registrar uma conta

  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();


  String _email, _senha;

  FormType _formType = FormType.login;



  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
     form.save();
      return true;

    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {

        if(_formType == FormType.login){

        String userId = await widget.auth.signInWithEmailAndPassword(_email, _senha);


        /*FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _senha))
            .user;
            */

        print('Logado: $userId');



        } else { // se o usuario criar uma conta


      /*  FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(email: _email, password: _senha))
            .user;

            */

        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _senha);


        print('Usuário criado: $userId');

        



        }

        widget.onSignedIn();



      } catch (e) {
        print('Error: $e');
      }
    }
  }



  void moveToRegister() {

    formKey.currentState.reset();



    setState(() {
      // quando o usuario clicar no register

      _formType = FormType.register;
    });
  }

  void moveToLogin(){

    formKey.currentState.reset();
    setState(() {

      // quando o usuario clicar no login

     _formType = FormType.login; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      

      appBar: new AppBar(
        title: new Text('Flutter login demo'),
      ),
      
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(

          key:
              formKey, // essa key é utilizada para poder usar o validateandsave method
          child: SingleChildScrollView(
          child: new Column(
            
              // column: email e senha um depois do outro verticalmente
              

              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildInputs() + buildSubmitButtons()),
        ),
      ),
    ),
    );
  }

  List<Widget> buildInputs() {
    // formularios

    return [
      new TextFormField(
        validator: (value) => value.isEmpty
            ? 'Por favor, preencha um e-mail'
            : null, // ' : null' é quase como um else
           
        onSaved: (value) => _email = value,

        decoration: new InputDecoration(
          labelText: 'E-mail',
        ),
      ),
      new TextFormField(
        obscureText: true,
        validator: (String arg){

          if(arg.length < 6) {
            return "Sua senha precisa ter 6 ou mais caracteres";
          }
           if(arg.isEmpty){
            return "Por favor, digite uma senha";
          }
        },



        onSaved: (value) => _senha = value,
        decoration: new InputDecoration(labelText: 'Senha'),
      ),
    ];
  }

  List<Widget> buildSubmitButtons()  {// botões
  
    
    if(_formType == FormType.login){
  
    return [
      new RaisedButton(
        child: new Text(
          'Login',
          style: new TextStyle(fontSize: 20.0),
        ),
        onPressed: validateAndSubmit,


      
      ),
      new FlatButton(
        child: new Text(
          'Criar uma conta',
          style: new TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
        
        moveToRegister();

        },
      )
    ];
    } else {

      return [
      new RaisedButton(
        child: new Text(
          'Criar conta',
          style: new TextStyle(fontSize: 20.0),
        ),
        onPressed: validateAndSubmit,
      ),
      new FlatButton(
        child: new Text(
          'Já possui uma conta? Faça seu login',
          style: new TextStyle(fontSize: 16.0),
        ),
        onPressed: 
        moveToLogin,
                  
      )
    ];


    }
  }
}
