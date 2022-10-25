import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/home/first.dart';

import '../provider/login_controller.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({super.key});

  @override
  _HomeServicesState createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderController>(context);
    return Consumer<LoginController>(builder: (context, value, child) {
      return FutureBuilder(
          future: value.getDataUser(),
          builder: (context, snapshot) {
            final Map m = value.userData ;
            return Scaffold(
              backgroundColor: Colors.blueGrey.shade200,
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/profile_pic.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.4),
                                    Colors.black.withOpacity(.2),
                                  ])),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              const Text(
                                "Home Services",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Center(
                                    child: Text(
                                  "Chose your Services",
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: FutureBuilder(
                        future: pro.getHomeServices(m['token']??''),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final listItem = snapshot.data as List;
                            return GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: listItem
                                  .map((item) => Card(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        child: InkWell(
                                          onTap: () {
                                            pro.changeCat(
                                                int.parse(item['id']));
                                            pro.saveModule(
                                                int.parse(item['id']));
                                            pro.postHomeServicesId(
                                                item['id'], m['token']??'');
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        item['image']),
                                                    fit: BoxFit.cover)),
                                            child: Transform.translate(
                                              offset: const Offset(0, -0),
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 63),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey
                                                        .withOpacity(0.6)),
                                                child: Center(
                                                  child: Text(
                                                    item['name'],
                                                    style: GoogleFonts.alegreya(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ))
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
