import '../../../center/control_panel/models/child_model.dart';

class AddChildResponseModel {
  String? message;
  ChildModel? child;

  AddChildResponseModel({this.message, this.child});

  AddChildResponseModel.fromJson(json) {
    message = json['message'];
    child = json['child'] != null ? new ChildModel.fromJson(json['child']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.child != null) {
      data['child'] = this.child!.toJson();
    }
    return data;
  }
}

class DiseaseDetails {
  String? diseaseName;
  String? medicament;
  String? emergency;

  DiseaseDetails({this.diseaseName, this.medicament, this.emergency});

  DiseaseDetails.fromJson(Map<String, dynamic> json) {
    diseaseName = json['disease_name'];
    medicament = json['medicament'];
    emergency = json['emergency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_name'] = this.diseaseName;
    data['medicament'] = this.medicament;
    data['emergency'] = this.emergency;
    return data;
  }
}
