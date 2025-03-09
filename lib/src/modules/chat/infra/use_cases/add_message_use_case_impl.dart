import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';
import 'package:pet_adoption/src/modules/chat/domain/repositories/chat_repository.dart';
import 'package:pet_adoption/src/modules/chat/domain/use_cases/add_message_use_case.dart';

class AddMessageUseCaseImpl  implements AddMessageUseCase{
  final ChatRepository repository;

  AddMessageUseCaseImpl({required this.repository});

  
  
  @override
  Future<void> addMessage(ChatEntity message) {
    return repository.addMessage(message);
  }
}
