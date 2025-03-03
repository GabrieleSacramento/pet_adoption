part of 'get_pet_info_cubit.dart';

@immutable
abstract class GetPetInfoState extends Equatable {
  final List<PetInfoEntity> petInfoEntity;
  const GetPetInfoState({this.petInfoEntity = const []});

  @override
  List<Object> get props => [petInfoEntity];
}

final class GetPetInfoInitial extends GetPetInfoState {}

final class GetPetInfoLoading extends GetPetInfoState {}

final class GetPetInfoSuccess extends GetPetInfoState {
  @override
  final List<PetInfoEntity> petInfoEntity;

  const GetPetInfoSuccess({required this.petInfoEntity});
}

final class GetPetInfoError extends GetPetInfoState {
  final String message;

  const GetPetInfoError({required this.message});
}

final class ImageUploaded extends GetPetInfoState {
  final String imageUrl;

  const ImageUploaded({required this.imageUrl});
}

final class UploadImageLoading extends GetPetInfoState {}
