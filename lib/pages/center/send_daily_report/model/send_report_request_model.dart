class SendReportRequestModel {
  final List<int> childIds;
  final String napTime;
  final String meals;
  final String activities;
  final String behavior;
  final String notes;

  SendReportRequestModel({
    required this.childIds,
    required this.napTime,
    required this.meals,
    required this.activities,
    required this.behavior,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'child_ids': childIds,
      'nap_time': napTime,
      'meals': meals,
      'activities': activities,
      'behavior': behavior,
      'notes': notes,
    };
  }
}