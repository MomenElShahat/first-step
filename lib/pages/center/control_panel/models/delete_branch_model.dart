import 'package:first_step/pages/center/auth/signup/models/signup_response_model.dart';

class DeleteBranchModel {
  int? centerId;
  String? nurseryName;
  int? id;
  String? name;
  String? location;
  String? city;
  String? neighborhood;
  String? phone;
  String? nurseryNameBranch;
  List<String>? nurseryType;
  List<String>? services;
  String? image;
  String? licensePath;
  String? commercialRecordPath;
  String? logo;
  List<FirstMeals>? firstMeals;
  List<FirstMeals>? secondMeals;
  String? additionalService;
  List<String>? acceptedAges;
  String? workDaysFrom;
  String? workDaysTo;
  String? workHoursFrom;
  String? workHoursTo;
  bool? emergencyContact;
  String? timeOfFirstPeriod;
  String? timeOfSecondPeriod;
  bool? specialNeeds;
  List<String>? communicationMethods;
  bool? providesFood;
  List<Pricing>? pricing;
  int? childrenCount;
  int? enrollmentsCount;

  DeleteBranchModel(
      {this.centerId,
      this.nurseryName,
      this.id,
      this.name,
      this.location,
      this.city,
      this.neighborhood,
      this.phone,
      this.nurseryNameBranch,
      this.nurseryType,
      this.services,
      this.image,
      this.licensePath,
      this.commercialRecordPath,
      this.logo,
      this.firstMeals,
      this.secondMeals,
      this.additionalService,
      this.acceptedAges,
      this.workDaysFrom,
      this.workDaysTo,
      this.workHoursFrom,
      this.workHoursTo,
      this.emergencyContact,
      this.timeOfFirstPeriod,
      this.timeOfSecondPeriod,
      this.specialNeeds,
      this.communicationMethods,
      this.providesFood,
      this.pricing,
      this.childrenCount,
      this.enrollmentsCount});

  DeleteBranchModel.fromJson(json) {
    centerId = json['center_id'];
    nurseryName = json['nursery_name'];
    id = json['id'];
    name = json['name'];
    location = json['location'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    phone = json['phone'];
    nurseryNameBranch = json['nursery_name_branch'];
    nurseryType = json['nursery_type'].cast<String>();
    services = json['services'].cast<String>();
    image = json['image'];
    licensePath = json['license_path'];
    commercialRecordPath = json['commercial_record_path'];
    logo = json['logo'];
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
    additionalService = json['additional_service'];
    acceptedAges = json['accepted_ages'].cast<String>();
    workDaysFrom = json['work_days_from'];
    workDaysTo = json['work_days_to'];
    workHoursFrom = json['work_hours_from'];
    workHoursTo = json['work_hours_to'];
    emergencyContact = json['emergency_contact'];
    timeOfFirstPeriod = json['time_of_first_period'];
    timeOfSecondPeriod = json['time_of_second_period'];
    specialNeeds = json['special_needs'];
    communicationMethods = json['communication_methods'].cast<String>();
    providesFood = json['provides_food'];
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(new Pricing.fromJson(v));
      });
    }
    childrenCount = json['children_count'];
    enrollmentsCount = json['enrollments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['center_id'] = this.centerId;
    data['nursery_name'] = this.nurseryName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['city'] = this.city;
    data['neighborhood'] = this.neighborhood;
    data['phone'] = this.phone;
    data['nursery_name_branch'] = this.nurseryNameBranch;
    data['nursery_type'] = this.nurseryType;
    data['services'] = this.services;
    data['image'] = this.image;
    data['license_path'] = this.licensePath;
    data['commercial_record_path'] = this.commercialRecordPath;
    data['logo'] = this.logo;
    if (this.firstMeals != null) {
      data['first_meals'] = this.firstMeals!.map((v) => v.toJson()).toList();
    }
    if (this.secondMeals != null) {
      data['second_meals'] = this.secondMeals!.map((v) => v.toJson()).toList();
    }
    data['additional_service'] = this.additionalService;
    data['accepted_ages'] = this.acceptedAges;
    data['work_days_from'] = this.workDaysFrom;
    data['work_days_to'] = this.workDaysTo;
    data['work_hours_from'] = this.workHoursFrom;
    data['work_hours_to'] = this.workHoursTo;
    data['emergency_contact'] = this.emergencyContact;
    data['time_of_first_period'] = this.timeOfFirstPeriod;
    data['time_of_second_period'] = this.timeOfSecondPeriod;
    data['special_needs'] = this.specialNeeds;
    data['communication_methods'] = this.communicationMethods;
    data['provides_food'] = this.providesFood;
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.map((v) => v.toJson()).toList();
    }
    data['children_count'] = this.childrenCount;
    data['enrollments_count'] = this.enrollmentsCount;
    return data;
  }
}

class Pricing {
  int? id;
  String? enrollmentType;
  String? responseSpeed;
  String? priceAmount;

  Pricing({this.id, this.enrollmentType, this.responseSpeed, this.priceAmount});

  Pricing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enrollmentType = json['enrollment_type'];
    responseSpeed = json['response_speed'];
    priceAmount = json['price_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enrollment_type'] = this.enrollmentType;
    data['response_speed'] = this.responseSpeed;
    data['price_amount'] = this.priceAmount;
    return data;
  }
}
