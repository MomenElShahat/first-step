import 'dart:io';
import 'package:first_step/pages/center/control_panel/models/progrma_pricing_model.dart';
import 'package:first_step/pages/center/control_panel/models/team_member_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CenterInfoModel {
  // Main Section
  String centerName;
  String centerSlogan;
  String description;
  File? backgroundImage;

  // Branches
  List<String> branches;

  // Advertising Space
  List<dynamic> adImages;

  // Our Goals Section
  String ourPhilosophy;
  String ourMethodology;
  String ourGoal;

  // Center Info Section
  String nurserySpace;
  String numberOfClasses;
  String numberOfTeamMembers;

  // Activities Section
  String activitiesDescription;
  List<dynamic> activityImages;

  // Our Team Section
  List<TeamMemberModel> teamMembers;
  List<TeamMemberModel> services;

  CenterInfoModel({
    this.centerName = '',
    this.centerSlogan = '',
    this.description = '',
    this.backgroundImage,
    this.branches = const [],
    this.adImages = const [],
    this.ourPhilosophy = '',
    this.ourMethodology = '',
    this.ourGoal = '',
    this.nurserySpace = '',
    this.numberOfClasses = '',
    this.numberOfTeamMembers = '',
    this.activitiesDescription = '',
    this.activityImages = const [],
    this.teamMembers = const [],
    this.services = const [],
  });

  // Convert to Map for API submission
  Map<String, dynamic> toJson() {
    return {
      'title_of_hero': centerName,
      'subtitle_of_hero': centerSlogan,
      'description': description,
      'background_image': backgroundImage?.path,
      'branches': branches
          .map((branch) => {
                'branch_name': branch,
              })
          .toList(),
      'ads_images': adImages.where((image) => image != null).map((image) => image!.path).toList(),
      'Philosophy_Methodology_Goal[philosophy][content]': ourPhilosophy,
      'Philosophy_Methodology_Goal[methodology][content]': ourMethodology,
      'Philosophy_Methodology_Goal[goals][content]': ourGoal,
      'nursery_state[area]': nurserySpace,
      'nursery_state[class_rooms]': numberOfClasses,
      'nursery_state[team_members]': numberOfTeamMembers,
      'activity_section_title': activitiesDescription,
      'images_activities': activityImages.where((image) => image != null).map((image) => image!.path).toList(),
      'teams': teamMembers
          .map((member) => {
                'name': member.name,
                'mission': member.profession,
                'image': member.imageUrl?.path,
              })
          .toList(),
      'services': services
          .map((member) => {
                'title': member.name,
                'description': member.profession,
                'image_service': member.imageUrl?.path,
              })
          .toList(),
    };
  }

  // Create from Map (for API response)
  factory CenterInfoModel.fromJson(Map<String, dynamic> json) {
    return CenterInfoModel(
      centerName: json['title_of_hero'] ?? '',
      centerSlogan: json['subtitle_of_hero'] ?? '',
      description: json['description'] ?? '',
      backgroundImage: json['background_image'] != null ? File(json['background_image']) : null,
      branches: List<String>.from(json['branches'] ?? []),
      adImages: (json['ads_images'] as List<dynamic>? ?? []).map((path) => path != null ? File(path) : null).toList(),
      ourPhilosophy: json['Philosophy_Methodology_Goal[philosophy][content]'] ?? '',
      ourMethodology: json['Philosophy_Methodology_Goal[methodology][content]'] ?? '',
      ourGoal: json['Philosophy_Methodology_Goal[goals][content]'] ?? '',
      nurserySpace: json['nursery_state[area]'] ?? '',
      numberOfClasses: json['nursery_state[class_rooms]'] ?? '',
      numberOfTeamMembers: json['nursery_state[team_members]'] ?? '',
      activitiesDescription: json['activity_section_title'] ?? '',
      activityImages: (json['images_activities'] as List<dynamic>? ?? []).map((path) => path != null ? File(path) : null).toList(),
      teamMembers: (json['teams'] as List<dynamic>? ?? [])
          .map((member) => TeamMemberModel(
                name: member['name'] ?? '',
                profession: member['mission'] ?? '',
                imageUrl: member['image'] != null ? File(member['image']) : null,
              ))
          .toList(),
      services: (json['services'] as List<dynamic>? ?? [])
          .map((member) => TeamMemberModel(
                name: member['title'] ?? '',
                profession: member['description'] ?? '',
                imageUrl: member['image_service'] != null ? File(member['image_service']) : null,
              ))
          .toList(),
    );
  }

  // Copy with method for easy updates
  CenterInfoModel copyWith({
    String? centerName,
    String? centerSlogan,
    String? description,
    File? backgroundImage,
    List<String>? branches,
    List<dynamic>? adImages,
    String? ourPhilosophy,
    String? ourMethodology,
    String? ourGoal,
    ProgramPricing? hourlyPricing,
    ProgramPricing? dailyPricing,
    ProgramPricing? monthlyPricing,
    String? nurserySpace,
    String? numberOfClasses,
    String? numberOfTeamMembers,
    String? activitiesDescription,
    List<dynamic>? activityImages,
    List<TeamMemberModel>? teamMembers,
    List<TeamMemberModel>? services,
  }) {
    return CenterInfoModel(
      centerName: centerName ?? this.centerName,
      centerSlogan: centerSlogan ?? this.centerSlogan,
      description: description ?? this.description,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      branches: branches ?? this.branches,
      adImages: adImages ?? this.adImages,
      ourPhilosophy: ourPhilosophy ?? this.ourPhilosophy,
      ourMethodology: ourMethodology ?? this.ourMethodology,
      ourGoal: ourGoal ?? this.ourGoal,
      nurserySpace: nurserySpace ?? this.nurserySpace,
      numberOfClasses: numberOfClasses ?? this.numberOfClasses,
      numberOfTeamMembers: numberOfTeamMembers ?? this.numberOfTeamMembers,
      activitiesDescription: activitiesDescription ?? this.activitiesDescription,
      activityImages: activityImages ?? this.activityImages,
      teamMembers: teamMembers ?? this.teamMembers,
      services: services ?? this.services,
    );
  }
}

extension CenterInfoModelDiff on CenterInfoModel {
  FormData diffWith(CenterInfoModel oldModel) {
    final Map<String, dynamic> formData = {};

    // --- Text fields ---
    _addIfChanged(formData, 'title_of_hero', centerName, oldModel.centerName);
    _addIfChanged(formData, 'subtitle_of_hero', centerSlogan, oldModel.centerSlogan);
    _addIfChanged(formData, 'description', description, oldModel.description);
    _addIfChanged(formData, 'Philosophy_Methodology_Goal[philosophy][content]', ourPhilosophy, oldModel.ourPhilosophy);
    _addIfChanged(formData, 'Philosophy_Methodology_Goal[methodology][content]', ourMethodology, oldModel.ourMethodology);
    _addIfChanged(formData, 'Philosophy_Methodology_Goal[goals][content]', ourGoal, oldModel.ourGoal);
    _addIfChanged(formData, 'nursery_state[area]', nurserySpace, oldModel.nurserySpace);
    _addIfChanged(formData, 'nursery_state[class_rooms]', numberOfClasses, oldModel.numberOfClasses);
    _addIfChanged(formData, 'nursery_state[team_members]', numberOfTeamMembers, oldModel.numberOfTeamMembers);
    _addIfChanged(formData, 'activity_section_title', activitiesDescription, oldModel.activitiesDescription);

    // --- Background image ---
    if (!_isSameFile(backgroundImage, oldModel.backgroundImage) && backgroundImage != null) {
      formData['background_image'] = MultipartFile(
        backgroundImage!,
        filename: backgroundImage!.path.split('/').last,
      );
    }

    // --- Branches ---
    if (!_listEquals(branches, oldModel.branches)) {
      for (int i = 0; i < branches.length; i++) {
        formData['branches[$i][branch_name]'] = branches[i];
      }
    }

    // --- Ad images ---
    int adsIndex = 0;
    for (var image in adImages) {
      if (image is String) {
        adsIndex++;
        continue; // skip API images
      }
      if (image is File) {
        formData['ads_images[$adsIndex]'] = MultipartFile(
          image,
          filename: image.path.split('/').last,
        );
        adsIndex++;
      }
    }

    // --- Activity images ---
    int activityIndex = 0;
    for (var image in activityImages) {
      if (image is String) {
        activityIndex++;
        continue;
      }
      if (image is File) {
        formData['images_activities[$activityIndex]'] = MultipartFile(
          image,
          filename: image.path.split('/').last,
        );
        activityIndex++;
      }
    }

    // --- Teams ---
    for (int i = 0; i < teamMembers.length; i++) {
      final newMember = teamMembers[i];
      final oldMember = i < oldModel.teamMembers.length ? oldModel.teamMembers[i] : null;

      bool nameChanged = _textChanged(newMember.name, oldMember?.name);
      bool professionChanged = _textChanged(newMember.profession, oldMember?.profession);
      bool imageChanged = !_isSameFile(_toFile(newMember.imageUrl), _toFile(oldMember?.imageUrl));

      if (nameChanged && newMember.name.isNotEmpty) {
        formData['teams[$i][name]'] = newMember.name;
      }
      if (professionChanged && newMember.profession.isNotEmpty) {
        formData['teams[$i][mission]'] = newMember.profession;
      }
      if (imageChanged && _toFile(newMember.imageUrl) != null) {
        formData['teams[$i][image]'] = MultipartFile(
          _toFile(newMember.imageUrl)!,
          filename: _toFile(newMember.imageUrl)!.path.split('/').last,
        );
      }
    }

    // --- Services ---
    for (int i = 0; i < services.length; i++) {
      final newService = services[i];
      final oldService = i < oldModel.services.length ? oldModel.services[i] : null;

      bool titleChanged = _textChanged(newService.name, oldService?.name);
      bool descriptionChanged = _textChanged(newService.profession, oldService?.profession);
      bool imageChanged = !_isSameFile(_toFile(newService.imageUrl), _toFile(oldService?.imageUrl));

      if (titleChanged && newService.name.isNotEmpty) {
        formData['services[$i][title]'] = newService.name;
      }
      if (descriptionChanged && newService.profession.isNotEmpty) {
        formData['services[$i][description]'] = newService.profession;
      }
      if (imageChanged && _toFile(newService.imageUrl) != null) {
        formData['services[$i][image_service]'] = MultipartFile(
          _toFile(newService.imageUrl)!,
          filename: _toFile(newService.imageUrl)!.path.split('/').last,
        );
      }
    }

    return FormData(formData);
  }

  // --- Helpers ---
  void _addIfChanged(Map<String, dynamic> formData, String key, String newValue, String oldValue) {
    final newClean = (newValue).trim();
    final oldClean = (oldValue).trim();
    if (newClean.isNotEmpty && newClean != oldClean) {
      formData[key] = newClean;
    }
  }

  bool _textChanged(String? newText, String? oldText) {
    return (newText ?? '').trim() != (oldText ?? '').trim();
  }

  bool _isSameFile(File? a, File? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    return a.path == b.path;
  }

  File? _toFile(dynamic val) {
    if (val is File) return val;
    return null; // skip String URLs
  }

  bool _listEquals(List? a, List? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
