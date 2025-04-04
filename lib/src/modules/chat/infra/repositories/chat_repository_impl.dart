import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';
import 'package:pet_adoption/src/modules/chat/domain/repositories/chat_repository.dart';
import 'package:pet_adoption/src/modules/chat/infra/datasources/chat_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource dataSource;

  ChatRepositoryImpl({required this.dataSource});

  @override
  Future<void> addMessage(ChatEntity message) {
    return dataSource.addMessage(message);
  }

  @override
  Stream<List<ChatEntity>> getMessagesStream() {
    return dataSource.getMessagesStream();
  }}