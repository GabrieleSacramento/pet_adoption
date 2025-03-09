import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';
import 'package:pet_adoption/src/modules/chat/infra/datasources/chat_datasource.dart';

class ChatDataSourceImpl implements ChatDataSource {
  final FirebaseFirestore firestore;

  ChatDataSourceImpl( {required this.firestore});

  @override
  Future<void> addMessage(ChatEntity message) async {
    await firestore.collection("messages").add(message.toJson());
  }

  @override
  Stream<List<ChatEntity>> getMessagesStream() {
    
    return firestore
        .collection("messages")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatEntity.fromJson(doc.data()))
          .toList(); 
          
    });
    
  }
  
}