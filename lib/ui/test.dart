import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
import 'map/location.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Selector<ProviderController, Future>(
        selector: (context, pro) => pro.checkLocation(),
        builder: (context, value, child) {
       return FutureBuilder(
          future: value,
         builder: (context,snapshot){
           if (value ==null) {
             return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
           } else {
             return  screen_location(get: true,);
           }
         },
        );
        });


  }
}
