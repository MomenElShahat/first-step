class ParentBranchesModel {
  int? centerId;
  int? userId;
  String? email;
  String? nurseryName;
  int? id;
  String? name;
  String? location;
  int? cityId;
  Null? cityName;
  String? neighborhood;
  String? phone;
  String? nurseryNameBranch;
  String? emailAdminBranch;
  List<String>? nurseryType;
  List<String>? services;
  Null? image;
  String? licensePath;
  String? commercialRecordPath;
  String? logo;
  Null? firstMeals;
  Null? secondMeals;
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
  int? isMainBranch;
  List<Pricing>? pricing;
  Users? users;
  int? childrenCount;
  int? enrollmentsCount;

  ParentBranchesModel(
      {this.centerId,
        this.userId,
        this.email,
        this.nurseryName,
        this.id,
        this.name,
        this.location,
        this.cityId,
        this.cityName,
        this.neighborhood,
        this.phone,
        this.nurseryNameBranch,
        this.emailAdminBranch,
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
        this.isMainBranch,
        this.pricing,
        this.users,
        this.childrenCount,
        this.enrollmentsCount});

  ParentBranchesModel.fromJson(json) {
    centerId = json['center_id'];
    userId = json['user_id'];
    email = json['email'];
    nurseryName = json['nursery_name'];
    id = json['id'];
    name = json['name'];
    location = json['location'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    neighborhood = json['neighborhood'];
    phone = json['phone'];
    nurseryNameBranch = json['nursery_name_branch'];
    emailAdminBranch = json['email_admin_branch'];
    nurseryType = json['nursery_type'].cast<String>();
    services = json['services'].cast<String>();
    image = json['image'];
    licensePath = json['license_path'];
    commercialRecordPath = json['commercial_record_path'];
    logo = json['logo'];
    firstMeals = json['first_meals'];
    secondMeals = json['second_meals'];
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
    isMainBranch = json['is_main_branch'];
    if (json['pricing'] != null) {
      pricing = <Pricing>[];
      json['pricing'].forEach((v) {
        pricing!.add(new Pricing.fromJson(v));
      });
    }
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    childrenCount = json['children_count'];
    enrollmentsCount = json['enrollments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['center_id'] = this.centerId;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['nursery_name'] = this.nurseryName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['neighborhood'] = this.neighborhood;
    data['phone'] = this.phone;
    data['nursery_name_branch'] = this.nurseryNameBranch;
    data['email_admin_branch'] = this.emailAdminBranch;
    data['nursery_type'] = this.nurseryType;
    data['services'] = this.services;
    data['image'] = this.image;
    data['license_path'] = this.licensePath;
    data['commercial_record_path'] = this.commercialRecordPath;
    data['logo'] = this.logo;
    data['first_meals'] = this.firstMeals;
    data['second_meals'] = this.secondMeals;
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
    data['is_main_branch'] = this.isMainBranch;
    if (this.pricing != null) {
      data['pricing'] = this.pricing!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.toJson();
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

class Users {
  int? id;
  String? name;
  String? email;
  String? role;
  Null? phone;
  int? branchId;
  int? centerId;
  String? nurseryName;
  String? logo;
  String? createdAt;
  String? publishedAt;

  Users(
      {this.id,
        this.name,
        this.email,
        this.role,
        this.phone,
        this.branchId,
        this.centerId,
        this.nurseryName,
        this.logo,
        this.createdAt,
        this.publishedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    branchId = json['branch_id'];
    centerId = json['center_id'];
    nurseryName = json['nursery_name'];
    logo = json['logo'];
    createdAt = json['created_at'];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['branch_id'] = this.branchId;
    data['center_id'] = this.centerId;
    data['nursery_name'] = this.nurseryName;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['published_at'] = this.publishedAt;
    return data;
  }
}
