import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:gpttask/screen/splash/splashscreen.dart';
import 'package:gpttask/shared/providers/chatsprovider.dart';
import 'package:gpttask/shared/providers/onboardingprovider.dart';
import 'package:gpttask/shared/style/enum/enum.dart';
import 'package:gpttask/shared/style/themes.dart';

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
          return Consumer<ChatsProvider>(
            builder: (context, chatsProvider, child) {
              return MaterialApp(
                title: 'Task',
                theme: getThemeData[chatsProvider.currentTheme], // Apply dynamic theme
                darkTheme: getThemeData[AppTheme.darkTheme],     // Dark theme
                themeMode: ThemeMode.system,                    // Use system mode (can be dynamic)
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
