
import 'package:elemoment/features/presentation/screens/room_chat/room_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/response/room.dart';

class ItemRoom extends StatefulWidget {
  const ItemRoom({super.key, required this.roomId, required this.data});

  final String roomId;
  final Room data;

  @override
  State<ItemRoom> createState() => _ItemRoomState();
}

class _ItemRoomState extends State<ItemRoom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => RoomChatScreen(roomId: widget.roomId));
      },
      child: Container(
        color: Colors.white,
        height: 60,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              margin: const EdgeInsetsDirectional.all(10),
            ),
            Text(widget.data.getDisplayName() ?? "..")
          ],
        ),
      ),
    );
  }
}
