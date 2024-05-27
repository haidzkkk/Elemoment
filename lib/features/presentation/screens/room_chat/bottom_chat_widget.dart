
import 'package:elemoment/features/data/models/response/message.dart';
import 'package:elemoment/features/presentation/blocs/room/room_event.dart';
import 'package:elemoment/features/presentation/components/widget/text_field_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/room/room_bloc.dart';

class BottomChatWidget extends StatefulWidget {
  const BottomChatWidget({super.key, required this.userId, required this.roomId});

  final String userId;
  final String? roomId;

  @override
  State<BottomChatWidget> createState() => _BottomChatWidgetState();
}

class _BottomChatWidgetState extends State<BottomChatWidget> {

  late RoomBloc roomBloc;
  TextEditingController messageTextCtrl = TextEditingController();
  bool isSend = false;

  @override
  void initState() {
    super.initState();
    roomBloc = context.read<RoomBloc>();
    messageTextCtrl.addListener(() {
      isSend = messageTextCtrl.text.isNotEmpty;
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.all(5),
            padding: const EdgeInsetsDirectional.all(5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: const BorderRadiusDirectional.all(Radius.circular(100))
            ),
            child: const Icon(Icons.add, size: 20,),
          ),
          Expanded(
              child: TextFieldCustom(
                borderColor: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 30,
                hint: "Message...",
                controller: messageTextCtrl,
                onEditingComplete: (s){
                  if(s == null || s.isEmpty) return;
                  sendTextMessage(messageTextCtrl.text);
                },
                icon: const Icon(Icons.emoji_emotions_rounded, size: 20,),
              )
          ),
          isSend
              ? Container(
                  margin: const EdgeInsetsDirectional.all(5),
                  padding: const EdgeInsetsDirectional.all(5),
                  decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(100))
                  ),
                  child: GestureDetector(
                      onTap: (){
                        sendTextMessage(messageTextCtrl.text);
                      },
                      child: const Icon(Icons.send, size: 20, color: Colors.teal,)
                  ),
                )
              : Container(
                margin: const EdgeInsetsDirectional.all(5),
                padding: const EdgeInsetsDirectional.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(100))
                ),
                child: const Icon(Icons.mic, size: 20,),
              ),
        ],
      ),
    );
  }

  sendTextMessage(String msg){
    Message messageSend = Message(
      userId: widget.userId,
      roomId: widget.roomId,
      originServerTs: DateTime.now().millisecondsSinceEpoch,
      statusLocal: MessageStatusLocal.sending,
      type: MessageType.message,
      sender: widget.userId,
      content: Content(
        body: msg,
        msgtype: MessageContentMessageType.text
      )
    );
    roomBloc.add(SendTextMessage(data: messageSend));
    messageTextCtrl.text = "";
  }
}
