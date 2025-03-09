import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';

abstract class GetMessagesStreamUseCase {
  Stream<List<ChatEntity>> call();
}