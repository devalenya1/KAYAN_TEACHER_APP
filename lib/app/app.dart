import 'package:eschool_teacher/app/appLocalization.dart';
import 'package:eschool_teacher/app/routes.dart';
import 'package:eschool_teacher/cubits/localization/appLocalizationCubit.dart';
import 'package:eschool_teacher/ui/styles/colors.dart';
import 'package:eschool_teacher/utils/constants.dart';
import 'package:eschool_teacher/utils/uiUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //await Hive.initFlutter();

  runApp(MyApp());
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //preloading some of the imaegs
    precacheImage(
        AssetImage(UiUtils.getImagePath("upper_pattern.png")), context);

    precacheImage(
        AssetImage(UiUtils.getImagePath("lower_pattern.png")), context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppLocalizationCubit>(
            create: (_) => AppLocalizationCubit()),
      ],
      child: Builder(builder: (context) {
        final currentLanguage =
            context.watch<AppLocalizationCubit>().state.language;
        return MaterialApp(
          theme: Theme.of(context).copyWith(
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
              scaffoldBackgroundColor: pageBackgroundColor,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: primaryColor,
                    onPrimary: onPrimaryColor,
                    secondary: secondaryColor,
                    background: backgroundColor,
                    error: errorColor,
                    onSecondary: onSecondaryColor,
                    onBackground: onBackgroundColor,
                  )),
          builder: (context, widget) {
            return ScrollConfiguration(
                behavior: GlobalScrollBehavior(), child: widget!);
          },
          locale: currentLanguage,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: supporatedLocales.map((languageCode) {
            return UiUtils.getLocaleFromLanguageCode(languageCode);
          }).toList(),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splash,
          onGenerateRoute: Routes.onGenerateRouted,
        );
      }),
    );
  }
}
