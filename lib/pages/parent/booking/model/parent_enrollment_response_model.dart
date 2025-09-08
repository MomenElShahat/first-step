class ParentEnrollmentResponseModel {
  final int? id;
  final int? branchId;
  final String? branchName;
  final int? centerId;
  final String? centerName;
  final int? userId;
  final String? parentPhone;
  final String? parentName;
  final int? priceAmount;
  final String? enrollmentType;
  final String? responseSpeed;
  final DateTime? enrollmentDate;
  final String? status;

  ParentEnrollmentResponseModel({
    this.id,
    this.branchId,
    this.branchName,
    this.centerId,
    this.centerName,
    this.userId,
    this.parentPhone,
    this.parentName,
    this.priceAmount,
    this.enrollmentType,
    this.responseSpeed,
    this.enrollmentDate,
    this.status,
  });

  factory ParentEnrollmentResponseModel.fromJson(json) {
    return ParentEnrollmentResponseModel(
      id: json['id'],
      branchId: json['branch_id'],
      branchName: json['branch_name'],
      centerId: json['center_id'],
      centerName: json['center_name'],
      userId: json['user_id'],
      parentPhone: json['parent_phone'],
      parentName: json['parent_name'],
      priceAmount: json['price_amount'],
      enrollmentType: json['enrollment_type'],
      responseSpeed: json['response_speed'],
      enrollmentDate: json['enrollment_date'] != null ? DateTime.tryParse(json['enrollment_date']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (branchName != null) 'branch_name': branchName,
      if (centerId != null) 'center_id': centerId,
      if (centerName != null) 'center_name': centerName,
      if (userId != null) 'user_id': userId,
      if (parentPhone != null) 'parent_phone': parentPhone,
      if (parentName != null) 'parent_name': parentName,
      if (priceAmount != null) 'price_amount': priceAmount,
      if (enrollmentType != null) 'enrollment_type': enrollmentType,
      if (responseSpeed != null) 'response_speed': responseSpeed,
      if (enrollmentDate != null) 'enrollment_date': enrollmentDate!.toIso8601String(),
      if (status != null) 'status': status,
    };
  }
}
