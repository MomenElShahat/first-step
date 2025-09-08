class PortfolioResponseModel {
  String? message;
  Portofilo? data;

  PortfolioResponseModel({this.message, this.data});

  PortfolioResponseModel.fromJson(json) {
    message = json['message'];
    data = json['data'] != null ? new Portofilo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Portofilo {
  int? id;
  HeroSection? heroSection;
  List<Branches>? branches;
  PhilosophyMethodologyGoal? philosophyMethodologyGoal;
  String? serviceSectionTitle;
  List<Services>? services;
  NurseryState? nurseryState;
  String? activitySectionTitle;
  String? activitySectionSubtitle;
  List<String>? imagesActivities;
  List<String>? adsImages;
  List<Teams>? teams;
  ContactInfo? contactInfo;
  int? centerId;
  String? createdAt;
  String? updatedAt;

  Portofilo(
      {this.id,
      this.heroSection,
      this.branches,
      this.philosophyMethodologyGoal,
      this.serviceSectionTitle,
      this.services,
      this.nurseryState,
      this.activitySectionTitle,
      this.activitySectionSubtitle,
      this.imagesActivities,
      this.adsImages,
      this.teams,
      this.contactInfo,
      this.centerId,
      this.createdAt,
      this.updatedAt});

  Portofilo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heroSection = json['hero_section'] != null ? new HeroSection.fromJson(json['hero_section']) : null;
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
    philosophyMethodologyGoal =
        json['Philosophy_Methodology_Goal'] != null ? new PhilosophyMethodologyGoal.fromJson(json['Philosophy_Methodology_Goal']) : null;
    serviceSectionTitle = json['service_section_title'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    nurseryState = json['nursery_state'] != null ? new NurseryState.fromJson(json['nursery_state']) : null;
    activitySectionTitle = json['activity_section_title'];
    activitySectionSubtitle = json['activity_section_subtitle'];
    imagesActivities = json['images_activities'].cast<String>();
    adsImages = json['ads_images'].cast<String>();
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
    contactInfo = json['contact_info'] != null ? new ContactInfo.fromJson(json['contact_info']) : null;
    centerId = json['center_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.heroSection != null) {
      data['hero_section'] = this.heroSection!.toJson();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    if (this.philosophyMethodologyGoal != null) {
      data['Philosophy_Methodology_Goal'] = this.philosophyMethodologyGoal!.toJson();
    }
    data['service_section_title'] = this.serviceSectionTitle;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.nurseryState != null) {
      data['nursery_state'] = this.nurseryState!.toJson();
    }
    data['activity_section_title'] = this.activitySectionTitle;
    data['activity_section_subtitle'] = this.activitySectionSubtitle;
    data['images_activities'] = this.imagesActivities;
    data['ads_images'] = this.adsImages;
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    if (this.contactInfo != null) {
      data['contact_info'] = this.contactInfo!.toJson();
    }
    data['center_id'] = this.centerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class HeroSection {
  String? titleOfHero;
  String? subtitleOfHero;
  String? description;
  String? backgroundImage;

  HeroSection({this.titleOfHero, this.subtitleOfHero, this.description, this.backgroundImage});

  HeroSection.fromJson(Map<String, dynamic> json) {
    titleOfHero = json['title_of_hero'];
    subtitleOfHero = json['subtitle_of_hero'];
    description = json['description'];
    backgroundImage = json['background_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title_of_hero'] = this.titleOfHero;
    data['subtitle_of_hero'] = this.subtitleOfHero;
    data['description'] = this.description;
    data['background_image'] = this.backgroundImage;
    return data;
  }
}

class Branches {
  String? branchName;

  Branches({this.branchName});

  Branches.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    return data;
  }
}

class PhilosophyMethodologyGoal {
  Philosophy? philosophy;
  Philosophy? methodology;
  Philosophy? goals;

  PhilosophyMethodologyGoal({this.philosophy, this.methodology, this.goals});

  PhilosophyMethodologyGoal.fromJson(Map<String, dynamic> json) {
    philosophy = json['philosophy'] != null ? new Philosophy.fromJson(json['philosophy']) : null;
    methodology = json['methodology'] != null ? new Philosophy.fromJson(json['methodology']) : null;
    goals = json['goals'] != null ? new Philosophy.fromJson(json['goals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.philosophy != null) {
      data['philosophy'] = this.philosophy!.toJson();
    }
    if (this.methodology != null) {
      data['methodology'] = this.methodology!.toJson();
    }
    if (this.goals != null) {
      data['goals'] = this.goals!.toJson();
    }
    return data;
  }
}

class Philosophy {
  String? title;
  String? content;

  Philosophy({this.title, this.content});

  Philosophy.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class Services {
  String? title;
  String? description;
  String? imageService;

  Services({this.title, this.description, this.imageService});

  Services.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageService = json['image_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_service'] = this.imageService;
    return data;
  }
}

class NurseryState {
  String? area;
  String? classRooms;
  String? teamMembers;

  NurseryState({this.area, this.classRooms, this.teamMembers});

  NurseryState.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    classRooms = json['class_rooms'];
    teamMembers = json['team_members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['class_rooms'] = this.classRooms;
    data['team_members'] = this.teamMembers;
    return data;
  }
}

class Teams {
  String? name;
  String? mission;
  String? image;

  Teams({this.name, this.mission, this.image});

  Teams.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mission = json['mission'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mission'] = this.mission;
    data['image'] = this.image;
    return data;
  }
}

class ContactInfo {
  String? address;
  String? workingHours;
  String? phoneNumber;
  String? emailAddress;
  String? facebook;
  String? instagram;
  String? whatsapp;

  ContactInfo({this.address, this.workingHours, this.phoneNumber, this.emailAddress, this.facebook, this.instagram, this.whatsapp});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    workingHours = json['working_hours'];
    phoneNumber = json['phone_number'];
    emailAddress = json['email_address'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['working_hours'] = this.workingHours;
    data['phone_number'] = this.phoneNumber;
    data['email_address'] = this.emailAddress;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}
