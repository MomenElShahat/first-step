class SignupResponseModel {
  String? message;
  User? user;
  Center? center;

  SignupResponseModel({this.message, this.user, this.center});

  SignupResponseModel.fromJson(json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    center =
    json['center'] != null ? new Center.fromJson(json['center']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? address;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.name,
        this.email,
        this.address,
        this.role,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['role'] = this.role;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Center {
  String? nurseryName;
  String? location;
  String? city;
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
  String? emergencyContact;
  String? specialNeeds;
  List<String>? communicationMethods;
  String? providesFood;

  Center(
      {this.nurseryName,
        this.location,
        this.city,
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
        this.providesFood});

  Center.fromJson(Map<String, dynamic> json) {
    nurseryName = json['nursery_name'];
    location = json['location'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    phone = json['phone'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nursery_name'] = this.nurseryName;
    data['location'] = this.location;
    data['city'] = this.city;
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
