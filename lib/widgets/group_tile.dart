import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../pages/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile({required this.userName,required this.groupName,required this.groupId,super.key});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage(
          groupId: widget.groupId,
          groupName: widget.groupName,
          userName: widget.userName,
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(

          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0,1).toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
            ),
          ),
          title: Text(widget.groupName,
          style: TextStyle(fontWeight: FontWeight.w500),),
          subtitle: Text(
            "Join the conversation as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
