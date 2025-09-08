class ChatsModel {
  int? userId;
  List<Contacts>? contacts;

  ChatsModel({this.userId, this.contacts});

  ChatsModel.fromJson(json) {
    userId = json['user_id'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  int? contactId;
  int? unreadCount;
  int? isOnline;
  Contact? contact;

  Contacts({this.contactId, this.unreadCount, this.isOnline, this.contact});

  Contacts.fromJson(json) {
    contactId = json['contact_id'];
    unreadCount = json['unread_count'];
    isOnline = json['is_online'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_id'] = this.contactId;
    data['unread_count'] = this.unreadCount;
    data['is_online'] = this.isOnline;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    return data;
  }
}

class Contact {
  int? id;
  String? name;
  String? email;

  Contact({this.id, this.name, this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
