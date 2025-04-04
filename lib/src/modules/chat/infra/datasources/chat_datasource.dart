import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';

abstract class ChatDataSource {
  Future<void> addMessage(ChatEntity message);
  Stream<List<ChatEntity>> getMessagesStream();
}
