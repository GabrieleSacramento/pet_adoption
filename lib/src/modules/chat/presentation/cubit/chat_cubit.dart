import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/src/modules/chat/domain/entities/chat_entity.dart';
import 'package:pet_adoption/src/modules/chat/domain/use_cases/add_message_use_case.dart';
import 'package:pet_adoption/src/modules/chat/domain/use_cases/get_messages_strem_use_case.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final AddMessageUseCase addMessageUseCase;
  final GetMessagesStreamUseCase getMessagesStreamUseCase;
  String currentMessage = '';
  ChatCubit({required this.addMessageUseCase,required this.getMessagesStreamUseCase}) : super(ChatInitial()) {
    loadMessages();
  }

  void loadMessages() {
    try {
      emit(ChatLoading());
      getMessagesStreamUseCase().listen((messages) {
        emit(ChatMessages(messages: messages));
      }).onError((error) {
        emit(ChatError(error.toString()));
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void addMessage(ChatEntity chatEntity) async {
    try {
      emit(ChatLoading());
      await addMessageUseCase.addMessage(chatEntity);
      emit(
        ChatMessages(
          messages: [
            chatEntity,
          ],
        ),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void updateCurrentMessage(String message) {
    currentMessage = message;
  }

  Stream<List<ChatEntity>> get messagesStream => getMessagesStreamUseCase();
}
