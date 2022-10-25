/*
install plugin in pubspec.yaml
flutter_localizations:
    sdk: flutter

create initial_language.dart for first default language
create app_localizations.dart

define all text language at assets/lang/

Don't forget to add all country images used in this pages at the pubspec.yaml
Don't forget to add all json language used in this pages at the pubspec.yaml
 */


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MultiLanguagePage extends StatefulWidget {
  @override
  _MultiLanguagePageState createState() => _MultiLanguagePageState();
}

class _MultiLanguagePageState extends State<MultiLanguagePage> {
  // initialize global widget


  final Color _color1 = const Color(0xff777777);
  final Color _color2 = const Color(0xff01aed6);

  String defaultLang = 'en';

  final List<String> _localeList = ['en', 'ar'];
  final List<String> _countryList = ['US', 'DZ'];
  final List<String> _languageList = [
    'English',
    'Arabic',
  ];

  @override
  void dispose() {
    super.dispose();
  }


  void changeLocale(Locale locale) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setString('lCode', locale.languageCode);
    await _pref.setString('cCode', locale.countryCode!);
    defaultLang = locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 250, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text('Language',
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w800))),
              ListView(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: List.generate(_localeList.length, (index) {
                  return Card(
                    margin: const EdgeInsets.only(top: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 2,
                    color: Colors.white,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showPopupChangeLanguage(index,_localeList[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                            ),
                            Expanded(
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(_languageList[index],
                                      style: const TextStyle(fontSize: 14))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  void _showPopupChangeLanguage(index,String lang) {
    // set up the buttons
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No', style: TextStyle(color: _color2)));
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          // Provider.of<HomeProvider>(context,listen: false).save_data(lang);
        },
        child: Text('Yes', style: TextStyle(color: _color2)));

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Change Language',
        style: TextStyle(fontSize: 18),
      ),
      content: Text('Are you sure want to change language ?',
          style: TextStyle(fontSize: 13, color: _color1)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
