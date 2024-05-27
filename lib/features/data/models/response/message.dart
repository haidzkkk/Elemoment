
import 'package:elemoment/features/common/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class MessageType{
  static const String member  = "m.room.member";
  static const String message  = "m.room.message";
  static const String selectAnswer  = "m.call.select_answer";
  static const String callAnswer  = "m.call.answer";
  static const String callHangup  = "m.call.hangup";
  static const String callCandidates  = "m.call.candidates";
  static const String callNegotiate  = "m.call.negotiate";
  static const String callInvite  = "m.call.invite";
  static const String modularWidgets  = "im.vector.modular.widgets";
  static const String encrypted  = "m.room.encrypted";
  static const String encryption  = "m.room.encryption";
  static const String name  = "m.room.name";
  static const String guestAccess  = "m.room.guest_access";
  static const String historyVisibility  = "m.room.history_visibility";
  static const String joinRules  = "m.room.join_rules";
  static const String powerLevels  = "m.room.power_levels";
  static const String create  = "m.room.create";
}

class MessageStatusLocal{
  static const String sending  = "sending";
  static const String sentFail  = "sent_fail";
}

class MessageContentMessageType{
  static const String text = "m.text";
  static const String video = "m.video";
  static const String image = "m.image";
}


class MessageContentMemberType{
  static const String invite = "invite";
  static const String join = "join";
}

class Message extends Equatable implements Comparable{
  Content? content;
  int? originServerTs;
  String? roomId;
  String? sender;
  String? stateKey;
  String? type;
  Unsigned? unsigned;
  String? eventId;
  String? userId;
  int? age;
  String? replacesState;
  PrevContent? prevContent;

  String? statusLocal;

  Message({this.content, this.originServerTs, this.roomId, this.statusLocal, this.sender, this.stateKey, this.type, this.unsigned, this.eventId, this.userId, this.age, this.replacesState, this.prevContent});


  Message.fromJson(Map<dynamic, dynamic> json) {
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
    originServerTs = json['origin_server_ts'];
    roomId = json['room_id'];
    sender = json['sender'];
    stateKey = json['state_key'];
    type = json['type'];
    unsigned = json['unsigned'] != null ? Unsigned.fromJson(json['unsigned']) : null;
    eventId = json['event_id'];
    userId = json['user_id'];
    age = json['age'];
    replacesState = json['replaces_state'];
    prevContent = json['prev_content'] != null ? PrevContent.fromJson(json['prev_content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['origin_server_ts'] = originServerTs;
    data['room_id'] = roomId;
    data['sender'] = sender;
    data['state_key'] = stateKey;
    data['type'] = type;
    if (unsigned != null) {
      data['unsigned'] = unsigned!.toJson();
    }
    data['event_id'] = eventId;
    data['user_id'] = userId;
    data['age'] = age;
    data['replaces_state'] = replacesState;
    if (prevContent != null) {
      data['prev_content'] = prevContent!.toJson();
    }
    return data;
  }

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    content,
    originServerTs,
    roomId,
    sender,
    stateKey,
    type,
    unsigned,
    eventId,
    userId,
    age,
    replacesState,
    prevContent,
  ];
  
}

class Content extends Equatable{
  String? displayname;
  String? membership;
  String? body;
  Info? info;
  String? msgtype;
  String? url;
  Mentions? mMentions;
  String? callId;
  String? partyId;
  String? reason;
  String? version;
  List<Candidates>? candidates;
  Description? description;
  int? lifetime;
  Description? answer;
  String? selectedPartyId;
  Description? offer;
  String? creatorUserId;
  Data? data;
  String? id;
  String? name;
  String? type;

  Content({this.displayname, this.membership, this.body, this.info, this.msgtype, this.url, this.mMentions, this.callId, this.partyId, this.reason, this.version, this.candidates, this.description, this.lifetime, this.answer, this.selectedPartyId, this.offer, this.creatorUserId, this.data, this.id, this.name, this.type});

  Content.fromJson(Map<dynamic, dynamic> json) {
    displayname = json['displayname'];
    membership = json['membership'];
    body = json['body'];
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    msgtype = json['msgtype'];
    url = json['url'];
    mMentions = json['m.mentions'] != null ? Mentions.fromJson(json['m.mentions']) : null;
    callId = json['call_id'];
    partyId = json['party_id'];
    reason = json['reason'];
    version = json['version'];
    if (json['candidates'] != null) {
      candidates = <Candidates>[];
      json['candidates'].forEach((v) { candidates!.add(Candidates.fromJson(v)); });
    }
    description = json['description'] != null ? Description.fromJson(json['description']) : null;
    lifetime = json['lifetime'];
    answer = json['answer'] != null ? Description.fromJson(json['answer']) : null;
    selectedPartyId = json['selected_party_id'];
    offer = json['offer'] != null ? Description.fromJson(json['offer']) : null;
    creatorUserId = json['creatorUserId'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayname'] = displayname;
    data['membership'] = membership;
    data['body'] = body;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    data['msgtype'] = msgtype;
    data['url'] = url;
    if (mMentions != null) {
      data['m.mentions'] = mMentions!.toJson();
    }
    data['call_id'] = callId;
    data['party_id'] = partyId;
    data['reason'] = reason;
    data['version'] = version;
    if (candidates != null) {
      data['candidates'] = candidates!.map((v) => v.toJson()).toList();
    }
    if (description != null) {
      data['description'] = description!.toJson();
    }
    data['lifetime'] = lifetime;
    if (answer != null) {
      data['answer'] = answer!.toJson();
    }
    data['selected_party_id'] = selectedPartyId;
    if (offer != null) {
      data['offer'] = offer!.toJson();
    }
    data['creatorUserId'] = creatorUserId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }

  @override
  List<Object?> get props => [
  displayname,
  membership,
  body,
  info,
  msgtype,
  url,
  mMentions,
  callId,
  partyId,
  reason,
  version,
  candidates,
  description,
  lifetime,
  answer,
  selectedPartyId,
  offer,
  creatorUserId,
  data,
  id,
  name,
  type,
  ];
}

class Info {
  int? duration;
  int? h;
  String? mimetype;
  int? size;
  ThumbnailInfo? thumbnailInfo;
  String? thumbnailUrl;
  int? w;

  Info(
      {this.duration,
        this.h,
        this.mimetype,
        this.size,
        this.thumbnailInfo,
        this.thumbnailUrl,
        this.w});

  Info.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    h = json['h'];
    mimetype = json['mimetype'];
    size = json['size'];
    thumbnailInfo = json['thumbnail_info'] != null
        ? new ThumbnailInfo.fromJson(json['thumbnail_info'])
        : null;
    thumbnailUrl = json['thumbnail_url'];
    w = json['w'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['duration'] = this.duration;
    data['h'] = this.h;
    data['mimetype'] = this.mimetype;
    data['size'] = this.size;
    if (this.thumbnailInfo != null) {
      data['thumbnail_info'] = this.thumbnailInfo!.toJson();
    }
    data['thumbnail_url'] = this.thumbnailUrl;
    data['w'] = this.w;
    return data;
  }
}

class ThumbnailInfo {
  int? h;
  String? mimetype;
  int? size;
  int? w;

  ThumbnailInfo({this.h, this.mimetype, this.size, this.w});

  ThumbnailInfo.fromJson(Map<String, dynamic> json) {
    h = json['h'];
    mimetype = json['mimetype'];
    size = json['size'];
    w = json['w'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['h'] = this.h;
    data['mimetype'] = this.mimetype;
    data['size'] = this.size;
    data['w'] = this.w;
    return data;
  }
}

class Mentions {

  Mentions();

  Mentions.fromJson(Map<dynamic, dynamic> json) {
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

class Candidates {
  String? candidate;
  int? sdpMLineIndex;
  String? sdpMid;

  Candidates({this.candidate, this.sdpMLineIndex, this.sdpMid});

  Candidates.fromJson(Map<String, dynamic> json) {
    candidate = json['candidate'];
    sdpMLineIndex = json['sdpMLineIndex'];
    sdpMid = json['sdpMid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['candidate'] = candidate;
    data['sdpMLineIndex'] = sdpMLineIndex;
    data['sdpMid'] = sdpMid;
    return data;
  }
}

class Description {
  String? sdp;
  String? type;

  Description({this.sdp, this.type});

  Description.fromJson(Map<String, dynamic> json) {
    sdp = json['sdp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sdp'] = sdp;
    data['type'] = type;
    return data;
  }
}

class Data {
  String? conferenceId;
  String? domain;
  bool? isAudioOnly;

  Data({this.conferenceId, this.domain, this.isAudioOnly});

  Data.fromJson(Map<String, dynamic> json) {
    conferenceId = json['conferenceId'];
    domain = json['domain'];
    isAudioOnly = json['isAudioOnly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conferenceId'] = conferenceId;
    data['domain'] = domain;
    data['isAudioOnly'] = isAudioOnly;
    return data;
  }
}

class Unsigned {
  String? replacesState;
  PrevContent? prevContent;
  String? prevSender;
  int? age;

  Unsigned({this.replacesState, this.prevContent, this.prevSender, this.age});

  Unsigned.fromJson(Map<dynamic, dynamic> json) {
    replacesState = json['replaces_state'];
    prevContent = json['prev_content'] != null ? PrevContent.fromJson(json['prev_content']) : null;
    prevSender = json['prev_sender'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['replaces_state'] = replacesState;
    if (prevContent != null) {
      data['prev_content'] = prevContent!.toJson();
    }
    data['prev_sender'] = prevSender;
    data['age'] = age;
    return data;
  }
}

class PrevContent extends Equatable{
  String? displayname;
  String? membership;
  String? creatorUserId;
  Data? data;
  String? id;
  String? name;
  String? type;
  String? url;

  PrevContent({this.displayname, this.membership, this.creatorUserId, this.data, this.id, this.name, this.type, this.url});

  PrevContent.fromJson(Map<dynamic, dynamic> json) {
    displayname = json['displayname'];
    membership = json['membership'];
    creatorUserId = json['creatorUserId'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    id = json['id'];
    name = json['name'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayname'] = displayname;
    data['membership'] = membership;
    data['creatorUserId'] = creatorUserId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['url'] = url;
    return data;
  }

  @override
  List<Object?> get props => [
  displayname,
  membership,
  creatorUserId,
  data,
  id,
  name,
  type,
  url,
  ];
}
