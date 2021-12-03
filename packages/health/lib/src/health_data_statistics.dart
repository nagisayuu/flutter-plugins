part of health;

/// A [HealthDataStatistics] object corresponds to a data point captures from
/// GoogleFit or Apple HealthKit
class HealthDataStatistics {
  num _value;
  HealthDataType _type;
  HealthDataUnit _unit;
  DateTime _dateFrom;
  DateTime _dateTo;
  PlatformType _platform;
  String _deviceId;
  String _aggregationStyle;
  List<Source> _sources;


  HealthDataStatistics(
      this._value,
      this._type,
      this._unit,
      this._dateFrom,
      this._dateTo,
      this._platform,
      this._deviceId,
      this._aggregationStyle,
      this._sources,
      ) {
    // set the value to minutes rather than the category
    // returned by the native API
    if (type == HealthDataType.MINDFULNESS ||
        type == HealthDataType.SLEEP_IN_BED ||
        type == HealthDataType.SLEEP_ASLEEP ||
        type == HealthDataType.SLEEP_AWAKE) {
      this._value = _convertMinutes();
    }
  }

  double _convertMinutes() {
    int ms = dateTo.millisecondsSinceEpoch - dateFrom.millisecondsSinceEpoch;
    return ms / (1000 * 60);
  }

  /// Converts a json object to the [HealthDataStatistics]
  factory HealthDataStatistics.fromJson(json) => HealthDataStatistics(
      json['value'],
      HealthDataTypeJsonValue.keys.toList()[
          HealthDataTypeJsonValue.values.toList().indexOf(json['data_type'])],
      HealthDataUnitJsonValue.keys.toList()[
          HealthDataUnitJsonValue.values.toList().indexOf(json['unit'])],
      DateTime.parse(json['date_from']),
      DateTime.parse(json['date_to']),
      PlatformTypeJsonValue.keys.toList()[
          PlatformTypeJsonValue.values.toList().indexOf(json['platform_type'])],
      json['platform_type'],
      json['aggregation_style'],
      json['sources']
      );

  /// Converts the [HealthDataStatistics] to a json object
  Map<String, dynamic> toJson() => {
        'value': value,
        'data_type': HealthDataTypeJsonValue[type],
        'unit': HealthDataUnitJsonValue[unit],
        'date_from': DateFormat('yyyy-MM-dd HH:mm:ss').format(dateFrom),
        'date_to': DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTo),
        'platform_type': PlatformTypeJsonValue[platform],
        'device_id': deviceId,
        'aggregation_style': aggregationStyle,
        'sources': sources
      };

  /// Converts the [HealthDataStatistics] to a string
  String toString() => '${this.runtimeType} - '
      'value: $value, '
      'unit: $unit, '
      'dateFrom: $dateFrom, '
      'dateTo: $dateTo, '
      'platform: $platform, '
      'aggregationStyle: $aggregationStyle, '
      'sources: $sources, ';

  /// Get the quantity value of the data point
  num get value => _value;

  /// Get the start of the datetime interval
  DateTime get dateFrom => _dateFrom;

  /// Get the end of the datetime interval
  DateTime get dateTo => _dateTo;

  /// Get the type of the data point
  HealthDataType get type => _type;

  /// Get the unit of the data point
  HealthDataUnit get unit => _unit;

  /// Get the software platform of the data point
  /// (i.e. Android or iOS)
  PlatformType get platform => _platform;

  /// Get the data point type as a string
  String get typeString => _enumToString(_type);

  /// Get the data point unit as a string
  String get unitString => _enumToString(_unit);

  /// Get the id of the device from which
  /// the data point was extracted
  String get deviceId => _deviceId;


  /// Get the aggregation_style from which
  /// the data point was extracted
  String get aggregationStyle => _aggregationStyle;

  /// Get the sources from which
  /// the data point was extracted
  List<Source> get sources => _sources;

  /// An equals (==) operator for comparing two data points
  /// This makes it possible to remove duplicate data points.
  @override
  bool operator ==(Object o) {
    return o is HealthDataStatistics &&
        this.value == o.value &&
        this.unit == o.unit &&
        this.dateFrom == o.dateFrom &&
        this.dateTo == o.dateTo &&
        this.type == o.type &&
        this.platform == o.platform &&
        this.deviceId == o.deviceId &&
        this.aggregationStyle == o.aggregationStyle &&
        this.sources == o.sources;
  }

  /// Override required due to overriding the '==' operator
  @override
  int get hashCode => toJson().hashCode;
}
