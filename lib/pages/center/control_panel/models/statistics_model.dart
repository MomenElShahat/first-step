class StatisticsModel {
  int? totalEnrollments;
  int? totalActiveEnrollments;
  int? totalBranches;
  int? totalChildren;
  int? totalTeamMembers;
  int? totalParents;
  Map<String, dynamic>? enrollmentsOverTime;
  EnrollmentStatusBreakdown? enrollmentStatusBreakdown;
  ChildDemographics? childDemographics;
  ParentEngagement? parentEngagement;
  List<TotalRevenueForTheLates5Months>? totalRevenueForTheLates5Months;
  List<BranchesOrderingDependingOnTheNumberOfEnrollments>? branchesOrderingDependingOnTheNumberOfEnrollments;

  StatisticsModel(
      {this.totalEnrollments,
      this.totalActiveEnrollments,
      this.totalBranches,
      this.totalChildren,
      this.totalTeamMembers,
      this.totalParents,
      this.enrollmentsOverTime,
      this.enrollmentStatusBreakdown,
      this.childDemographics,
      this.parentEngagement,
      this.totalRevenueForTheLates5Months,
      this.branchesOrderingDependingOnTheNumberOfEnrollments});

  StatisticsModel.fromJson(json) {
    totalEnrollments = json['total_enrollments'];
    totalActiveEnrollments = json['total_active_enrollments'];
    totalBranches = json['total_branches'];
    totalChildren = json['total_children'];
    totalTeamMembers = json['total_team_members'];
    totalParents = json['total_parents'];
    enrollmentsOverTime = json['enrollments_over_time'];
    enrollmentStatusBreakdown =
        json['enrollment_status_breakdown'] != null ? new EnrollmentStatusBreakdown.fromJson(json['enrollment_status_breakdown']) : null;
    childDemographics = json['child_demographics'] != null ? new ChildDemographics.fromJson(json['child_demographics']) : null;
    parentEngagement = json['parent_engagement'] != null ? new ParentEngagement.fromJson(json['parent_engagement']) : null;
    if (json['total_revenue_for_the_lates_5_months'] != null) {
      totalRevenueForTheLates5Months = <TotalRevenueForTheLates5Months>[];
      json['total_revenue_for_the_lates_5_months'].forEach((v) {
        totalRevenueForTheLates5Months!.add(new TotalRevenueForTheLates5Months.fromJson(v));
      });
    }
    if (json['branches_ordering_depending_on_the_number_of_enrollments'] != null) {
      branchesOrderingDependingOnTheNumberOfEnrollments = <BranchesOrderingDependingOnTheNumberOfEnrollments>[];
      json['branches_ordering_depending_on_the_number_of_enrollments'].forEach((v) {
        branchesOrderingDependingOnTheNumberOfEnrollments!.add(new BranchesOrderingDependingOnTheNumberOfEnrollments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_enrollments'] = this.totalEnrollments;
    data['total_active_enrollments'] = this.totalActiveEnrollments;
    data['total_branches'] = this.totalBranches;
    data['total_children'] = this.totalChildren;
    data['total_team_members'] = this.totalTeamMembers;
    data['total_parents'] = this.totalParents;
    data['enrollments_over_time'] = this.enrollmentsOverTime;
    if (this.enrollmentStatusBreakdown != null) {
      data['enrollment_status_breakdown'] = this.enrollmentStatusBreakdown!.toJson();
    }
    if (this.childDemographics != null) {
      data['child_demographics'] = this.childDemographics!.toJson();
    }
    if (this.parentEngagement != null) {
      data['parent_engagement'] = this.parentEngagement!.toJson();
    }
    if (this.totalRevenueForTheLates5Months != null) {
      data['total_revenue_for_the_lates_5_months'] = this.totalRevenueForTheLates5Months!.map((v) => v.toJson()).toList();
    }
    if (this.branchesOrderingDependingOnTheNumberOfEnrollments != null) {
      data['branches_ordering_depending_on_the_number_of_enrollments'] =
          this.branchesOrderingDependingOnTheNumberOfEnrollments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class EnrollmentsOverTime {
//   int? firstMonth;
//   int? secondMonth;
//   int? thirdMonth;
//   int? fourthMonth;
//
//   EnrollmentsOverTime({this.firstMonth, this.secondMonth, this.thirdMonth, this.fourthMonth});
//
//   EnrollmentsOverTime.fromJson(Map<String, dynamic> json) {
//     firstMonth = json['first_month'];
//     secondMonth = json['second_month'];
//     thirdMonth = json['third_month'];
//     fourthMonth = json['fourth_month'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['firstMonth'] = this.firstMonth;
//     data['secondMonth'] = this.secondMonth;
//     data['thirdMonth'] = this.thirdMonth;
//     data['fourthMonth'] = this.fourthMonth;
//     return data;
//   }
// }

class EnrollmentStatusBreakdown {
  int? waitingForConfirmation;
  int? waitingForPayment;
  int? rejected;
  int? confirmed;

  EnrollmentStatusBreakdown({this.waitingForConfirmation, this.waitingForPayment, this.rejected, this.confirmed});

  EnrollmentStatusBreakdown.fromJson(Map<String, dynamic> json) {
    waitingForConfirmation = json['waitingForConfirmation'];
    waitingForPayment = json['waitingForPayment'];
    rejected = json['rejected'];
    confirmed = json['confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['waitingForConfirmation'] = this.waitingForConfirmation;
    data['waitingForPayment'] = this.waitingForPayment;
    data['rejected'] = this.rejected;
    data['confirmed'] = this.confirmed;
    return data;
  }
}

class ChildDemographics {
  AgeGroups? ageGroups;
  GenderDistribution? genderDistribution;

  ChildDemographics({this.ageGroups, this.genderDistribution});

  ChildDemographics.fromJson(Map<String, dynamic> json) {
    ageGroups = json['age_groups'] != null && json['age_groups'] is Map<String, dynamic> ? new AgeGroups.fromJson(json['age_groups']) : null;
    genderDistribution = json['gender_distribution'] != null && json['gender_distribution'] is Map<String, dynamic>
        ? new GenderDistribution.fromJson(json['gender_distribution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ageGroups != null) {
      data['age_groups'] = this.ageGroups!.toJson();
    }
    if (this.genderDistribution != null) {
      data['gender_distribution'] = this.genderDistribution!.toJson();
    }
    return data;
  }
}

class AgeGroups {
  int? i45Years;
  int? i6Years;

  AgeGroups({this.i45Years, this.i6Years});

  AgeGroups.fromJson(Map<String, dynamic> json) {
    i45Years = json['4-5 years'];
    i6Years = json['6+ years'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['4-5 years'] = this.i45Years;
    data['6+ years'] = this.i6Years;
    return data;
  }
}

class GenderDistribution {
  int? boy;
  int? girl;

  GenderDistribution({this.boy, this.girl});

  GenderDistribution.fromJson(Map<String, dynamic> json) {
    boy = json['boy'];
    girl = json['girl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boy'] = this.boy;
    data['girl'] = this.girl;
    return data;
  }
}

class ParentEngagement {
  Map<String, dynamic>? mostActiveParents;
  int? totalMessages;

  ParentEngagement({this.mostActiveParents, this.totalMessages});

  ParentEngagement.fromJson(Map<String, dynamic> json) {
    mostActiveParents =
        json['most_active_parents'] != null && json['most_active_parents'] is Map<String, dynamic> ? json['most_active_parents'] : null;
    totalMessages = json['total_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mostActiveParents != null) {
      data['most_active_parents'] = this.mostActiveParents;
    }
    data['total_messages'] = this.totalMessages;
    return data;
  }
}

class TotalRevenueForTheLates5Months {
  String? month;
  int? totalPaid;

  TotalRevenueForTheLates5Months({this.month, this.totalPaid});

  TotalRevenueForTheLates5Months.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalPaid = json['total_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['total_paid'] = this.totalPaid;
    return data;
  }
}

class BranchesOrderingDependingOnTheNumberOfEnrollments {
  String? nurseryName;
  String? totalRevenue;
  int? enrollmentCount;

  BranchesOrderingDependingOnTheNumberOfEnrollments({this.nurseryName, this.enrollmentCount,this.totalRevenue});

  BranchesOrderingDependingOnTheNumberOfEnrollments.fromJson(Map<String, dynamic> json) {
    nurseryName = json['nursery_name'];
    totalRevenue = json['total_revenue'];
    enrollmentCount = json['enrollment_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nursery_name'] = this.nurseryName;
    data['total_revenue'] = this.totalRevenue;
    data['enrollment_count'] = this.enrollmentCount;
    return data;
  }
}
