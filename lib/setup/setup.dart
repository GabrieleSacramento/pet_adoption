import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption/src/modules/Auth/domain/repositories/user_authentication_repository.dart';
import 'package:pet_adoption/src/modules/Auth/domain/use_cases/user_authentication_use_case.dart';
import 'package:pet_adoption/src/modules/Auth/external/datasource/user_authentication_datasource_impl.dart';
import 'package:pet_adoption/src/modules/Auth/infra/datasource/user_authentication_datasource.dart';
import 'package:pet_adoption/src/modules/Auth/infra/repositories/user_authentication_repository_impl.dart';
import 'package:pet_adoption/src/modules/Auth/infra/use_cases/user_authentication_use_case_impl.dart';
import 'package:pet_adoption/src/modules/Auth/presentation/cubit/user_authentication_cubit.dart';
import 'package:pet_adoption/src/modules/chat/domain/repositories/chat_repository.dart';
import 'package:pet_adoption/src/modules/chat/domain/use_cases/add_message_use_case.dart';
import 'package:pet_adoption/src/modules/chat/domain/use_cases/get_messages_strem_use_case.dart';
import 'package:pet_adoption/src/modules/chat/external/datasources/chat_datasource_impl.dart';
import 'package:pet_adoption/src/modules/chat/infra/datasources/chat_datasource.dart';
import 'package:pet_adoption/src/modules/chat/infra/repositories/chat_repository_impl.dart';
import 'package:pet_adoption/src/modules/chat/infra/use_cases/add_message_use_case_impl.dart';
import 'package:pet_adoption/src/modules/chat/infra/use_cases/get_message_use_case_impl.dart';
import 'package:pet_adoption/src/modules/chat/presentation/cubit/chat_cubit.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/entities/pet_info_entity.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/repositories/upload_pet_info_repository.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/use_cases/add_pet_information_use_case.dart';
import 'package:pet_adoption/src/modules/register_pet/domain/use_cases/upload_pet_info_use_case.dart';
import 'package:pet_adoption/src/modules/register_pet/external/datasources/upload_pet_info_datasource_impl.dart';
import 'package:pet_adoption/src/modules/register_pet/infra/datasources/upload_pet_info_datasource.dart';
import 'package:pet_adoption/src/modules/register_pet/infra/repositories/upload_pet_info_repository_impl.dart';
import 'package:pet_adoption/src/modules/register_pet/infra/use_cases/upload_pet_info_use_case_impl.dart';
import 'package:pet_adoption/src/modules/register_pet/presentation/cubit/add_pet_info_cubit.dart';
import 'package:pet_adoption/src/modules/register_pet/presentation/cubit/get_pet_info_cubit.dart';

Dio dio = Dio();

final setup = GetIt.instance;

Future<void> registerDependencies() async {
  setupDatasources();
  setupRepositories();
  setupUseCases();
  setupCubits();
  setupEntities();
}

void setupDatasources() {
  setup.registerFactory<UserAuthenticationDatasource>(
    () => UserAuthenticationDatasourceImpl(),
  );
  setup.registerFactory<UploadPetInfoDatasource>(
    () => UploadPetInfoDatasourceImpl(
      storage: GetIt.I.get<FirebaseStorage>(),
      databaseReference: GetIt.I.get<DatabaseReference>(),
    ),
  );

  setup.registerFactory<ChatDataSource>(
    () => ChatDataSourceImpl(
      firestore: GetIt.I.get<FirebaseFirestore>(),
    ),
  );

  setup.registerFactory<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}

void setupRepositories() {
  setup.registerFactory<UserAuthenticationRepository>(
    () => UserAuthenticationRepositoryImpl(
      datasource: GetIt.I.get<UserAuthenticationDatasource>(),
    ),
  );
  setup.registerFactory<UploadPetInfoRepository>(
    () => UploadPetInfoRepositoryImpl(
      datasource: GetIt.I.get<UploadPetInfoDatasource>(),
    ),
  );

  setup.registerFactory<ChatRepository>(
    () => ChatRepositoryImpl(
      dataSource: GetIt.I.get<ChatDataSource>(),
    ),
  );
}

void setupUseCases() {
  setup.registerFactory<UserAuthenticationUseCase>(
    () => UserAuthenticationUseCaseImpl(
      repository: GetIt.I.get<UserAuthenticationRepository>(),
    ),
  );

  setup.registerFactory<AddPetInformationUseCase>(
    () => AddPetInformationUseCase(
      petInfoEntity: GetIt.I.get<PetInfoEntity>(),
    ),
  );

  setup.registerFactory<UploadPetInfoUseCase>(
    () => UploadPetInfoUseCaseImpl(
      repository: GetIt.I.get<UploadPetInfoRepository>(),
    ),
  );
  setup.registerFactory<AddMessageUseCase>(
    () => AddMessageUseCaseImpl(
      repository: GetIt.I.get<ChatRepository>(),
    ),
  );
  setup.registerFactory<GetMessagesStreamUseCase>(
    () => GetMessagesStreamUseCaseImpl(
      repository: GetIt.I.get<ChatRepository>(),
    ),
  );
}

void setupCubits() {
  setup.registerFactory<UserAuthenticationCubit>(
    () => UserAuthenticationCubit(
      userAuthenticationUseCase: GetIt.I.get<UserAuthenticationUseCase>(),
    ),
  );

  setup.registerFactory<AddPetInfoCubit>(
    () => AddPetInfoCubit(
      addPetInformationUseCase: GetIt.I.get<AddPetInformationUseCase>(),
    ),
  );
  setup.registerFactory<GetPetInfoCubit>(
    () => GetPetInfoCubit(
      uploadPetInfoUseCase: GetIt.I.get<UploadPetInfoUseCase>(),
    ),
  );

  setup.registerFactory<ImagePicker>(() => ImagePicker());
  setup.registerFactory<FirebaseStorage>(
    () => FirebaseStorage.instance,
  );
  setup.registerFactory<DatabaseReference>(
    () => FirebaseDatabase.instance.ref(),
  );
  setup.registerFactory<ChatCubit>(
    () => ChatCubit(
      addMessageUseCase: GetIt.I.get<AddMessageUseCase>(),
      getMessagesStreamUseCase: GetIt.I.get<GetMessagesStreamUseCase>(),
    ),
  );
}

void setupEntities() {
  setup.registerFactory<PetInfoEntity>(
    () => PetInfoEntity(
      name: '',
      race: '',
      age: '',
      description: '',
      imageUrl: '',
      sex: '',
      weight: '',
      localization: '',
    ),
  );
}
