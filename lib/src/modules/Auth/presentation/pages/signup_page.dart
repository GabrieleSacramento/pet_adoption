import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';
import 'package:pet_adoption/src/modules/Auth/presentation/cubit/user_authentication_cubit.dart';
import 'package:pet_adoption/src/modules/home/presentation/pages/pet_adoption_home_page.dart';
import 'package:pet_adoption/src/utils/widgets/custom_app_bar.dart';
import 'package:pet_adoption/src/utils/widgets/custom_button.dart';
import 'package:pet_adoption/src/utils/widgets/custom_form.dart';
import 'package:pet_adoption/src/utils/widgets/loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:string_validator/string_validator.dart' as validator;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final signupCubit = GetIt.I.get<UserAuthenticationCubit>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearForm() {
    _formKey.currentState?.reset();
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          appBarTitle: 'Criar conta',
          isBackButtonVisible: true,
          onBackButtonPressed: () => Navigator.pop(context),
        ),
        body: BlocProvider(
            create: (context) => signupCubit,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 32.w,
                        top: 24.h,
                        bottom: 32.h,
                      ),
                      child: Column(
                        children: [
                          CustomForm(
                            obscurePassword: false,
                            hintText: 'Nome',
                            controller: nameController,
                            label: 'Nome',
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Este campo precisa ser preenchido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomForm(
                            obscurePassword: false,
                            hintText: 'Sobrenome',
                            controller: lastNameController,
                            label: 'Sobrenome',
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Este campo precisa ser preenchido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomForm(
                            obscurePassword: false,
                            hintText: 'Email',
                            controller: emailController,
                            label: 'Email',
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Este campo precisa ser preenchido';
                              }
                              if (!validator.isEmail(text)) {
                                return 'Email inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomForm(
                            obscurePassword: isPasswordVisible,
                            hintText: 'Senha',
                            controller: passwordController,
                            label: 'Senha',
                            suffixIcon: GestureDetector(
                              onTap: () => setState(
                                  () => isPasswordVisible = !isPasswordVisible),
                              child: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Este campo precisa ser preenchido';
                              }
                              if (text.length < 8) {
                                return 'A senha deve conter no mínimo 8 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocConsumer<UserAuthenticationCubit,
                          UserAuthenticationState>(
                        listener: (context, state) async {
                          if (state is UserAuthenticationError) {
                            showActionSnackBar(context);
                          }
                          if (state is UserAuthenticationSuccess) {
                            final userName = nameController.text;
                            final email = emailController.text;

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('userName_$email', userName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetAdoptionHomePage(
                                  userName: nameController.text,
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is UserAuthenticationLoading) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: 24.w,
                                right: 24.w,
                                bottom: 32.h,
                              ),
                              child: const LoadingButton(
                                isLarge: true,
                              ),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 24.w,
                              right: 24.w,
                              bottom: 32.h,
                            ),
                            child: CustomButton(
                              textButton: 'Criar conta',
                              onPressed: () {
                                nameController.text;
                                if (_formKey.currentState!.validate()) {
                                  signupCubit.signUp(
                                    UserAuthenticationEntity(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              isLarge: true,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void showActionSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Não foi possivel realizar o cadastro',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
