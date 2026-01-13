class Report {
  final String content;
  final Map<String, dynamic> metadata;

  Report({
    required this.content,
    required this.metadata,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      content: json['content'],
      metadata: json['metadata'] ?? {},
    );
  }

  String get deployTag => metadata['deployTag'] ?? 'N/A';
  String get promptVersion => metadata['promptVersion'] ?? 'N/A';
  String get source => metadata['source'] ?? 'N/A';
}