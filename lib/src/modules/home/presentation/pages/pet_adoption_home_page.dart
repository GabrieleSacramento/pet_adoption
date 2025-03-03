import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_adoption/src/modules/pet_description/presentation/pages/pet_description_page.dart';
import 'package:pet_adoption/src/modules/register_pet/presentation/cubit/get_pet_info_cubit.dart';
import 'package:pet_adoption/src/modules/register_pet/presentation/pages/pet_form_page.dart';
import 'package:pet_adoption/src/utils/widgets/custom_button.dart';

class PetAdoptionHomePage extends StatefulWidget {
  const PetAdoptionHomePage({super.key});

  @override
  State<PetAdoptionHomePage> createState() => _PetAdoptionHomePageState();
}

final GetPetInfoCubit _getPetInfoCubit = GetIt.I.get<GetPetInfoCubit>();
final ScrollController _scrollController = ScrollController();

class _PetAdoptionHomePageState extends State<PetAdoptionHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => _getPetInfoCubit..loadPets(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const HomePageAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  const RegisterThePetToDonateWidget(),
                  Padding(
                    padding: EdgeInsets.only(top: 32.h, bottom: 16.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Encontre um amigo',
                        style: TextStyle(
                          fontSize: 20.h,
                          color: const Color.fromRGBO(86, 83, 83, 1),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<GetPetInfoCubit, GetPetInfoState>(
                    builder: (context, state) {
                      if (state is GetPetInfoLoading &&
                          state.petInfoEntity.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is GetPetInfoSuccess) {
                        final petInfoEntity = state.petInfoEntity;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 32.h),
                          child: GridView.builder(
                            itemCount: petInfoEntity.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.7,
                              crossAxisCount: 2,
                              mainAxisSpacing: 16.w,
                              crossAxisSpacing: 16.h,
                            ),
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              if (index >= petInfoEntity.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ChooseAPetToAdoptWidget(
                                petName: state.petInfoEntity[index].name,
                                petSex: state.petInfoEntity[index].sex,
                                petLocalization:
                                    state.petInfoEntity[index].localization,
                                petImageUrl:
                                    state.petInfoEntity[index].imageUrl,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PetDescriptionPage(
                                        petImageUrl:
                                            state.petInfoEntity[index].imageUrl,
                                        petSex: state.petInfoEntity[index].sex,
                                        petName:
                                            state.petInfoEntity[index].name,
                                        petLocalization: state
                                            .petInfoEntity[index].localization,
                                        petAge: state.petInfoEntity[index].age!,
                                        petRace:
                                            state.petInfoEntity[index].race!,
                                        petWeight:
                                            state.petInfoEntity[index].weight!,
                                        petDescription: state
                                            .petInfoEntity[index].description!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                      if (state is GetPetInfoError) {
                        return const Center(
                          child: Text('Erro ao buscar informações'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseAPetToAdoptWidget extends StatelessWidget {
  final String petName;
  final String petSex;
  final String petLocalization;
  final String petImageUrl;
  final Function()? onPressed;

  const ChooseAPetToAdoptWidget({
    super.key,
    required this.petName,
    required this.petSex,
    required this.petLocalization,
    required this.petImageUrl,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 191.h,
        width: 171.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: const Color.fromRGBO(241, 152, 69, 1),
              ),
              child: Image.file(
                File(petImageUrl),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.h, top: 8.h, right: 8.h),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            petName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(86, 83, 83, 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Flexible(
                            child: Text(
                              '($petSex)',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(86, 77, 77, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: const Color.fromRGBO(241, 152, 69, 1),
                        size: 16.sp,
                      ),
                      Builder(builder: (context) {
                        return Flexible(
                          child: Text(
                            petLocalization,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(86, 77, 77, 1),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterThePetToDonateWidget extends StatelessWidget {
  const RegisterThePetToDonateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 112.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/pets.png'),
              alignment: Alignment.centerRight,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Deseja doar um pet?',
                      style: TextStyle(
                        fontSize: 20.h,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomButton(
                      textButton: 'Clique aqui',
                      isLarge: false,
                      buttonColor: const Color.fromRGBO(255, 255, 255, 1),
                      textButtonColor: const Color.fromRGBO(241, 152, 69, 1),
                      textButtonSize: 16.h,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PetForm(),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      toolbarHeight: 80.h,
      title: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Amigo peludo',
              style: TextStyle(
                fontSize: 20.h,
                color: const Color.fromRGBO(241, 152, 69, 1),
              ),
            ),
            const CircleAvatar(
              // backgroundImage: AssetImage(''),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
