import 'package:chat_app/helper/helper_function.dart';
import 'package:chat_app/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// login
  Future logInUserWithEmailandPassword(
     String email,String password
      ) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      if(user != null){
        return true;

      }

    } on FirebaseException catch (e){
      return e.message;
    }
  }




/// register
  Future registerUserWithEmailandPassword(
      String fullName,String email,String password
      ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      if(user != null){
        ///call our database service to update the user data
        DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;

      }

    } on FirebaseException catch (e){
      return e.message;
    }
  }



/// signout
Future signOut() async {
    try{
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUsernameSF("");
      await firebaseAuth.signOut();
    }
    catch (e){
      return null;
    }
}
}