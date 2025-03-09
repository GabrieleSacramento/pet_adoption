import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';
import 'package:pet_adoption/src/modules/chat/domain/repositories/chat_repository.dart';
import 'package:pet_adoption/src/modules/chat/domain/use_cases/get_messages_strem_use_case.dart';

class GetMessagesStreamUseCaseImpl implements GetMessagesStreamUseCase {
  final ChatRepository repository;

  GetMessagesStreamUseCaseImpl({required this.repository});
@override
  Stream<List<ChatEntity>> call() {
    return repository.getMessagesStream();
  }
}