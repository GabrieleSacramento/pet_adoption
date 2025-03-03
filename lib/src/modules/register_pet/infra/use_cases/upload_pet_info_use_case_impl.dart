import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/repositories/upload_pet_info_repository.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/use_cases/upload_pet_info_use_case.dart';

class UploadPetInfoUseCaseImpl implements UploadPetInfoUseCase {
  final UploadPetInfoRepository repository;

  UploadPetInfoUseCaseImpl({required this.repository});
  @override
  Future<UploadTask> uploadImage(String? imagePath) {
    return repository.uploadImage(imagePath!);
  }

  @override
  Future<List<PetInfoEntity>> fetchPetData() {
    return repository.fetchPetData();
  }
}
