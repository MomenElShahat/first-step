class BillingHistoryModel {
  List<Bill>? data;

  BillingHistoryModel({this.data});

  BillingHistoryModel.fromJson(json) {
    if (json['data'] != null) {
      data = <Bill>[];
      json['data'].forEach((v) {
        data!.add(new Bill.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bill {
  int? id;
  String? typeOfPlan;
  String? startOfSubscription;
  String? endOfSubscription;
  // String? typeOfPayment;
  String? price;
  String? subscriptionStatus;

  Bill(
      {this.id,
        this.typeOfPlan,
        this.startOfSubscription,
        this.endOfSubscription,
        // this.typeOfPayment,
        this.price,
        this.subscriptionStatus});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeOfPlan = json['plan'];
    startOfSubscription = json['start_of_subscription'];
    endOfSubscription = json['end_of_subscription'];
    // typeOfPayment = json['type_of_payment'];
    price = json['total'];
    subscriptionStatus = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan'] = this.typeOfPlan;
    data['start_of_subscription'] = this.startOfSubscription;
    data['end_of_subscription'] = this.endOfSubscription;
    // data['type_of_payment'] = this.typeOfPayment;
    data['total'] = this.price;
    data['status'] = this.subscriptionStatus;
    return data;
  }
}
