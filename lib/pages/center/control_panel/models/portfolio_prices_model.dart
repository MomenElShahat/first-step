class PortfolioPricesModel {
  List<PortfolioPrice>? data;

  PortfolioPricesModel({this.data});

  PortfolioPricesModel.fromJson(json) {
    if (json['data'] != null) {
      data = <PortfolioPrice>[];
      json['data'].forEach((v) {
        data!.add(new PortfolioPrice.fromJson(v));
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

class PortfolioPrice {
  int? id;
  int? branchId;
  String? enrollmentType;
  String? title;
  int? startAge;
  int? endAge;
  int? count;
  String? priceAmount;
  String? createdAt;
  String? updatedAt;

  PortfolioPrice(
      {this.id,
        this.branchId,
        this.enrollmentType,
        this.title,
        this.startAge,
        this.endAge,
        this.count,
        this.priceAmount,
        this.createdAt,
        this.updatedAt});

  PortfolioPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    enrollmentType = json['enrollment_type'];
    title = json['title'];
    startAge = json['start_age'];
    endAge = json['end_age'];
    count = json['count'];
    priceAmount = json['price_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['enrollment_type'] = this.enrollmentType;
    data['title'] = this.title;
    data['start_age'] = this.startAge;
    data['end_age'] = this.endAge;
    data['count'] = this.count;
    data['price_amount'] = this.priceAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  Map<String, dynamic> toJsonSnake() {
    return {
      if (id != null) "id": id,
      "enrollment_type": enrollmentType?.trim(),
      "title": title?.trim(),
      "start_age": startAge,
      "end_age": endAge,
      "count": count,
      "price_amount": priceAmount,
    };
  }

  Map<String, dynamic> canonical() {
    return {
      "id": id,
      "enrollment_type": enrollmentType?.trim(),
      "title": title?.trim(),
      "start_age": startAge,
      "end_age": endAge,
      "count": count,
      "price_amount": priceAmount,
    };
  }
  PortfolioPrice copy() => PortfolioPrice()
    ..id = id
    ..enrollmentType = enrollmentType
    ..title = title
    ..startAge = startAge
    ..endAge = endAge
    ..count = count
    ..priceAmount = priceAmount;
}
