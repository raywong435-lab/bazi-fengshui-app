class BirthInfo {
  final DateTime birthDate;
  final String birthTime; // HH:MM format
  final String birthPlace; // City, Country

  BirthInfo({
    required this.birthDate,
    required this.birthTime,
    required this.birthPlace,
  });

  Map<String, dynamic> toJson() {
    return {
      'birthDate': birthDate.toIso8601String(),
      'birthTime': birthTime,
      'birthPlace': birthPlace,
    };
  }

  factory BirthInfo.fromJson(Map<String, dynamic> json) {
    return BirthInfo(
      birthDate: DateTime.parse(json['birthDate']),
      birthTime: json['birthTime'],
      birthPlace: json['birthPlace'],
    );
  }
}