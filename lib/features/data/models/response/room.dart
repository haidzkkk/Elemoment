import 'package:elemoment/features/data/models/response/message.dart';
import 'package:elemoment/features/presentation/components/utility/ultilies.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../presentation/components/utility/date_converter.dart';

class Room extends Equatable{
  Timeline? timeline;
  StateRoom? state;
  AccountData? accountData;
  AccountData? ephemeral;
  UnreadNotifications? unreadNotifications;
  Summary? summary;

  Room(
      {this.timeline,
        this.state,
        this.accountData,
        this.ephemeral,
        this.unreadNotifications,
        this.summary});

  String getDisplayName(String userId){
    var myList = [...timeline?.events ?? [], ...state?.events ?? []];
    String? name = myList.firstWhereOrNull((element) => element?.type == "m.room.name")?.content?.name;
    name ??= myList.firstWhereOrNull((element) => element.type == "m.room.member" && element.sender != userId)?.content?.displayname;
    return name ?? "";
  }

  String? getAvatar(){
    var myList = [...timeline?.events ?? [], ...state?.events ?? []];
    String? url = myList.firstWhereOrNull((element) => element?.type == "m.room.avatar")?.content?.url;
    if(url != null){
      url = getUrlMedia(url);
    }
    return url;
  }

  Map<String, String> getMessage(String userId){
    var myList = [...timeline?.events ?? []].reversed.toList();
    Message? event = myList.firstWhereOrNull((element) => element.type == "m.room.message");

    String content = '';
    String time = '';

    if(event?.sender == userId){
      content = "bạn: ";
    }
    if(event?.content?.msgtype == MessageContentMessageType.text){
      content = content + (event?.content?.body ?? "");
    }else if(event?.content?.msgtype == MessageContentMessageType.image){
      content = content + "đã giử ảnh";
    }else if(event?.content?.msgtype == MessageContentMessageType.image){
      content = content + "đã giử video";
    }

    time = DateConverter.millisecondsSinceEpochHourString(event?.originServerTs);

    return {'content': content, 'time': time};
  }

  Room.fromJson(Map<String, dynamic> json) {
    timeline = json['timeline'] != null
        ? Timeline.fromJson(json['timeline'])
        : null;
    state = json['state'] != null ? StateRoom.fromJson(json['state']) : null;
    accountData = json['account_data'] != null
        ? AccountData.fromJson(json['account_data'])
        : null;
    ephemeral = json['ephemeral'] != null
        ? AccountData.fromJson(json['ephemeral'])
        : null;
    unreadNotifications = json['unread_notifications'] != null
        ? UnreadNotifications.fromJson(json['unread_notifications'])
        : null;
    summary =
    json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (timeline != null) {
      data['timeline'] = timeline!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (accountData != null) {
      data['account_data'] = accountData!.toJson();
    }
    if (ephemeral != null) {
      data['ephemeral'] = ephemeral!.toJson();
    }
    if (unreadNotifications != null) {
      data['unread_notifications'] = unreadNotifications!.toJson();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [timeline, state];
}

class Timeline extends Equatable{
  List<Message>? events;
  String? prevBatch;
  bool? limited;

  Timeline({this.events, this.prevBatch, this.limited});

  Timeline.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Message>[];
      json['events'].forEach((v) {
        events!.add(Message.fromJson(v));
      });
    }
    prevBatch = json['prev_batch'];
    limited = json['limited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    data['prev_batch'] = prevBatch;
    data['limited'] = limited;
    return data;
  }

  @override
  List<Object?> get props => [events, prevBatch, limited];
}

class StateRoom {
  List<Message>? events;

  StateRoom({this.events});

  StateRoom.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountData {
  List<Message>? events;

  AccountData({this.events});

  AccountData.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Message>[];
      json['events'].forEach((v) {
        events!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnreadNotifications {
  int? notificationCount;
  int? highlightCount;

  UnreadNotifications({this.notificationCount, this.highlightCount});

  UnreadNotifications.fromJson(Map<String, dynamic> json) {
    notificationCount = json['notification_count'];
    highlightCount = json['highlight_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notification_count'] = notificationCount;
    data['highlight_count'] = highlightCount;
    return data;
  }
}

class Summary {
  int? mJoinedMemberCount;
  int? mInvitedMemberCount;

  Summary({this.mJoinedMemberCount, this.mInvitedMemberCount});

  Summary.fromJson(Map<String, dynamic> json) {
    mJoinedMemberCount = json['m.joined_member_count'];
    mInvitedMemberCount = json['m.invited_member_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['m.joined_member_count'] = mJoinedMemberCount;
    data['m.invited_member_count'] = mInvitedMemberCount;
    return data;
  }
}
