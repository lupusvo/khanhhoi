import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sea_demo01/LanguageChangeProvider.dart';
import 'package:sea_demo01/generated/l10n.dart';
import 'package:sea_demo01/src/repositories/search_model.dart';
import 'repositories/bin_ding.dart';
import 'ui/compoment/splash_screen.dart';

class MyApp extends StatelessWidget {
  Color _primaryColor = HexColor('#FFC867');
  Color _accentColor = HexColor('#FF3CBD');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeProvider>(
      create: (context) => LanguageChangeProvider(),
      child: Builder(
        builder: (context) => GetMaterialApp(
          //locale: new Locale('vi'),
          locale: Provider.of<LanguageChangeProvider>(context, listen: true)
              .currentLocale,
          initialBinding: Binding(),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: _primaryColor,
            accentColor: _accentColor,
            scaffoldBackgroundColor: Colors.grey.shade100,
            primarySwatch: Colors.teal,
          ),
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: ChangeNotifierProvider(
              create: (_) => SearchModel(),
              child: SplashScreen(title: 'Flutter Login UI'),
            ),
          ),
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
        ),
      ),
    );
  }
}
