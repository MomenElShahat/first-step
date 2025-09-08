import 'package:first_step/pages/center/control_panel/models/portfolio_response_model.dart';

class ShowPortfolioResponseModel {
  Portofilo? portofilo;

  ShowPortfolioResponseModel({this.portofilo});

  ShowPortfolioResponseModel.fromJson(json) {
    portofilo = json['portofilo'] != null ? new Portofilo.fromJson(json['portofilo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.portofilo != null) {
      data['portofilo'] = this.portofilo!.toJson();
    }
    return data;
  }
}
