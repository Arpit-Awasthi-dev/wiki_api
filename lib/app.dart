import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection_container.dart' as di;
import 'core/navigation/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';

import 'core/bloc_providers.dart';
import 'core/navigation/routers.dart';
import 'presentation/pages/wiki_list_page/wiki_list_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  _MyAppState();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: BlocProviders.toGenerateProviders(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            home: const WikiListPage(),
            navigatorKey: di.sl<NavigationService>().navigatorKey,
            onGenerateRoute: (settings) =>
                Routers.toGenerateRoute(settings),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: Translations.localizationsDelegates,
            supportedLocales: Translations.supportedLocales,
          );
        },
      ),
    );
  }
}