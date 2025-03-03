import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';
import 'package:pet_adoption/src/modules/register_pet/infra/datasources/upload_pet_info_datasource.dart';

class UploadPetInfoDatasourceImpl implements UploadPetInfoDatasource {
  final FirebaseStorage storage;
  final DatabaseReference databaseReference;

  UploadPetInfoDatasourceImpl({
    required this.storage,
    required this.databaseReference,
  });
  @override
  Future<UploadTask> uploadImage(String imagePath) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = storage.ref('images/$fileName');
    final uploadTask = ref.putFile(File(imagePath));
    return uploadTask;
  }

  @override
  Future<void> savePetData(String imageUrl) async {
    await databaseReference.child('pet-informations').push().set({
      'imageUrl': imageUrl,
    });
  }

  @override
  Future<List<PetInfoEntity>> fetchPetData() async {
    firestore.Query petInfo = FirebaseFirestore.instance
        .collection('pet-informations')
        .orderBy('name')
        .limit(10);

    List<DocumentSnapshot> documentSnapshots =
        await petInfo.get().then((snapshot) => snapshot.docs);

    return documentSnapshots.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return PetInfoEntity.fromMap(data);
    }).toList();
  }
}
