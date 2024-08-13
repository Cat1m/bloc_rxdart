import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {
  factory User({
    @Default(0) int id,
    @Default("") String name,
    @Default("") String username,
    @Default("") String email,
    required AddressModel address,
    @Default("") String phone,
    @Default("") String website,
    required CompanyModel company,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
abstract class AddressModel with _$AddressModel {
  factory AddressModel({
    @Default("") String street,
    @Default("") String suite,
    @Default("") String city,
    @Default("") String zipcode,
    required GeoModel geo,
  }) = _AddressModel;
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@freezed
abstract class GeoModel with _$GeoModel {
  factory GeoModel({
    @Default("") String lat,
    @Default("") String lng,
  }) = _GeoModel;
  factory GeoModel.fromJson(Map<String, dynamic> json) =>
      _$GeoModelFromJson(json);
}

@freezed
abstract class CompanyModel with _$CompanyModel {
  factory CompanyModel({
    @Default("") String name,
    @Default("") String catchPhrase,
    @Default("") String bs,
  }) = _CompanyModel;
  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
}
