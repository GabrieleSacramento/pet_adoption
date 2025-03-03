import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/widgets/custom_app_bar.dart';

class PetAdoptionChatPage extends StatefulWidget {
  const PetAdoptionChatPage({super.key});

  @override
  State<PetAdoptionChatPage> createState() => _PetAdoptionChatPageState();
}

class _PetAdoptionChatPageState extends State<PetAdoptionChatPage> {
  final chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(241, 152, 69, 1),
            appBar: const CustomAppBar(
              appBarTitle: 'Luciana',
              isBackButtonVisible: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: true,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: Container(
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
                                            'Olá, tenho interesse em adotar o paçoca',
                                            style: TextStyle(
                                              fontSize: 16.h,
                                              color: const Color.fromRGBO(
                                                  82, 82, 82, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.h, horizontal: 16.w),
                                          margin: EdgeInsets.only(
                                              top: 16.h,
                                              left: 62.w,
                                              right: 16.w,
                                              bottom: 16.h),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                254, 184, 119, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.r),
                                            ),
                                          ),
                                          child: Text(
                                            'Oii tudo bom, me fala um pouco mais sobre você?',
                                            style: TextStyle(
                                              fontSize: 16.h,
                                              color: const Color.fromRGBO(
                                                  82, 82, 82, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              _InputChatWidget(chatController: chatController),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class _InputChatWidget extends StatelessWidget {
  const _InputChatWidget({
    required this.chatController,
  });

  final TextEditingController chatController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: TextFormField(
        controller: chatController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Digite sua mensagem',
          suffixIcon: IconButton(
            onPressed: () {
              chatController.clear();
            },
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
