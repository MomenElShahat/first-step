import '../../../control_panel/models/branch_model.dart';

class SignupRequestModel {
  final String name;
  String? email;
  final String? password;
  final String? address;
  final String phone;

  final List<String> nurseryType;
  final String additionalService;
  final String workDaysFrom;
  final String workDaysTo;

  final String workHoursFrom;
  final String workHoursTo;
  final String timeOfFirstPeriod;
  final String timeOfSecondPeriod;

  List<FirstMeals>? firstMeals;
  List<FirstMeals>? secondMeals;

  final bool emergencyContact;
  final bool specialNeeds;

  final String nurseryName;
  final String location;
  final String cityID;
  final String neighborhood;

  final List<String> services;
  final List<String> communicationMethods;

  final bool providesFood;
  final List<String> acceptedAges;

  final List<PricingModel>? pricing;


  SignupRequestModel({
    required this.name,
    this.email,
    this.password,
    this.address,
    required this.phone,
    required this.nurseryType,
    required this.additionalService,
    required this.workDaysFrom,
    required this.workDaysTo,
    required this.workHoursFrom,
    required this.workHoursTo,
    required this.timeOfFirstPeriod,
    required this.timeOfSecondPeriod,
    this.firstMeals,
    this.secondMeals,
    required this.emergencyContact,
    required this.specialNeeds,
    required this.nurseryName,
    required this.location,
    required this.cityID,
    required this.neighborhood,
    required this.services,
    required this.communicationMethods,
    required this.providesFood,
    required this.acceptedAges,
    this.pricing,
  });

  Map<String, dynamic> toJson() => {
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
        'pricing': pricing?.map((e) => e.toJson()).toList() ?? [],
      };
}

class MealModel {
  final String mealName;
  final String juice;
  final String components;

  MealModel({
    required this.mealName,
    required this.juice,
    required this.components,
  });

  Map<String, dynamic> toJson() => {
        'meal_name': mealName,
        'juice': juice,
        'components': components,
      };
}

class PricingModel {
  final String enrollmentType;
  final String responseSpeed;
  final int priceAmount;

  PricingModel({
    required this.enrollmentType,
    required this.responseSpeed,
    required this.priceAmount,
  });

  Map<String, dynamic> toJson() => {
        'enrollment_type': enrollmentType,
        'response_speed': responseSpeed,
        'price_amount': priceAmount,
      };
}
