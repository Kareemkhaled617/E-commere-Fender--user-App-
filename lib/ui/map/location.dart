import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/home/first.dart';


import '../../component/custom_button.dart';

import '../home_services.dart';
import 'map_location.dart';

class screen_location extends StatefulWidget {
   screen_location({Key? key,required this.get}) : super(key: key);
  bool get;

  @override
  State<screen_location> createState() => _screen_locationState();
}

class _screen_locationState extends State<screen_location> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 3),
    )..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print('Location');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomePage()));
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              child: Lottie.network(
              'https://assets6.lottiefiles.com/packages/lf20_is82b4.json'),
            ),
            Column(
              children: [
                Expanded(child: Container()),
                const Text(
                  '  ACCESS YOUR LOCATION',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  """             Lorem ipsum dolor sit amet,
    consecrate disciplining elite, sed diam non
     Lorem ipsum dolor sit amet, consecrate""",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: CustomButton(
                    title: 'Use Current Location',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              // The background color
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
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
                      context.read<ProviderController>().getCurrentLocation().whenComplete(() {
                        context.read<ProviderController>().savaAddress( context.read<ProviderController>().lat!,  context.read<ProviderController>().long!);
                        context.read<ProviderController>().getAddressInfo( context.read<ProviderController>().lat!,  context.read<ProviderController>().long!);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomeServices()));
                      });
                      context.read<ProviderController>().checkFirstLogin(true);
                    },
                    color: Colors.pink,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: CustomButton(
                    title: 'Set From Map',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              // The background color
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
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
                    if(widget.get){
                      context.read<ProviderController>().getCurrentLocation().whenComplete(() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MapLocation()));
                      });
                    }else{
                      context.read<ProviderController>().getAddress().whenComplete(() {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MapLocation()));
                      });
                    }
                     context.read<ProviderController>().checkFirstLogin(true);

                    },
                    color: const Color(0xFFD1F3FF),
                  ),
                ),
                const SizedBox(
                  height: 64,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
