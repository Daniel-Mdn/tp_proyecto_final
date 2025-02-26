class CertificationForm {
  final String title;
  final String description;
  final String institution;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool inProgress;
  final String experienceType;

  CertificationForm({
    required this.title,
    required this.description,
    required this.institution,
    required this.startDate,
    required this.endDate,
    required this.inProgress,
    required this.experienceType,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "institution": institution,
      "startDate": startDate?.toIso8601String(),
      "endDate": endDate?.toIso8601String(),
      "inProgress": inProgress,
      "experienceType": experienceType,
    };
  }
}