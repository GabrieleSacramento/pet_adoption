import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<void> addMessage(ChatEntity message);
  Stream<List<ChatEntity>> getMessagesStream();
  
}
