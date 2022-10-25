import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/shop_ui/shop_details.dart';
import 'package:test_provider/ui/shop_ui/shop_mark.dart';

import '../../provider/provider_home.dart';
import '../shop_info.dart';
import 'messages/message_screen.dart';

class Shop extends StatefulWidget {
  Shop({Key? key, required this.id, required this.token})
      : super(key: key);
  String id;
  String token;

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<ProviderController>(context);
    return FutureBuilder(
        future:pro.getSelectedShops(widget.id, widget.token) ,
        builder: (context,snapshot){
          if(snapshot.hasData && pro.selectedShops.isNotEmpty){
            final map = snapshot.data as Map;
            return Scaffold(
              body: IndexedStack(
                index: context.read<HomeProvider>().shopCurrentIndex,
                children: [
                  ShopInfo(
                    id: widget.id,
                    token: widget.token,
                  ),
                  ShopMark(
                    lat: double.parse(map['lat']),
                    long: double.parse(map['long']),
                  ),
                  const MessagesScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavyBar(
                backgroundColor: Colors.white,
                showElevation: false,
                selectedIndex: context.watch<HomeProvider>().shopCurrentIndex,
                items: [
                  BottomNavyBarItem(
                      icon: const Icon(Icons.home),
                      title: const Text('Home'),
                      activeColor: Colors.indigoAccent,
                      inactiveColor: Colors.grey),
                  BottomNavyBarItem(
                      icon: const Icon(Icons.location_on_sharp),
                      title: const Text('Location'),
                      activeColor: Colors.indigoAccent,
                      inactiveColor: Colors.grey),
                  BottomNavyBarItem(
                      icon: const Icon(Icons.chat_bubble),
                      title: const Text('Chat'),
                      activeColor: Colors.indigoAccent,
                      inactiveColor: Colors.grey),
                ],
                onItemSelected: (i) {
                  context.read<HomeProvider>().changeShopNavigateIndex(i);
                },
              ),
            );
          }else {
            return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }

    });
  }
}
