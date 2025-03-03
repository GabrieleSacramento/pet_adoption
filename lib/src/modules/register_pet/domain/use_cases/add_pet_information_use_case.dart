import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';

class AddPetInformationUseCase {
  final PetInfoEntity petInfoEntity;

  CollectionReference petInfo =
      FirebaseFirestore.instance.collection('pet-informations');

  AddPetInformationUseCase({
    required this.petInfoEntity,
  });

  Future<void> addPetInformation(PetInfoEntity petInfoEntity) {
    return petInfo.add(
      petInfoEntity.toJson(),
    );
  }
}
