import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../cubit/chat_cubit.dart';
import '../../domain/entities/chat_entity.dart';
import '../../../../utils/widgets/custom_app_bar.dart';

class PetAdoptionChatPage extends StatefulWidget {
  const PetAdoptionChatPage({super.key});

  @override
  State<PetAdoptionChatPage> createState() => _PetAdoptionChatPageState();
}

class _PetAdoptionChatPageState extends State<PetAdoptionChatPage> {
  final chatController = TextEditingController();
  final ChatCubit _chatCubit = GetIt.instance.get<ChatCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => _chatCubit,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(241, 152, 69, 1),
            appBar: CustomAppBar(
              appBarTitle: 'Luciana',
              isBackButtonVisible: true,
              onBackButtonPressed: () => Navigator.pop(context),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        if (state is ChatError) {
                          return const Center(
                              child:
                                  Text('Não foi possível exibir as mensagens'));
                        }
                        if (state is ChatLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is ChatMessages) {
                          return StreamBuilder<List<ChatEntity>>(
                            stream: _chatCubit.messagesStream,
                            builder: (context, snapshot) {
                              final messages = snapshot.data ?? [];
                              return ListView.builder(
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 16.w),
                                    margin: EdgeInsets.only(
                                        top: 16.h,
                                        left: 16.w,
                                        right: 62.w,
                                        bottom: 16.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          245, 245, 245, 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                    ),
                                    child: Text(
                                      messages[index].message,
                                      style: TextStyle(
                                        fontSize: 16.h,
                                        color:
                                            const Color.fromRGBO(82, 82, 82, 1),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
                _InputChatWidget(
                  chatController: chatController,
                  onSendMessage: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null && chatController.text.isNotEmpty) {
                      final message = ChatEntity(
                        message: chatController.text,
                        userName: user.email ?? "Usuário",
                        createdAt: DateTime.now(),
                      );
                      _chatCubit.addMessage(message);
                      chatController.clear();
                    }
                  },
                  onChanged: (value) {
                    _chatCubit.updateCurrentMessage(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputChatWidget extends StatelessWidget {
  const _InputChatWidget({
    required this.chatController,
    required this.onSendMessage,
    required this.onChanged,
  });

  final TextEditingController chatController;
  final Function() onSendMessage;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: TextFormField(
        onChanged: onChanged,
        controller: chatController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Digite sua mensagem',
          suffixIcon: IconButton(
            onPressed: onSendMessage,
            icon: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: const Icon(Icons.send),
            ),
          ),
          suffixIconColor: const Color.fromRGBO(241, 152, 69, 1),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.h),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 1.w,
              color: const Color.fromRGBO(241, 152, 69, 1),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: 1.w,
              color: Colors.redAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.w,
              color: const Color.fromRGBO(37, 41, 84, 0.15),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: TextStyle(
            fontSize: 16.h,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
