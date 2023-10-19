import 'package:chat_app/pages/search_page.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            nextScreen(context, const SearchPage());
          }, icon: Icon(Icons.search))

        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Groups",
          style: TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 27
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 40),
          children: [],
        ),
      ),
      body: Center(child: Text("Home Page"),),
    );
  }
}
