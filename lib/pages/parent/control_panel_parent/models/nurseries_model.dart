class NurseriesModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? emailVerifiedAt;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? nationalNumber;
  int? branchId;
  String? freeTrialEndsAt;
  String? subscriptionStatus;
  int? planId;
  String? subscriptionEndDate;

  NurseriesModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.emailVerifiedAt,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.nationalNumber,
        this.branchId,
        this.freeTrialEndsAt,
        this.subscriptionStatus,
        this.planId,
        this.subscriptionEndDate});

  NurseriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nationalNumber = json['national_number'];
    branchId = json['branch_id'];
    freeTrialEndsAt = json['free_trial_ends_at'];
    subscriptionStatus = json['subscription_status'];
    planId = json['plan_id'];
    subscriptionEndDate = json['subscription_end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['national_number'] = this.nationalNumber;
    data['branch_id'] = this.branchId;
    data['free_trial_ends_at'] = this.freeTrialEndsAt;
    data['subscription_status'] = this.subscriptionStatus;
    data['plan_id'] = this.planId;
    data['subscription_end_date'] = this.subscriptionEndDate;
    return data;
  }
}
