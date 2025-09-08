// ignore: one_member_abstracts
import 'dart:convert';

import 'package:first_step/pages/center/control_panel/models/center_info_model.dart';
import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:first_step/pages/center/control_panel/models/portfolio_response_model.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../../../booking_details/model/enrollment_details_model.dart';
import '../../../parent/control_panel_parent/models/daily_reports_model.dart';
import '../../edit_member/models/branch_team_member_model.dart';
import '../models/branch_model.dart';
import '../models/branch_team_model.dart';
import '../models/center_enrollment_model.dart';
import '../models/chats_model.dart';
import '../models/parent_model.dart';
import '../models/portfolio_prices_model.dart';
import '../models/show_portfolio_response_model.dart';
import '../models/statistics_model.dart';

abstract class IControlPanelProvider {
  Future<Response<List<BranchModel>>> getBranches();

  Future<Response<List<ParentModel>>> getParents();

  Future<Response<List<Contacts>>> getChats();

  Future<Response<List<ChildModel>>> getChildren();

  Future<Response<BranchModel>> getBranchDetails(String branchId);

  Future<Response<StatisticsModel>> getStatistics();

  Future<Response<BranchTeamMemberModel>> deleteMember(String memberId);

  Future<Response<String>> deleteBranch(String branchId);

  Future<Response<BranchTeamModel>> getBranchTeam(String branchId);

  Future<Response<DailyReportsModel>> getDailyReports();

  Future<Response<CenterEnrollmentsModel>> getEnrollments();

  Future<Response<EnrollmentData>> enrollmentRespond({required String enrollmentId, required String respond});

  Future<Response<PortfolioResponseModel>> updatePortfolio({String? centerId, required FormData formData, required bool isUpdate});
  Future<Response<ShowPortfolioResponseModel>> showPortfolio();
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId);
  // Future<Response<String>> updatePortfolioPrices(
  //     {required String branchId, required PortfolioPricesModel hourly, required PortfolioPricesModel daily, required PortfolioPricesModel monthly});
  Future<Response<String>> createPortfolioPrices(
      {required String branchId, required List<PortfolioPrice> portfolioPrice});
}

class ControlPanelProvider extends BaseAuthProvider implements IControlPanelProvider {
  @override
  Future<Response<List<BranchModel>>> getBranches() {
    return get<List<BranchModel>>(
      EndPoints.branchesList,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => BranchModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<PortfolioResponseModel>> updatePortfolio({
    String? centerId,
    required FormData formData,
    required bool isUpdate,
  }) {
    formData.fields.forEach((field) => print('FIELD => ${field.key}: ${field.value}'));
    return post<PortfolioResponseModel>(
      isUpdate ? "${EndPoints.portfolios}/$centerId" : EndPoints.portfolios,
      formData,
      decoder: PortfolioResponseModel.fromJson,
      contentType: 'multipart/form-data',
    );
  }

  @override
  Future<Response<ShowPortfolioResponseModel>> showPortfolio() {
    return get<ShowPortfolioResponseModel>(
      EndPoints.portfoliosShow,
      decoder: ShowPortfolioResponseModel.fromJson,
    );
  }

  // @override
  // Future<Response<String>> updatePortfolioPrices(
  //     {required String branchId, required PortfolioPricesModel hourly, required PortfolioPricesModel daily, required PortfolioPricesModel monthly}) {
  //   final body = {
  //     "pricing": [hourly.toJson(), daily.toJson(), monthly.toJson()]
  //   };
  //
  //   print(jsonEncode(body)); // To verify structure in console
  //
  //   return put<String>(
  //     "${EndPoints.branchesList}/$branchId/${EndPoints.pricing}",
  //     body,
  //     decoder: (data) {
  //       final jsonList = data["message"] as String;
  //       return jsonList;
  //     },
  //   );
  // }

  @override
  Future<Response<String>> createPortfolioPrices({
    required String branchId,
    required List<PortfolioPrice> portfolioPrice,
  }) {
    final body = {
      "pricing": portfolioPrice.map((p) => p.toJsonSnake()).toList(),
    };

    return post<String>(
      "${EndPoints.branchesList}/$branchId/${EndPoints.pricing}",
      body,
      contentType: 'application/json',
      decoder: (data) => (data["message"] as String?) ?? "",
    );
  }


  @override
  Future<Response<List<PortfolioPrice>>> showPortfolioPrices(String branchId) {
    return get<List<PortfolioPrice>>(
      "${EndPoints.branchesPricies}/$branchId",
      decoder: (data) {
        final jsonList = data["data"] as List<dynamic>;
        return jsonList.map((e) => PortfolioPrice.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<DailyReportsModel>> getDailyReports() {
    return get<DailyReportsModel>(
      EndPoints.centerDailyReports,
      decoder: DailyReportsModel.fromJson,
    );
  }

  @override
  Future<Response<List<ParentModel>>> getParents() {
    return get<List<ParentModel>>(
      EndPoints.parentsList,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => ParentModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<List<Contacts>>> getChats() {
    return get<List<Contacts>>(
      EndPoints.chatContacts,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => Contacts.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<List<ChildModel>>> getChildren() {
    return get<List<ChildModel>>(
      EndPoints.childrenList,
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => ChildModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<Response<BranchModel>> getBranchDetails(String branchId) {
    return get<BranchModel>(
      "${EndPoints.branchesList}/$branchId",
      decoder: BranchModel.fromJson,
    );
  }

  @override
  Future<Response<StatisticsModel>> getStatistics() {
    return get<StatisticsModel>(
      AuthService.to.userInfo?.user?.role != null ? EndPoints.centerStatistics : EndPoints.branchStatistics,
      decoder: StatisticsModel.fromJson,
    );
  }

  @override
  Future<Response<BranchTeamMemberModel>> deleteMember(String memberId) {
    return delete<BranchTeamMemberModel>(
      "${EndPoints.branchTeamMembers}/$memberId",
      decoder: BranchTeamMemberModel.fromJson,
    );
  }

  @override
  Future<Response<String>> deleteBranch(String branchId) {
    return delete<String>(
      "${EndPoints.branchesList}/$branchId",
      decoder: (data) {
        var message = data["message"];
        return message;
      },
    );
  }

  @override
  Future<Response<BranchTeamModel>> getBranchTeam(String branchId) {
    return get<BranchTeamModel>(
      EndPoints.branchTeamMembers,
      query: {"branch_id": branchId},
      decoder: BranchTeamModel.fromJson,
    );
  }

  @override
  Future<Response<CenterEnrollmentsModel>> getEnrollments() {
    return get<CenterEnrollmentsModel>(
      EndPoints.enrollmentsGetForMobile,
      decoder: CenterEnrollmentsModel.fromJson,
    );
  }

  @override
  Future<Response<EnrollmentData>> enrollmentRespond({required String enrollmentId, required String respond}) {
    return patch<EnrollmentData>("${EndPoints.parentEnrollmentRequest}/$enrollmentId", {"status": respond}, decoder: EnrollmentData.fromJson);
  }
}
