class BlogsParentResponseModel {
  List<Blogs>? data;

  BlogsParentResponseModel({this.data});

  BlogsParentResponseModel.fromJson(json) {
    if (json['data'] != null) {
      data = <Blogs>[];
      json['data'].forEach((v) {
        data!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int? id;
  Title? title;
  Title? description;
  Title? content;
  String? image;
  String? file;
  int? readingTime;
  String? createdAt;
  String? publishedAt;

  Blogs(
      {this.id,
      this.title,
      this.description,
      this.content,
      this.image,
      this.file,
      this.readingTime,
      this.createdAt,
      this.publishedAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] != null
        ? json['title'] is String
            ? json['title']
            : new Title.fromJson(json['title'])
        : null;
    description = json['description'] != null
        ? json['description'] is String
            ? json['description']
            : new Title.fromJson(json['description'])
        : null;
    content = json['content'] != null
        ? json['content'] is String
            ? json['content']
            : new Title.fromJson(json['content'])
        : null;
    image = json['image'];
    file = json['file'];
    readingTime = json['reading_time'];
    createdAt = json['created_at'];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['image'] = this.image;
    data['file'] = this.file;
    data['reading_time'] = this.readingTime;
    data['created_at'] = this.createdAt;
    data['published_at'] = this.publishedAt;
    return data;
  }
}

class Title {
  String? en;
  String? ar;

  Title({this.en, this.ar});

  Title.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}
