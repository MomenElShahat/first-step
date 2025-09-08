class ShowCenterDataModel {
  Data? data;

  ShowCenterDataModel({this.data});

  ShowCenterDataModel.fromJson(json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? nurseryName;
  String? location;
  String? name;
  int? cityId;
  String? neighborhood;
  String? phone;
  String? email;
  String? address;
  int? userId;
  String? licensePath;
  String? logo;
  String? commercialRecordPath;
  List<String>? nurseryType;
  List<String>? services;
  String? additionalService;
  List<String>? acceptedAges;
  List<FirstMeals>? firstMeals;
  List<FirstMeals>? secondMeals;
  String? workDaysFrom;
  String? workDaysTo;
  String? workHoursFrom;
  String? timeOfFirstPeriod;
  String? timeOfSecondPeriod;
  String? workHoursTo;
  int? emergencyContact;
  int? specialNeeds;
  List<String>? communicationMethods;
  int? providesFood;
  String? status;
  List<Ads>? ads;
  List<Branches>? branches;

  Data(
      {this.id,
        this.nurseryName,
        this.location,
        this.cityId,
        this.neighborhood,
        this.phone,
        this.email,
        this.address,
        this.userId,
        this.name,
        this.licensePath,
        this.logo,
        this.commercialRecordPath,
        this.nurseryType,
        this.services,
        this.additionalService,
        this.acceptedAges,
        this.firstMeals,
        this.secondMeals,
        this.workDaysFrom,
        this.workDaysTo,
        this.workHoursFrom,
        this.timeOfFirstPeriod,
        this.timeOfSecondPeriod,
        this.workHoursTo,
        this.emergencyContact,
        this.specialNeeds,
        this.communicationMethods,
        this.providesFood,
        this.status,
        this.ads,
        this.branches});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nurseryName = json['nursery_name'];
    location = json['location'];
    cityId = json['city_id'];
    neighborhood = json['neighborhood'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    userId = json['user_id'];
    licensePath = json['license_path'];
    logo = json['logo'];
    commercialRecordPath = json['commercial_record_path'];
    nurseryType = json['nursery_type'].cast<String>();
    services = json['services'].cast<String>();
    additionalService = json['additional_service'];
    acceptedAges = json['accepted_ages'].cast<String>();
    if (json['first_meals'] != null) {
      firstMeals = <FirstMeals>[];
      json['first_meals'].forEach((v) {
        firstMeals!.add(new FirstMeals.fromJson(v));
      });
    }
    if (json['second_meals'] != null) {
      secondMeals = <FirstMeals>[];
      json['second_meals'].forEach((v) {
        secondMeals!.add(new FirstMeals.fromJson(v));
      });
    }
    workDaysFrom = json['work_days_from'];
    workDaysTo = json['work_days_to'];
    workHoursFrom = json['work_hours_from'];
    timeOfFirstPeriod = json['time_of_first_period'];
    timeOfSecondPeriod = json['time_of_second_period'];
    workHoursTo = json['work_hours_to'];
    emergencyContact = json['emergency_contact'];
    specialNeeds = json['special_needs'];
    communicationMethods = json['communication_methods'].cast<String>();
    providesFood = json['provides_food'];
    status = json['status'];
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(new Ads.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      branches = <Branches>[];
      json['branches'].forEach((v) {
        branches!.add(new Branches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nursery_name'] = this.nurseryName;
    data['location'] = this.location;
    data['city_id'] = this.cityId;
    data['neighborhood'] = this.neighborhood;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['license_path'] = this.licensePath;
    data['logo'] = this.logo;
    data['commercial_record_path'] = this.commercialRecordPath;
    data['nursery_type'] = this.nurseryType;
    data['services'] = this.services;
    data['additional_service'] = this.additionalService;
    data['accepted_ages'] = this.acceptedAges;
    if (this.firstMeals != null) {
      data['first_meals'] = this.firstMeals!.map((v) => v.toJson()).toList();
    }
    if (this.secondMeals != null) {
      data['second_meals'] = this.secondMeals!.map((v) => v.toJson()).toList();
    }
    data['work_days_from'] = this.workDaysFrom;
    data['work_days_to'] = this.workDaysTo;
    data['work_hours_from'] = this.workHoursFrom;
    data['time_of_first_period'] = this.timeOfFirstPeriod;
    data['time_of_second_period'] = this.timeOfSecondPeriod;
    data['work_hours_to'] = this.workHoursTo;
    data['emergency_contact'] = this.emergencyContact;
    data['special_needs'] = this.specialNeeds;
    data['communication_methods'] = this.communicationMethods;
    data['provides_food'] = this.providesFood;
    data['status'] = this.status;
    if (this.ads != null) {
      data['ads'] = this.ads!.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirstMeals {
  String? mealName;
  String? juice;
  String? components;

  FirstMeals({this.mealName, this.juice, this.components});

  FirstMeals.fromJson(Map<String, dynamic> json) {
    mealName = json['meal_name'];
    juice = json['juice'];
    components = json['components'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_name'] = this.mealName;
    data['juice'] = this.juice;
    data['components'] = this.components;
    return data;
  }
}

class Ads {
  int? id;
  int? centerId;
  int? branchId;
  Title? title;
  Title? description;
  String? image;
  String? publishDate;
  String? endDate;
  String? status;

  Ads(
      {this.id,
        this.centerId,
        this.branchId,
        this.title,
        this.description,
        this.image,
        this.publishDate,
        this.endDate,
        this.status});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['center_id'];
    branchId = json['branch_id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? new Title.fromJson(json['description'])
        : null;
    image = json['image'];
    publishDate = json['publish_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['center_id'] = this.centerId;
    data['branch_id'] = this.branchId;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['image'] = this.image;
    data['publish_date'] = this.publishDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
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

class Branches {
  int? id;
  int? cityId;
  String? nurseryName;
  int? isMainBranch;
  List<Teams>? teams;
  List<Pricing>? pricing;
  City? city;

  Branches(
      {this.id,
        this.cityId,
        this.nurseryName,
        this.isMainBranch,
        this.teams,
        this.pricing,
        this.city});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    nurseryName = json['nursery_name'];
    isMainBranch = json['is_main_branch'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(new Pricing.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_id'] = this.cityId;
    data['nursery_name'] = this.nurseryName;
    data['is_main_branch'] = this.isMainBranch;
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Teams {
  int? id;
  String? image;
  String? name;
  String? profession;

  Teams({this.id, this.image, this.name, this.profession});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    profession = json['profession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['profession'] = this.profession;
    return data;
  }
}

class Pricing {
  int? branchId;
  String? enrollmentType;
  List<String>? services;
  String? priceAmount;

  Pricing(
      {this.branchId, this.enrollmentType, this.services, this.priceAmount});

  Pricing.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    enrollmentType = json['enrollment_type'];
    services = json['services']?.cast<String>();
    priceAmount = json['price_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['enrollment_type'] = this.enrollmentType;
    data['services'] = this.services;
    data['price_amount'] = this.priceAmount;
    return data;
  }
}

class City {
  int? id;
  Title? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Title.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}
