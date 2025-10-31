class ExistingEnrollmentRequestModel {
  final int centerBranchId;
  final int branchPriceId;
  final String? parentPhone;
  final List<int> children;
  final String? dayString; // optional, only for 'hour'
  final String? startingTime; // optional, only for 'hour'
  final String? startingDate; // required for day/week/month/year

  ExistingEnrollmentRequestModel({
    required this.centerBranchId,
    required this.branchPriceId,
    this.parentPhone,
    required this.children,
    this.dayString,
    this.startingTime,
    this.startingDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "center_branch_id": centerBranchId,
      "branch_price_id": branchPriceId,
      if (parentPhone != null) "parent_phone": parentPhone,
      "children": children,
      if (dayString != null) "day_string": dayString,
      if (startingTime != null) "starting_time": startingTime,
      if (startingDate != null) "starting_date": startingDate,
    };
  }

  factory ExistingEnrollmentRequestModel.fromJson(Map<String, dynamic> json) {
    return ExistingEnrollmentRequestModel(
      centerBranchId: json["center_branch_id"],
      branchPriceId: json["branch_price_id"],
      parentPhone: json["parent_phone"],
      children: List<int>.from(json["children"] ?? []),
      dayString: json["day_string"],
      startingTime: json["starting_time"],
      startingDate: json["starting_date"],
    );
  }
}
