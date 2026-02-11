import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_clean_architecture_riverpod/l10n/app_localizations.dart'; // Import generated localizations

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';

class BaseApplication extends ConsumerWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const BaseApplication({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Initialize ScreenUtilInit FIRST, before accessing any theme that uses .sp/.w/.h
    return ScreenUtilInit(
      designSize: const Size(428, 926), // Reference design size
      minTextAdapt: true,
      splitScreenMode: true,
      // 2. The builder gives us the context where ScreenUtil is ready
      builder: (context, child) {
        // 3. NOW we can watch the theme, because ScreenUtil is initialized
        final goRouter = ref.watch(appRouterProvider);
        final theme = ref.watch(lightThemeProvider);
        // final darkTheme = ref.watch(darkThemeProvider);

        return MaterialApp.router(
          title: 'Flutter Riverpod Template',
          theme: theme,
          // darkTheme: darkTheme, // enable when ready
          themeMode: ThemeMode.light, // force light for now
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,

          // Localization Setup
          localizationsDelegates: [
            AppLocalizations.delegate, // Add this
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          locale: const Locale('ar'), // Default to Arabic for testing
        );
      },
    );
  }
}
