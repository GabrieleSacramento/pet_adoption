part of 'add_pet_info_cubit.dart';

@immutable
sealed class AddPetInfoState {}

final class AddPetInfoInitial extends AddPetInfoState {}

final class AddPetInfoLoading extends AddPetInfoState {}

final class AddPetInfoSuccess extends AddPetInfoState {
  final String imagePath;

  AddPetInfoSuccess({required this.imagePath});
}

final class AddPetInfoError extends AddPetInfoState {
  final String message;

  AddPetInfoError({required this.message});
}
