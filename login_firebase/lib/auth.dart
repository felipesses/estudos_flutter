import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

// essa classe vai ser utilizada na classe root page,
// ela vai intermediar o acesso do usuário, enviando ele ou para a
// página de login ou para a página home, que o usuário só poderá
// acessar se tiver um login registrado

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String senha);
  Future<String> createUserWithEmailAndPassword(String email, String senha);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  // componente genérico de autorização

  Future<String> signInWithEmailAndPassword(String email, String senha) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: senha))
        .user;

    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String senha) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: senha))
        .user;

    return user.uid;
  }

  Future<String> currentUser() async {
    // esse método sempre retornará um usuário validado contanto que ele seja logado
    // serve para quando o usuário sair do aplicativo e retornar, por exemplo

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return user.uid;
  }

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }
}
