import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_adoption/src/modules/Auth/domain/entities/user_authentication_entity.dart';
import 'package:pet_adoption/src/modules/Auth/presentation/cubit/user_authentication_cubit.dart';
import 'package:pet_adoption/src/modules/home/presentation/pages/pet_adoption_home_page.dart';
import 'package:pet_adoption/src/utils/widgets/custom_app_bar.dart';
import 'package:pet_adoption/src/utils/widgets/custom_button.dart';
import 'package:pet_adoption/src/utils/widgets/custom_form.dart';
import 'package:pet_adoption/src/utils/widgets/loading_button.dart';
import 'package:string_validator/string_validator.dart' as validator;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final _loginCubit = GetIt.I.get<UserAuthenticationCubit>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearForm() {
    _formKey.currentState?.reset();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginCubit,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(
              appBarTitle: 'Login',
              isBackButtonVisible: true,
              backgroundColor: Colors.white,
              appBarTitleColor: const Color.fromRGBO(241, 152, 69, 1),
              appBarIconColor: const Color.fromRGBO(241, 152, 69, 1),
              onBackButtonPressed: () => Navigator.pop(context),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 32.w,
                      top: 24.h,
                      bottom: 32.h,
                    ),
                    child: Column(
                      children: [
                        Lottie.asset('assets/animations/login_animation.json'),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomForm(
                                controller: emailController,
                                obscurePassword: false,
                                hintText: 'Email',
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
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 16.h, bottom: 24.h),
                                child: CustomForm(
                                  obscurePassword: isPasswordVisible,
                                  hintText: 'Senha',
                                  controller: passwordController,
                                  label: 'Senha',
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() =>
                                        isPasswordVisible = !isPasswordVisible),
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

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                        listener: (context, state) {
                          if (state is UserAuthenticationError) {
                            showActionSnackBar(context);
                          }

                          if (state is UserAuthenticationSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PetAdoptionHomePage(),
                              ),
                            );
                            clearForm();
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
                              textButton: 'Entrar',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _loginCubit.signIn(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showActionSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text(
        'Não foi possivel realizar o cadastro',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromRGBO(241, 152, 69, 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
