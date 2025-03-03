import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';

abstract class UploadPetInfoUseCase {
  Future<UploadTask> uploadImage(String? imagePath);
  Future<List<PetInfoEntity>> fetchPetData();
}
