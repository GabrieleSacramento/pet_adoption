// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetInfoEntity _$PetInfoEntityFromJson(Map<String, dynamic> json) =>
    PetInfoEntity(
      race: json['race'] as String?,
      age: json['age'] as String?,
      description: json['description'] as String?,
      weight: json['weight'] as String?,
      imageUrl: json['imageUrl'] as String,
      sex: json['sex'] as String,
      localization: json['localization'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PetInfoEntityToJson(PetInfoEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'race': instance.race,
      'age': instance.age,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'sex': instance.sex,
      'weight': instance.weight,
      'localization': instance.localization,
    };
