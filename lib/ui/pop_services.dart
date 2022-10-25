import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/service_info.dart';


import '../component/cache_image_network.dart';
import '../config/constant.dart';

class PopServices extends StatefulWidget {
   PopServices({Key? key,required this.token}) : super(key: key);
  String token;

  @override
  _PopServicesState createState() => _PopServicesState();
}

class _PopServicesState extends State<PopServices> {

  final Color _color = const Color(0xFF515151);

  @override
  Widget build(BuildContext context) {
    final double boxImageSize = (MediaQuery
        .of(context)
        .size
        .width / 4);
    var pro = Provider.of<ProviderController>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: const Text(
          'Popular Services List',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey[100],
              height: 1.0,
            )),
      ),
      body: FutureBuilder(
        future: pro.getPopServices('0',pro.lat!, pro.long!,widget.token),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: pro.popServices.length,
              padding: const EdgeInsets.symmetric(vertical: 0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ServicesDetials( id:pro.popServices[index]['id'], token: widget.token,)));
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: buildCacheNetworkImage(
                                      width: boxImageSize,
                                      height: boxImageSize,
                                      url:
                                      pro.popServices[index]['image'])),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      pro.popServices[index]['name'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: _color),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                        '${pro.popServices[index]['desc'] ?? ''}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.yellow, size: 19),
                                        Text(
                                            '${pro.popServices[index]['rate']}',
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: SOFT_GREY))
                                      ],
                                    ),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    (index == pro.popServices.length - 1)
                        ? Wrap()
                        : Divider(
                      height: 0,
                      color: Colors.grey[400],
                    )
                  ],
                );
              },
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),);
  }


}
