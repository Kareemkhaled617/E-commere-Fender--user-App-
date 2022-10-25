import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';
import 'package:test_provider/provider/map_provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/provider/provider_home.dart';
import 'package:test_provider/ui/home_services.dart';
import 'package:test_provider/ui/loading_page.dart';

import 'classes/language_constants.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runZonedGuarded(() {
        runApp(const MyApp());
      }, (dynamic error, dynamic stack) {
        developer.log("Something went wrong!", error: error, stackTrace: stack);
      }));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);


  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ProviderController()
              ..checkEnternet()
              ..getCheckFirstLogin()
              ..getAddress()
              ..getAddressName()),
        ChangeNotifierProvider(
          create: (BuildContext context) => LoginController()
            ..getSignIn()
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ProviderState()..getData('0'),
        ),
      ],
      child: MaterialApp(
        title: 'ECommerce',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale:_locale,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<ProviderController>(
          builder: (context, value, child) {
            return FutureBuilder(
              future: value.checkEnternet(),
              builder: (context, snapshot) {
                if (snapshot.data == true) {
                   value.changeLang(_locale!);
                  return const SplashScreen();
                } else {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
