import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_adoption/generated/app_localizations.dart';
import 'package:pet_adoption/src/modules/Auth/presentation/cubit/user_authentication_cubit.dart';
import 'package:pet_adoption/src/modules/Auth/presentation/pages/login_method_selection_page.dart';
import 'package:pet_adoption/src/modules/home/presentation/pages/pet_adoption_home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => BlocProvider(
        create: (context) =>
            GetIt.I.get<UserAuthenticationCubit>()..checkAuthentication(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt', ''), // Portuguese
              // Other locales...
            ],
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context).appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            home: BlocBuilder<UserAuthenticationCubit, UserAuthenticationState>(
              builder: (context, state) {
                if (state is UserAuthenticationSuccess) {
                  return const PetAdoptionHomePage();
                } else {
                  return const LoginMethodSelectionPage();
                }
              },
            )),
      ),
    );
  }
}
