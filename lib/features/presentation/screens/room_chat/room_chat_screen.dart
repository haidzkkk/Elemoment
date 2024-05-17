
import 'package:elemoment/features/presentation/blocs/home/home_bloc.dart';
import 'package:elemoment/features/presentation/blocs/room/room_bloc.dart';
import 'package:elemoment/features/presentation/blocs/room/room_event.dart';
import 'package:elemoment/features/presentation/blocs/room/room_state.dart';
import 'package:elemoment/features/presentation/components/utility/snackbar.dart';
import 'package:elemoment/features/presentation/screens/room_chat/widget/list_chat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RoomChatScreen extends StatefulWidget {
  const RoomChatScreen({super.key, required this.roomId});

  final String roomId;

  @override
  State<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends State<RoomChatScreen> {
  late RoomBloc roomBloc;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      roomBloc = context.read<RoomBloc>();

      var currentRoom = context.read<HomeBloc>().state.rooms[widget.roomId];
      if(currentRoom == null){
        showCustomSnackBar("Không tìm thấy phòng");
        Get.back();
      }
      roomBloc.add(GetMessageRoomEvent(
          roomId: widget.roomId,
          currentRoom: currentRoom!));
    });
  }

  @override
  void dispose() {
    super.dispose();
    roomBloc.add(ClearRoomEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: BlocBuilder<RoomBloc, RoomState>(
        builder: (BuildContext context, RoomState state) {
          return Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(Radius.circular(100))
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(child: Text(state.currentRoom?.getDisplayName() ?? "...",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
                ),
              )),
            ],
          );
        }),
        actions: [
          GestureDetector(
            onTap: (){},
            child: const Padding(
                padding: EdgeInsetsDirectional.all(5),
                child: Icon(Icons.video_chat, size: 20, color: Colors.teal,)
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: const Padding(
                padding: EdgeInsetsDirectional.all(5),
                child: Icon(Icons.call, size: 20, color: Colors.teal,)
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: const Padding(
                padding: EdgeInsetsDirectional.all(5),
                child: Icon(Icons.chat_bubble, size: 20, color: Colors.teal,)
            ),
          ),
          GestureDetector(
            onTap: (){},
            child: const Padding(
                padding: EdgeInsetsDirectional.all(5),
                child: Icon(Icons.more_vert, size: 20, color: Colors.grey,)
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListChatWidget(),
          bottomChat()
        ],
      ),
    );
  }

  Widget bottomChat(){
    return Container();
  }
}
