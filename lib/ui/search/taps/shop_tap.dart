import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../recipe_item.dart';
import '../../shop_ui/shop.dart';

class ShopTap extends StatefulWidget {
   ShopTap({Key? key,required this.token,required this.search}) : super(key: key);
  String token;
  String search;

  @override
  State<ShopTap> createState() => _ShopTapState();
}

class _ShopTapState extends State<ShopTap> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderController>(context);
    return FutureBuilder(
      future: pro.getShops('0',pro.lat!,pro.long!,widget.token,widget.search,'1'),
      builder: (BuildContext context,  snapshot) {
        if(snapshot.hasData && pro.shops.isNotEmpty){
          final list = snapshot.data as List;
          return SizedBox(
            height:MediaQuery.of(context).size.height ,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index)=>RecipeItem(
                data: list[index],
                onFavoriteTap: () {},
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                      builder: (context) => Shop(
                        id: list[index]['id'], token: widget.token??'',
                      )));
                },
              ),),
          );
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },);
  }
}
