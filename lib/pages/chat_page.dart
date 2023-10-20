import 'package:chat_app/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'group_info.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const ChatPage({required this.userName,required this.groupName,required this.groupId,super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Stream<QuerySnapshot>? chats;
  String admin = "";

  @override
  void initState() {
    getChatandAdmin();
    // TODO: implement initState
    super.initState();
  }

  getChatandAdmin(){
    DatabaseService().getChat(widget.groupId).then((val){
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((value){
      setState(() {
        admin = value;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context,  GroupInfo(
                  groupId: widget.groupId,
                  groupName: widget.groupName,
                  adminName: admin,
                ));
              },
              icon: const Icon(Icons.info))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title:  Text(
          widget.groupName,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),

      body: Center(child: Text(admin),),);
  }
}
