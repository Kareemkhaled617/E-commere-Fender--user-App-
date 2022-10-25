// import 'package:flutter/material.dart';
//
//
// import '../classes/language.dart';
// import '../classes/language_constants.dart';
// import '../main.dart';
//
// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);
//
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//           child: DropdownButton<Language>(
//         iconSize: 30,
//          hint:const Padding(
//            padding:  EdgeInsets.all(8.0),
//            child:  Text("Chose Language"),
//          ) ,
//         onChanged: (Language? language) async {
//           if (language != null) {
//             Locale _locale = await setLocale(language.languageCode);
//              MyApp.setLocale(context, _locale);
//           }
//         },
//         items: Language.languageList()
//             .map<DropdownMenuItem<Language>>(
//               (e) => DropdownMenuItem<Language>(
//                 value: e,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Text(
//                       e.flag,
//                       style: const TextStyle(fontSize: 30),
//                     ),
//                     Text(e.name)
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/home/first.dart';
import 'package:test_provider/ui/home/setting.dart';
import '../../classes/language.dart';
import '../../classes/language_constants.dart';
import '../../main.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).settings),
        leading: IconButton(icon: const Icon(Icons.arrow_back,),onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomePage()));
        },),
      ),
      body: Center(
          child: DropdownButton<Language>(
            iconSize: 30,
            hint: Text(translation(context).changeLanguage),
            onChanged: (Language? language) async {
              if (language != null) {
                Locale locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, locale);
                context.read<ProviderController>().changeLang(locale);
              }
            },
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.flag,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(e.name)
                  ],
                ),
              ),
            )
                .toList(),
          )),
    );
  }
}