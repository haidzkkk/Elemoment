
import 'dart:math';

import 'package:elemoment/features/presentation/blocs/auth/auth_bloc.dart';
import 'package:elemoment/features/presentation/components/utility/date_converter.dart';
import 'package:elemoment/features/presentation/screens/room_chat/widget/item_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/room/room_bloc.dart';
import '../../../blocs/room/room_state.dart';

class ListChatWidget extends StatefulWidget {
  const ListChatWidget({super.key});

  @override
  State<ListChatWidget> createState() => _ListChatWidgetState();
}

class _ListChatWidgetState extends State<ListChatWidget> {

  String userId = "";
  ScrollController chatScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    userId = context.read<AuthBloc>().state.userId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (BuildContext context, RoomState state) {
      },
      builder: (BuildContext context, RoomState state) {

        return Expanded(
          child: ListView.builder(
            reverse: true,
            controller: chatScrollController,
            itemCount: state.currentMessage.length,
            itemBuilder: (context, index){
              return ItemChat(
                  data: state.currentMessage[index],
                  typeMe: userId == state.currentMessage[index].sender,
                  showTimer: index + 1 >= state.currentMessage.length ? true : compareDate(firstDate: DateConverter.millisecondsSinceEpochToDateTime(state.currentMessage[index].originServerTs), secondDate: DateConverter.millisecondsSinceEpochToDateTime(state.currentMessage[index + 1].originServerTs), betweenHour:  2),
                  showInfo: index + 1 >= state.currentMessage.length  || state.currentMessage[index].sender != state.currentMessage[index + 1].sender
                      ? true
                      : compareDate(firstDate: DateConverter.millisecondsSinceEpochToDateTime(state.currentMessage[index].originServerTs), secondDate: DateConverter.millisecondsSinceEpochToDateTime(state.currentMessage[index + 1].originServerTs), betweenHour:  1),
              );
            },
          ),
        );
      },
    );
  }

  bool compareDate({required DateTime? firstDate, required DateTime? secondDate, required double betweenHour}){
    if( firstDate == null || secondDate == null ) return false;
    return firstDate.hour - secondDate.hour >= betweenHour;
  }
}
