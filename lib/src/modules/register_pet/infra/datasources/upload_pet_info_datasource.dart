import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';

abstract class UploadPetInfoDatasource {
  Future<UploadTask> uploadImage(String imagePath);
  Future<void> savePetData(String imageUrl);
  Future<List<PetInfoEntity>> fetchPetData();
}
