
import 'package:elemoment/features/presentation/screens/room_chat/room_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../data/models/response/room.dart';
import '../../../blocs/auth/auth_bloc.dart';

class ItemRoom extends StatefulWidget {
  const ItemRoom({super.key, required this.roomId, required this.data});

  final String roomId;
  final Room data;

  @override
  State<ItemRoom> createState() => _ItemRoomState();
}

class _ItemRoomState extends State<ItemRoom> {

  late String myUserId;

  @override
  void initState() {
    myUserId = context.read<AuthBloc>().state.userId;
    super.initState();
  }

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
          mainAxisSize: MainAxisSize.max,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.data.getDisplayName(myUserId) ?? "..", style: const TextStyle(fontSize: 16),),
                Text(widget.data.getMessage(myUserId)['content'] ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
            const Spacer(),
            Text(widget.data.getMessage(myUserId)['time'] ?? "", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
            const SizedBox(width: 10,),
          ],
         ),
      ),
    );
  }
}
