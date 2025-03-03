import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/repositories/upload_pet_info_repository.dart';
import 'package:pet_adoption/src/modules/register_pet/infra/datasources/upload_pet_info_datasource.dart';

class UploadPetInfoRepositoryImpl implements UploadPetInfoRepository {
  final UploadPetInfoDatasource datasource;

  UploadPetInfoRepositoryImpl({required this.datasource});
  @override
  Future<UploadTask> uploadImage(String imagePath) async {
    final UploadTask uploadTask = await datasource.uploadImage(imagePath);
    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.success) {
        final String imageUrl = await event.ref.getDownloadURL();
        await datasource.savePetData(imageUrl);
      }
    });
    return uploadTask;
  }

  @override
  Future<List<PetInfoEntity>> fetchPetData() {
    return datasource.fetchPetData();
  }
}
