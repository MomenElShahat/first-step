import '../../../center/auth/signup/models/cities_model.dart';

class CentersModel {
  List<NurseryModel>? data;

  CentersModel({this.data});

  CentersModel.fromJson(json) {
    if (json['data'] != null) {
      data = <NurseryModel>[];
      json['data'].forEach((v) {
        data!.add(new NurseryModel.fromJson(v));
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

class NurseryModel {
  int? id;
  String? nurseryName;
  String? location;
  int? cityId;
  CityName? cityName;
  String? neighborhood;
  String? phone;
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

  NurseryModel(
      {this.nurseryName,
      this.id,
      this.location,
      this.cityId,
      this.cityName,
      this.neighborhood,
      this.phone,
      this.userId,
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

  NurseryModel.fromJson(json) {
    id = json['id'];
    nurseryName = json['nursery_name'];
    location = json['location'];
    cityId = json['city_id'];
    cityName = json['city_name'] != null ? new CityName.fromJson(json['city_name']) : null;
    neighborhood = json['neighborhood'];
    phone = json['phone'];
    userId = json['user_id'];
    licensePath = json['license_path'];
    logo = json['logo'];
    commercialRecordPath = json['commercial_record_path'];
    nurseryType = json['nursery_type'] is List
        ? List<String>.from(json['nursery_type'])
        : json['nursery_type'] != null
            ? [json['nursery_type'].toString()]
            : [];
    services = json['services'] is List
        ? List<String>.from(json['services'])
        : json['services'] != null
            ? [json['services'].toString()]
            : [];
    additionalService = json['additional_service'];
    acceptedAges = json['accepted_ages'] is List
        ? List<String>.from(json['accepted_ages'])
        : json['accepted_ages'] != null
            ? [json['accepted_ages'].toString()]
            : [];
    if (json['first_meals'] != null && json['first_meals'] is List) {
      firstMeals = [];
      for (var v in json['first_meals']) {
        if (v is Map<String, dynamic>) {
          firstMeals!.add(FirstMeals.fromJson(v));
        }
      }
    }
    if (json['second_meals'] != null && json['second_meals'] is List) {
      secondMeals = [];
      for (var v in json['second_meals']) {
        if (v is Map<String, dynamic>) {
          secondMeals!.add(FirstMeals.fromJson(v));
        }
      }
    }
    workDaysFrom = json['work_days_from'];
    workDaysTo = json['work_days_to'];
    workHoursFrom = json['work_hours_from'];
    timeOfFirstPeriod = json['time_of_first_period'];
    timeOfSecondPeriod = json['time_of_second_period'];
    workHoursTo = json['work_hours_to'];
    emergencyContact = json['emergency_contact'];
    specialNeeds = json['special_needs'];
    communicationMethods = json['communication_methods'] is List
        ? List<String>.from(json['communication_methods'])
        : json['communication_methods'] != null
            ? [json['communication_methods'].toString()]
            : [];
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
    if (this.cityName != null) {
      data['city_name'] = this.cityName!.toJson();
    }
    data['neighborhood'] = this.neighborhood;
    data['phone'] = this.phone;
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

class CityName {
  String? en;
  String? ar;

  CityName({this.en, this.ar});

  CityName.fromJson(Map<String, dynamic> json) {
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

  Ads({this.id, this.centerId, this.branchId, this.title, this.description, this.image, this.publishDate, this.endDate, this.status});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['center_id'];
    branchId = json['branch_id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null ? new Title.fromJson(json['description']) : null;
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

  Branches({this.id, this.cityId, this.nurseryName, this.isMainBranch, this.teams, this.pricing, this.city});

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
  int? id;
  int? branchId;
  String? enrollmentType;
  String? title;
  int? startAge;
  int? endAge;
  int? count;
  String? priceAmount;
  String? createdAt;
  String? updatedAt;

  Pricing(
      {this.id,
        this.branchId,
        this.enrollmentType,
        this.title,
        this.startAge,
        this.endAge,
        this.count,
        this.priceAmount,
        this.createdAt,
        this.updatedAt});

  Pricing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    enrollmentType = json['enrollment_type'];
    title = json['title'];
    startAge = json['start_age'];
    endAge = json['end_age'];
    count = json['count'];
    priceAmount = json['price_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['enrollment_type'] = this.enrollmentType;
    data['title'] = this.title;
    data['start_age'] = this.startAge;
    data['end_age'] = this.endAge;
    data['count'] = this.count;
    data['price_amount'] = this.priceAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
