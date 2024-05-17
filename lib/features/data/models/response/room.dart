class Room {
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

  String getDisplayName(){
    String? name;

    if(timeline!.events != null){
      for(var element in timeline!.events!){
        name = element.content?.name;
        if(name != null)break;
      }
      if(name == null){
        if(state!.events != null){
          for(var element in state!.events!){
            name = element.content?.name;
            if(name != null)break;
          }
          if(name == null){
            if(name == null){
              if(state!.events != null){
                for(var element in state!.events!){
                  name = element.content?.displayname;
                  if(name != null)break;
                }
              }
            }
          }
        }
      }
    }
    return name ?? "Not found";
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
}

class Timeline {
  List<Events>? events;
  String? prevBatch;
  bool? limited;

  Timeline({this.events, this.prevBatch, this.limited});

  Timeline.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(Events.fromJson(v));
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
}

class Events {
  Content? content;
  int? originServerTs;
  String? sender;
  String? stateKey;
  String? type;
  Unsigned? unsigned;
  String? eventId;

  Events(
      {this.content,
        this.originServerTs,
        this.sender,
        this.stateKey,
        this.type,
        this.unsigned,
        this.eventId});

  Events.fromJson(Map<String, dynamic> json) {
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
    originServerTs = json['origin_server_ts'];
    sender = json['sender'];
    stateKey = json['state_key'];
    type = json['type'];
    unsigned = json['unsigned'] != null
        ? Unsigned.fromJson(json['unsigned'])
        : null;
    eventId = json['event_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['origin_server_ts'] = originServerTs;
    data['sender'] = sender;
    data['state_key'] = stateKey;
    data['type'] = type;
    if (unsigned != null) {
      data['unsigned'] = unsigned!.toJson();
    }
    data['event_id'] = eventId;
    return data;
  }
}

class Content {
  String? creator;
  String? roomVersion;
  String? displayname;
  String? membership;
  int? ban;
  EventsContent? events;
  int? eventsDefault;
  int? historical;
  int? invite;
  int? kick;
  int? redact;
  int? stateDefault;
  Users? users;
  int? usersDefault;
  String? joinRule;
  String? historyVisibility;
  String? guestAccess;
  String? algorithm;
  String? name;

  Content(
      {this.creator,
        this.roomVersion,
        this.displayname,
        this.membership,
        this.ban,
        this.events,
        this.eventsDefault,
        this.historical,
        this.invite,
        this.kick,
        this.redact,
        this.stateDefault,
        this.users,
        this.usersDefault,
        this.joinRule,
        this.historyVisibility,
        this.guestAccess,
        this.algorithm,
        this.name});

  Content.fromJson(Map<String, dynamic> json) {
    creator = json['creator'];
    roomVersion = json['room_version'];
    displayname = json['displayname'];
    membership = json['membership'];
    ban = json['ban'];
    events =
    json['events'] != null ? EventsContent.fromJson(json['events']) : null;
    eventsDefault = json['events_default'];
    historical = json['historical'];
    invite = json['invite'];
    kick = json['kick'];
    redact = json['redact'];
    stateDefault = json['state_default'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    usersDefault = json['users_default'];
    joinRule = json['join_rule'];
    historyVisibility = json['history_visibility'];
    guestAccess = json['guest_access'];
    algorithm = json['algorithm'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creator'] = creator;
    data['room_version'] = roomVersion;
    data['displayname'] = displayname;
    data['membership'] = membership;
    data['ban'] = ban;
    if (events != null) {
      data['events'] = events!.toJson();
    }
    data['events_default'] = eventsDefault;
    data['historical'] = historical;
    data['invite'] = invite;
    data['kick'] = kick;
    data['redact'] = redact;
    data['state_default'] = stateDefault;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    data['users_default'] = usersDefault;
    data['join_rule'] = joinRule;
    data['history_visibility'] = historyVisibility;
    data['guest_access'] = guestAccess;
    data['algorithm'] = algorithm;
    data['name'] = name;
    return data;
  }
}

class EventsContent {
  int? mRoomAvatar;
  int? mRoomCanonicalAlias;
  int? mRoomEncryption;
  int? mRoomHistoryVisibility;
  int? mRoomName;
  int? mRoomPowerLevels;
  int? mRoomServerAcl;
  int? mRoomTombstone;

  EventsContent(
      {this.mRoomAvatar,
        this.mRoomCanonicalAlias,
        this.mRoomEncryption,
        this.mRoomHistoryVisibility,
        this.mRoomName,
        this.mRoomPowerLevels,
        this.mRoomServerAcl,
        this.mRoomTombstone});

  EventsContent.fromJson(Map<String, dynamic> json) {
    mRoomAvatar = json['m.room.avatar'];
    mRoomCanonicalAlias = json['m.room.canonical_alias'];
    mRoomEncryption = json['m.room.encryption'];
    mRoomHistoryVisibility = json['m.room.history_visibility'];
    mRoomName = json['m.room.name'];
    mRoomPowerLevels = json['m.room.power_levels'];
    mRoomServerAcl = json['m.room.server_acl'];
    mRoomTombstone = json['m.room.tombstone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['m.room.avatar'] = mRoomAvatar;
    data['m.room.canonical_alias'] = mRoomCanonicalAlias;
    data['m.room.encryption'] = mRoomEncryption;
    data['m.room.history_visibility'] = mRoomHistoryVisibility;
    data['m.room.name'] = mRoomName;
    data['m.room.power_levels'] = mRoomPowerLevels;
    data['m.room.server_acl'] = mRoomServerAcl;
    data['m.room.tombstone'] = mRoomTombstone;
    return data;
  }
}

class Users {
  int? bekoi10a6MatrixOrg;

  Users({this.bekoi10a6MatrixOrg});

  Users.fromJson(Map<String, dynamic> json) {
    bekoi10a6MatrixOrg = json['@bekoi10a6:matrix.org'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['@bekoi10a6:matrix.org'] = bekoi10a6MatrixOrg;
    return data;
  }
}

class Unsigned {
  int? age;
  String? replacesState;
  PrevContent? prevContent;
  String? prevSender;

  Unsigned({this.age, this.replacesState, this.prevContent, this.prevSender});

  Unsigned.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    replacesState = json['replaces_state'];
    prevContent = json['prev_content'] != null
        ? PrevContent.fromJson(json['prev_content'])
        : null;
    prevSender = json['prev_sender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['replaces_state'] = replacesState;
    if (prevContent != null) {
      data['prev_content'] = prevContent!.toJson();
    }
    data['prev_sender'] = prevSender;
    return data;
  }
}

class PrevContent {
  String? displayname;
  String? membership;

  PrevContent({this.displayname, this.membership});

  PrevContent.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    membership = json['membership'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayname'] = displayname;
    data['membership'] = membership;
    return data;
  }
}

class StateRoom {
  List<EventsAccountData>? events;

  StateRoom({this.events});

  StateRoom.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events!.add(EventsAccountData.fromJson(v));
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
  List<EventsAccountData>? events;

  AccountData({this.events});

  AccountData.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <EventsAccountData>[];
      json['events'].forEach((v) {
        events!.add(EventsAccountData.fromJson(v));
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

class EventsAccountData {
  String? type;
  Content? content;

  EventsAccountData({this.type, this.content});

  EventsAccountData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content =
    json['content'] != null ? Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (content != null) {
      data['content'] = content!.toJson();
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
