import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/use_cases/upload_pet_info_use_case.dart';

part 'get_pet_info_state.dart';

class GetPetInfoCubit extends Cubit<GetPetInfoState> {
  final UploadPetInfoUseCase uploadPetInfoUseCase;

  GetPetInfoCubit({
    required this.uploadPetInfoUseCase,
  }) : super(GetPetInfoInitial());

  Future<void> selectImage(String petName) async {
    try {
      final imagePicker = ImagePicker();
      final selectedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      final XFile? image = selectedFile;
      final UploadTask uploadTask =
          await uploadPetInfoUseCase.uploadImage(image!.path);
      uploadTask.snapshotEvents.listen((event) async {
        if (event.state == TaskState.running) {
          emit(UploadImageLoading());
        } else if (event.state == TaskState.success) {
          final String imageUrl = selectedFile!.path;
          emit(
            ImageUploaded(imageUrl: imageUrl),
          );
        }
      });
      await uploadTask;
    } catch (e) {
      emit(const GetPetInfoError(
          message: "Não foi possível carregar as informações dos pets."));
    }
  }

  Future<void> loadPets() async {
    try {
      emit(GetPetInfoLoading());
      final pets = await uploadPetInfoUseCase.fetchPetData();
      emit(GetPetInfoSuccess(petInfoEntity: pets));
    } catch (e) {
      emit(const GetPetInfoError(
          message: "Não foi possível carregar as informações dos pets."));
    }
  }
}
