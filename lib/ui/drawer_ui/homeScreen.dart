import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_controller.dart';
import 'package:test_provider/provider/provider_home.dart';

import '../../provider/map_provider.dart';
import '../../provider/provider.dart';
import '../color.dart';
import '../map/map.dart';
import '../notification_box.dart';
import '../search/settings_page.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimeOfDay now =TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title:  Consumer<LoginController>(
            builder: (context,value,child){
              return FutureBuilder(
                  future: value.getDataUser(),
                  builder: (context,snapshot){
                if(value.userData.isNotEmpty && snapshot.hasData){
                  final map = snapshot.data as Map;
                  return RichText(
                    text:  TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: DateTime.now().hour <= 12?'Good Morning, \n ${'${map['f_name']} ${map['l_name']}'} ':'Good Evening, \n ${'${map['f_name']} ${map['l_name']}'}  ',
                          style: const TextStyle(
                            height: 1.3,
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const TextSpan(
                          text: 'Have a nice day.!',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                }else{
                  return RichText(
                    text:  TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: DateTime.now().hour <= 12?'Good Morning, \n  Guest':'Good Evening, \n Guest ',
                          style: const TextStyle(
                            height: 1.3,
                            color: textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const TextSpan(
                          text: 'Have a nice day.!',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SettingsPage()));
                  },
                  child: const NotificationBox(
                    notifiedNumber: 1,
                  ),
                )),
          ],
        ),
        body:IndexedStack(
          index: value.currentIndex,
          children: value.pages,
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.white,
          showElevation: false,
          selectedIndex: value.currentIndex,
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                activeColor: Colors.indigoAccent,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: const Icon(Icons.favorite),
                title: const Text('Favorite'),
                activeColor: Colors.indigoAccent,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: const Icon(Icons.shopping_cart),
                title: const Text('Cart'),
                activeColor: Colors.indigoAccent,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                activeColor: Colors.indigoAccent,
                inactiveColor: Colors.grey),
          ],
          onItemSelected: (i) {
            value.changeNavigateIndex(i);
          },
        ),
        floatingActionButton: FloatingActionButton(child:const Icon(Icons.map,color: Colors.white,) , onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return Dialog(
                  // The background color
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        // The loading indicator
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        // Some text
                        Text('Loading...')
                      ],
                    ),
                  ),
                );
              });
          context
              .read<ProviderState>()
              .getSliderData(
            '0',
            context
                .read<ProviderController>()
                .lat!,
            context
                .read<ProviderController>()
                .long!,
          )
              .whenComplete(() {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    MapPage(
                      long: context
                          .read<ProviderController>()
                          .long!,
                      lat: context
                          .read<ProviderController>()
                          .lat!,
                    )));
          });
        },),
      );
    },);
  }
}
