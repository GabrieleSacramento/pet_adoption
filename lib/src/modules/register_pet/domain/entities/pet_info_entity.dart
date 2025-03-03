import 'package:json_annotation/json_annotation.dart';

part 'pet_info_entity.g.dart';

@JsonSerializable(createToJson: true)
class PetInfoEntity {
  final String name;
  final String? race;
  final String? age;
  final String? description;
  final String imageUrl;
  final String sex;
  final String? weight;
  final String localization;

  PetInfoEntity({
    this.race,
    this.age,
    this.description,
    this.weight,
    required this.imageUrl,
    required this.sex,
    required this.localization,
    required this.name,
  });

  factory PetInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$PetInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PetInfoEntityToJson(this);

  factory PetInfoEntity.fromMap(Map<String, dynamic> data) {
    return PetInfoEntity(
      name: data['name'],
      race: data['race'],
      age: data['age'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      sex: data['sex'],
      weight: data['weight'],
      localization: data['localization'],
    );
  }
}
