import 'dart:io';

import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as gf;

class AddParentsRequestModel {
  final List<ParentModel>? parents;

  AddParentsRequestModel({this.parents});

  Future<gf.FormData> toFormData() async {
    final Map<String, dynamic> fields = {};

    for (int pIndex = 0; pIndex < (parents?.length ?? 0); pIndex++) {
      final parent = parents?[pIndex];
      fields["parents[$pIndex][name]"] = parent?.name;
      fields["parents[$pIndex][email]"] = parent?.email;
      fields["parents[$pIndex][national_number]"] = parent?.nationalNumber;
      fields["parents[$pIndex][phone]"] = parent?.phone;

      for (int cIndex = 0; cIndex < (parent?.children?.length ?? 0); cIndex++) {
        final child = parent?.children?[cIndex];
        fields["parents[$pIndex][children][$cIndex][child_name]"] = child?.childName;
        fields["parents[$pIndex][children][$cIndex][birthday_date]"] = child?.birthdayDate;
        fields["parents[$pIndex][children][$cIndex][parent_name]"] = child?.parentName;
        fields["parents[$pIndex][children][$cIndex][mother_name]"] = child?.motherName;
        fields["parents[$pIndex][children][$cIndex][kinship]"] = child?.kinship;
        fields["parents[$pIndex][children][$cIndex][gender]"] = child?.gender;
        fields["parents[$pIndex][children][$cIndex][national_number]"] = child?.nationalNumber;

        if (child?.imagePath != null) {
          fields["parents[$pIndex][children][$cIndex][image]"] = MultipartFile(
            child?.imagePath!,
            filename: child?.imagePath!.path.split('/').last ?? "",
          );
        }
      }
    }

    return gf.FormData(fields);
  }
}

class ParentModel {
  final String? name;
  final String? email;
  final String? nationalNumber;
  final String? phone;
  final List<ChildModel>? children;

  ParentModel({
    this.name,
    this.email,
    this.nationalNumber,
    this.phone,
    this.children,
  });
}

class ChildModel {
  final String? childName;
  final String? birthdayDate;
  final String? parentName;
  final String? motherName;
  final String? kinship;
  final String? gender;
  final String? nationalNumber;
  final File? imagePath;

  ChildModel({
    this.childName,
    this.birthdayDate,
    this.parentName,
    this.motherName,
    this.kinship,
    this.gender,
    this.nationalNumber,
    this.imagePath,
  });
}
