part of health;

/// A [Source] object corresponds to a data point captures from
/// GoogleFit or Apple HealthKit
class Source {
  String _sourceId;
  String _sourceName;

  Source(
      this._sourceId,
      this._sourceName) {
  }


  /// Converts a json object to the [HealthDataPoint]
  factory Source.fromJson(json) => Source(
      json['source_id'],
      json['source_name']);

  /// Converts the [HealthDataPoint] to a json object
  Map<String, dynamic> toJson() => {
        'source_id': sourceId,
        'source_name': sourceName
      };

  /// Converts the [HealthDataPoint] to a string
  String toString() => '${this.runtimeType} - '
      'sourceId: $sourceId,'
      'sourceName: $sourceName,';

  /// Get the id of the source from which
  /// the data point was extracted
  String get sourceId => _sourceId;

  /// Get the name of the source from which
  /// the data point was extracted
  String get sourceName => _sourceName;

  /// An equals (==) operator for comparing two data points
  /// This makes it possible to remove duplicate data points.
  @override
  bool operator ==(Object o) {
    return o is HealthDataPoint &&
        this.sourceId == o.sourceId &&
        this.sourceName == o.sourceName;
  }

  /// Override required due to overriding the '==' operator
  @override
  int get hashCode => toJson().hashCode;
}
