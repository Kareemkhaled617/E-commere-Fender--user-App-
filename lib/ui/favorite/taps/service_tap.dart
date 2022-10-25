import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../color.dart';
import '../../custom_image.dart';
import '../../recipe_item.dart';
import '../../shop_ui/shop.dart';

class ServicesTap extends StatefulWidget {
   ServicesTap({Key? key,required this.token}) : super(key: key);
  String token;


  @override
  State<ServicesTap> createState() => _ServicesTapState();
}

class _ServicesTapState extends State<ServicesTap> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderController>(context);
    return FutureBuilder(
      future: pro.getFavServices(widget.token),
      builder: (BuildContext context,  snapshot) {
        if(snapshot.hasData && pro.favServices.isNotEmpty){
          final list = snapshot.data as List;
          return SizedBox(
            height:MediaQuery.of(context).size.height ,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index)=>GestureDetector(
                onTap: (){},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration:  const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: .1, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomImage(
                        list[index]["image"],
                        radius: 15,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    list[index]["name"]??'',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.more_vert_rounded,
                                  size: 18,
                                  color: labelColor,
                                )
                              ],
                            ),
                             const SizedBox(height: 10,),
                             Text(
                              list[index]['desc']??'',
                              style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w700, color: labelColor),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: textColor,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "${list[index]['rate']}",
                                        style: const TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),),
          );
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },);
  }
}
