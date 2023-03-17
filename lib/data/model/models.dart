import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Paginated<T> {
  int? currentPage;
  int? lastPage;
  int? total;
  String? nextPageUrl;
  List<T>? data;

  Paginated({
    this.currentPage,
    this.lastPage,
    this.total,
    this.nextPageUrl,
    this.data,
  });

  factory Paginated.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$PaginatedFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$PaginatedToJson(this, toJsonT);
}

@JsonSerializable()
class AppCountry {
  int id;
  String name;
  String? countryCode2;
  String? countryCode3;
  String? coinCode;
  int? phoneCode;
  int? timezoneOffset;
  bool? isActive;
  int? isPickup;
  int? isDeposit;

  AppCountry({
    required this.id,
    required this.name,
    this.countryCode2,
    this.countryCode3,
    this.coinCode,
    this.phoneCode,
    this.timezoneOffset,
    this.isActive,
    this.isPickup,
    this.isDeposit,
  });

  factory AppCountry.fromJson(Map<String, dynamic> json) => _$AppCountryFromJson(json);

  Map<String, dynamic> toJson() => _$AppCountryToJson(this);
}
