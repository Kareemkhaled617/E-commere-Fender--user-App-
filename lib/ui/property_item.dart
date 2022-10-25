import 'package:flutter/material.dart';
import 'package:test_provider/ui/shop_ui/shop.dart';




import 'color.dart';
import 'custom_image.dart';
import 'icon_box.dart';

class PropertyItem extends StatelessWidget {
  PropertyItem({ Key? key, required this.data,required this.token }) : super(key: key);
  final data;
  String token;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context)
            .push(MaterialPageRoute(
            builder: (context) => Shop(
              id: data['id'],  token: token,
            )));
      },
      child: Container(
          width: double.infinity, height: 240,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: .5,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              CustomImage(
                data["image"],
                radius: 25, width: double.infinity, height: 150,
              ),
              // Positioned(
              //   right: 20, top: 130,
              //   child: IconBox(bgColor: red,child: Icon(data["is_favorited"] ? Icons.favorite : Icons.favorite_border, color: Colors.white, size: 20,),)
              // ),
              Positioned(
                left: 15, top: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["name"], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const Icon(Icons.place_outlined, color: darker, size: 13,),
                        const SizedBox(width: 3,),
                        Text(data["address"], style: const TextStyle(fontSize: 13, color: darker),),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    // Text("${data["rate"]}", style: const TextStyle(fontSize: 15, color: primary, fontWeight: FontWeight.w500),),
                  ],
                )
              ),
            ],
          ),
        ),
    );
  }
}