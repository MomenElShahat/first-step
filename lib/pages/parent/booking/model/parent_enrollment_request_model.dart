class ParentEnrollmentRequestModel {
  final int centerBranchId;
  final int branchPriceId;
  final String parentPhone;
  final List<int> children;

  // optional fields depending on type
  final String? dayString;      // required only for 'hour' type
  final String? startingTime;   // required only for 'hour' type
  final String? startingDate;   // required for day/week/month/year types

  ParentEnrollmentRequestModel({
    required this.centerBranchId,
    required this.branchPriceId,
    required this.parentPhone,
    required this.children,
    this.dayString,
    this.startingTime,
    this.startingDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "center_branch_id": centerBranchId,
      "branch_price_id": branchPriceId,
      "parent_phone": parentPhone,
      "children": children,
      if (dayString != null) "day_string": dayString,
      if (startingTime != null) "starting_time": startingTime,
      if (startingDate != null) "starting_date": startingDate,
    };
  }
}
