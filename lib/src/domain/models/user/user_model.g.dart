// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? "",
      username: json['username'] as String? ?? "",
      email: json['email'] as String? ?? "",
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String? ?? "",
      website: json['website'] as String? ?? "",
      company: CompanyModel.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'website': instance.website,
      'company': instance.company,
    };

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      street: json['street'] as String? ?? "",
      suite: json['suite'] as String? ?? "",
      city: json['city'] as String? ?? "",
      zipcode: json['zipcode'] as String? ?? "",
      geo: GeoModel.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };

_$GeoModelImpl _$$GeoModelImplFromJson(Map<String, dynamic> json) =>
    _$GeoModelImpl(
      lat: json['lat'] as String? ?? "",
      lng: json['lng'] as String? ?? "",
    );

Map<String, dynamic> _$$GeoModelImplToJson(_$GeoModelImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      name: json['name'] as String? ?? "",
      catchPhrase: json['catchPhrase'] as String? ?? "",
      bs: json['bs'] as String? ?? "",
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };
