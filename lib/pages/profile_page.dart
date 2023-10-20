import 'package:flutter/material.dart';

import '../helper/helper_function.dart';
import '../service/auth_service.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String email = "";
  AuthService authService= AuthService();

  @override
  void initState() {
    gettingUserData();
    super.initState();
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUsernameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white,fontWeight: FontWeight.bold,fontSize: 27
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            Icon(Icons.account_circle,size: 150,color: Colors.grey[700],),
            const SizedBox(height: 15,),
            Text(userName,textAlign: TextAlign.center,style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: (){
                nextScreenReplace(context, const HomePage());
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            ListTile(
              onTap: (){
               // nextScreenReplace(context, const ProfilePage());
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.person),
              title: const Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () async{
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);

                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.red,
                              ))
                        ],
                      );
                    });

              },
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.account_circle,
          size: 200,
          color: Colors.grey[700],),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Full Name",style: TextStyle(fontSize: 17),),
              Text(userName,style: TextStyle(fontSize: 17),),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[700],
            height: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Email",style: TextStyle(fontSize: 17),),
              Text(email,style: TextStyle(fontSize: 17),),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      ),

    );
  }
}
