class SearchHistoryModel {
  final String query;
  final DateTime timestamp;

  SearchHistoryModel({required this.query, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'query': query,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory SearchHistoryModel.fromMap(Map<String, dynamic> map) {
    return SearchHistoryModel(
      query: map['query'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
