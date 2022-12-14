import 'package:flutter/material.dart';

import 'color.dart';
import 'custom_image.dart';
import 'favorite_box.dart';

class RecommendItem extends StatelessWidget {
  const RecommendItem(
      {Key? key,
      required this.data,
      this.width = 300,
      this.onTap,
      this.onFavoriteTap})
      : super(key: key);
  final Map data;
  final double width;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width-40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context)
              .backgroundColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            CustomImage(
              data["image"],
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
                  Text(
                    data["name"]??'',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                      color: Theme.of(context)
                          .primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    data["name"]??'',
                    style: const TextStyle(fontSize: 12, color: labelColor),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      // CustomImage(
                      //   data["creator"]["image"],
                      //   width: 25,
                      //   height: 25,
                      // ),
                      // const SizedBox(
                      //   width: 5,
                      // ),
                      // Expanded(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         data["creator"]["name"],
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         style: const TextStyle(
                      //           color: textColor,
                      //           fontSize: 12,
                      //         ),
                      //       ),
                      //       Text(
                      //         data["creator"]["type"],
                      //         maxLines: 1,
                      //         overflow: TextOverflow.ellipsis,
                      //         style: const TextStyle(
                      //           color: labelColor,
                      //           fontSize: 10,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children:  [
                            const Icon(
                              Icons.star,
                              color: textColor,
                              size: 16,
                            ),
                            Text(
                              "${data['rate']['rate']??0}",
                              style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      FavoriteBox(
                        size: 20,
                        padding: 5,
                        isFavorited: data['is_fav'],
                        onTap: onFavoriteTap,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
