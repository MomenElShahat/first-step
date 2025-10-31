import 'dart:io';

import 'package:get/get.dart';

class ChildRequestModel {
  String? childName;
  String? birthdayDate;
  String? parentName;
  String? motherName;
  String? kinship;
  String? gender;
  String? nationalNumber;
  File? childImage; // ✅ stays here

  ChildRequestModel({
    this.childName,
    this.birthdayDate,
    this.parentName,
    this.motherName,
    this.kinship,
    this.gender,
    this.nationalNumber,
    this.childImage,
  });

  /// Returns only text fields
  Map<String, String> toFieldMap(int index) {
    final prefix = 'children[$index]';
    final map = <String, String>{};

    void addIfNotNull(String key, dynamic value) {
      if (value != null) map['$prefix[$key]'] = value.toString();
    }

    addIfNotNull('child_name', childName);
    addIfNotNull('birthday_date', birthdayDate);
    addIfNotNull('parent_name', parentName);
    addIfNotNull('mother_name', motherName);
    addIfNotNull('kinship', kinship);
    addIfNotNull('gender', gender);
    addIfNotNull('national_number', nationalNumber);

    return map;
  }

  /// ✅ Special handling for file
  MapEntry<String, MultipartFile>? toFileMap(int index) {
    if (childImage == null) return null;
    return MapEntry(
      'children[$index][image]',
      MultipartFile(
        childImage!,
        filename: childImage!.path.split('/').last,
      ),
    );
  }
}
