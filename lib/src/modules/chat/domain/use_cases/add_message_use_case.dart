import '../entities/chat_entity.dart';

abstract class AddMessageUseCase {
  Future<void> addMessage(ChatEntity message);
}
