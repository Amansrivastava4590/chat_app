import 'package:chat_app/helper/helper_function.dart';
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return _isLoading
    ?  Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
    : Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Group",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Create your account now to explore"),
                  Image.asset("assets/register.png"),

                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        fullName = val;
                      });
                    },
                    decoration: textInputDecoration.copyWith(
                        labelText: "Full Name",
                        hintText: "Full Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        )),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      } else {
                        return "Name can't be empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          hintText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          )),
                      validator: (val) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Password",
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        )),
                    validator: (val) {
                      if (val!.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        register();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              nextScreen(context, const LoginPage());
                            })
                      ]))
                ],
              ),
            ),
          ),
        ));

  }
  register()async{
  if(formKey.currentState!.validate()){
    setState(() {
      _isLoading = true;
    });
    await authService.registerUserWithEmailandPassword(fullName, email, password).then((value) async{
      if(value == true){
      await HelperFunction.saveUserLoggedInStatus(true);
      await HelperFunction.saveUsernameSF(fullName);
      await HelperFunction.saveUserEmailSF(email);
      nextScreenReplace(context,const HomePage());
      }else {
        showSnackBar(context, Colors.red, value);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  }
}
