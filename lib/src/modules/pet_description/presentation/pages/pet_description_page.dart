import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_adoption/src/modules/chat/presentation/pages/pet_adoption_chat_page.dart';
import 'package:pet_adoption/src/modules/home/presentation/pages/pet_adoption_home_page.dart';
import 'package:pet_adoption/src/utils/widgets/custom_button.dart';

import '../../../../utils/widgets/custom_app_bar.dart';

class PetDescriptionPage extends StatelessWidget {
  final String petName;
  final String petRace;
  final String petAge;
  final String petDescription;
  final String petImageUrl;
  final String petSex;
  final String petWeight;
  final String petLocalization;
  const PetDescriptionPage({
    super.key,
    required this.petRace,
    required this.petWeight,
    required this.petAge,
    required this.petDescription,
    required this.petImageUrl,
    required this.petSex,
    required this.petName,
    required this.petLocalization,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          appBarTitle: 'Sobre o pet',
          isBackButtonVisible: true,
          onBackButtonPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PetAdoptionHomePage())),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                child: Image.file(
                  File(petImageUrl),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        petName,
                        style: TextStyle(
                          fontSize: 32.h,
                          color: const Color.fromRGBO(241, 152, 69, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, bottom: 32.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: const Color.fromRGBO(241, 152, 69, 1),
                            size: 20.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                              petLocalization,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(86, 77, 77, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        PetInfoCardWidget(
                          title: 'Raça',
                          subtitle: petRace,
                        ),
                        PetInfoCardWidget(
                          title: 'Idade',
                          subtitle: petAge,
                        ),
                        PetInfoCardWidget(
                          title: 'Peso',
                          subtitle: petWeight,
                        ),
                        PetInfoCardWidget(
                          title: 'Sexo',
                          subtitle: petSex,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h, bottom: 8.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                            fontSize: 20.h,
                            color: const Color.fromRGBO(241, 152, 69, 1),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        petDescription,
                        style: TextStyle(
                          fontSize: 14.h,
                          color: const Color.fromRGBO(86, 83, 83, 1),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 16.h, bottom: 16.h, left: 56.h, right: 56.h),
                        child: CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PetAdoptionChatPage(),
                              ),
                            );
                          },
                          textButton: 'Adote um amigo',
                          isLarge: true,
                          isTOShowIcon: true,
                          iconButton: Icons.pets_outlined,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PetInfoCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const PetInfoCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Container(
        height: 76.h,
        width: 76.w,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(
            color: const Color.fromRGBO(241, 152, 69, 1),
            width: 2.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(166, 160, 160, 1),
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(86, 83, 83, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
