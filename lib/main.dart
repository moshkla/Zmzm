import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zmzm/layout/cubit/cubit.dart';
import 'package:zmzm/layout/home_layout.dart';
import 'package:zmzm/modules/on_boarding/on_boarding_screen.dart';

import 'package:zmzm/shared/bloc_observer.dart';
import 'package:zmzm/shared/components/constants.dart';
import 'package:zmzm/shared/cubit/cubit.dart';
import 'package:zmzm/shared/cubit/states.dart';
import 'package:zmzm/shared/network/local/cashe_helper.dart';
import 'package:zmzm/shared/network/remote/dio_helper.dart';
import 'package:zmzm/shared/styles/themes.dart';

import 'modules/login/shop_login_screen.dart';

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  bool isDark = false;
  //CasheHelper.getData(key: 'isDark');
  Widget widget;
  bool onBoarding =CasheHelper.getData(key: 'onBoarding');
    token =CasheHelper.getData(key: 'token');
  if(onBoarding != null){
    if(token != null){
      widget=ShopLayout();
    }else {
      widget=ShopLoginScreen();
    }
  }else{
    widget= OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
        startScreen: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startScreen;

  MyApp({required this.isDark, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) =>
        ShopCubit()..getHomeData()
          ..getCategoriesData()
          ..getFavoritesData()..getUserData()
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
           // var cubit = AppCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              //getbool()?ThemeMode.dark:ThemeMode.light,

              home: startScreen,
            );
          }),
    );
  }
}
