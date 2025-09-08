class PaymentUrlModel {
  String? paymentUrl;

  PaymentUrlModel({this.paymentUrl});

  PaymentUrlModel.fromJson(json) {
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_url'] = this.paymentUrl;
    return data;
  }
}
