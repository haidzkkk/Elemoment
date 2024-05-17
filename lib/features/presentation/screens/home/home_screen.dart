import 'package:elemoment/features/data/models/response/room.dart';
import 'package:elemoment/features/presentation/blocs/home/home_bloc.dart';
import 'package:elemoment/features/presentation/blocs/home/home_event.dart';
import 'package:elemoment/features/presentation/blocs/home/home_state.dart';
import 'package:elemoment/features/presentation/screens/home/widget/item_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String route = "/home_route";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isTyping = true;
  bool isSpeech = false;
  TextEditingController textChatCtrl = TextEditingController();
  ScrollController chatScrollController = ScrollController();
  FocusNode textChatFocusNode = FocusNode();

  @override
  void initState() {
    context.read<HomeBloc>().add(GetRoomHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag:  'unique_tag_1',
              onPressed: (){},
              mini: true,
              backgroundColor: Colors.white,
              child: const Icon(Icons.dashboard_outlined, color: Colors.greenAccent,),
            ),
            const SizedBox(height: 15,),
            FloatingActionButton(
              heroTag:  'unique_tag_2',
              onPressed: (){},
              backgroundColor: Colors.greenAccent,
              child: const Icon(Icons.note_alt_outlined, color: Colors.white),
            ),
          ],
        ),
        body: NestedScrollView(
          scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                      collapsedHeight: 60,
                      expandedHeight: 120,
                      leading: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                        ),
                        margin: const EdgeInsetsDirectional.all(15),
                      ),
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.black,
                      pinned: true,
                      floating: true,
                      snap: true,
                      flexibleSpace: const FlexibleSpaceBar(
                        title: Text("All chats",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                          background:SizedBox()
                      ),

                    actions: [
                      GestureDetector(
                        onTap: (){},
                        child: const Padding(
                            padding: EdgeInsetsDirectional.all(5),
                            child: Icon(Icons.search, size: 30,)
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: const Padding(
                            padding: EdgeInsetsDirectional.all(5),
                            child: Icon(Icons.more_vert, size: 30)
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: BlocBuilder<HomeBloc, HomeSate>(
            builder: (context, state) {
              List<String> myRoomIds = state.rooms.keys.toList();

              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                    itemCount: myRoomIds.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      String roomId = myRoomIds[index];
                      Room currentRoom = state.rooms[myRoomIds[index]]!;

                      return ItemRoom(
                        roomId: roomId,
                        data: currentRoom,
                      );
                    }
                ),
              );
            }
          ),
        )
    );
  }

}
