import '../../../control_panel/models/branch_model.dart';

class SignupRequestModel {
   String? name;
  String? email;
   String? password;
   String? address;
   String? phone;
   String? notes;

   List<String?>? nurseryType;
   String? additionalService;
   String? workDaysFrom;
   String? workDaysTo;

  String? workHoursFrom;
  String? workHoursTo;
   String? timeOfFirstPeriod;
   String? timeOfSecondPeriod;

  List<FirstMeals>? firstMeals;
  List<FirstMeals>? secondMeals;

   bool? emergencyContact;
   bool? specialNeeds;

   String? nurseryName;
   String? location;
   String? cityID;
   String? neighborhood;

   List<String?>? services;
   List<String?>? communicationMethods;

   bool? providesFood;
   List<String?>? acceptedAges;

   List<PricingModel>? pricing;


  SignupRequestModel({
    this.name,
    this.email,
    this.password,
    this.address,
    this.phone,
     this.nurseryType,
     this.additionalService,
     this.workDaysFrom,
     this.workDaysTo,
     this.workHoursFrom,
     this.workHoursTo,
     this.timeOfFirstPeriod,
     this.timeOfSecondPeriod,
    this.firstMeals,
    this.secondMeals,
     this.emergencyContact,
     this.specialNeeds,
     this.nurseryName,
     this.location,
     this.cityID,
     this.neighborhood,
     this.services,
     this.communicationMethods,
     this.providesFood,
     this.acceptedAges,
     this.notes,
    this.pricing,
  });

  Map<String?, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'address': address,
        'phone': phone,
        'nursery_type': nurseryType,
        'additional_service': additionalService,
        'work_days_from': workDaysFrom,
        'work_days_to': workDaysTo,
        'work_hours_from': workHoursFrom,
        'work_hours_to': workHoursTo,
        'time_of_first_period': timeOfFirstPeriod,
        'time_of_second_period': timeOfSecondPeriod,
        'first_meals': firstMeals?.map((e) => e.toJson()).toList(),
        'second_meals': secondMeals?.map((e) => e.toJson()).toList(),
        'emergency_contact': emergencyContact,
        'special_needs': specialNeeds,
        'nursery_name': nurseryName,
        'location': location,
        'city_id': cityID,
        'neighborhood': neighborhood,
        'services': services,
        'communication_methods': communicationMethods,
        'provides_food': providesFood,
        'accepted_ages': acceptedAges,
        'notes': notes,
        'pricing': pricing?.map((e) => e.toJson()).toList() ?? [],
      };
}

class MealModel {
   String? mealName;
   String? juice;
   String? components;

  MealModel({
     this.mealName,
     this.juice,
     this.components,
  });

  Map<String?, dynamic> toJson() => {
        'meal_name': mealName,
        'juice': juice,
        'components': components,
      };
}

class PricingModel {
   String? enrollmentType;
   String? responseSpeed;
   int? priceAmount;

  PricingModel({
     this.enrollmentType,
     this.responseSpeed,
     this.priceAmount,
  });

  Map<String?, dynamic> toJson() => {
        'enrollment_type': enrollmentType,
        'response_speed': responseSpeed,
        'price_amount': priceAmount,
      };
}
