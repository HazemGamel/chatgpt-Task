import 'package:gpttask/screen/splash/splashscreen.dart';
import 'package:gpttask/shared/providers/chatsprovider.dart';
import 'package:gpttask/shared/providers/onboardingprovider.dart';
import 'package:gpttask/shared/style/enum/enum.dart';
import 'package:gpttask/shared/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnBoardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatsProvider(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: ScreenUtil.defaultSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Tqnia Task',
              theme: getThemeData[AppTheme.darkTheme],
              darkTheme: getThemeData[AppTheme.darkTheme],
              themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            );
          }),
    );
  }
}

