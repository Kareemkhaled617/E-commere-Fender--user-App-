
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



TextFormField buildTextFormField({
  required String hint,
  required String label,
  Widget? pIcon,
  Widget? sIcon,
  required TextInputType type,
  required Function() validate,
  required Function() onSave,
}) {
  return TextFormField(
    keyboardType: type,
    validator: validate(),
    onSaved: onSave(),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white70,
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 15,
        color: Colors.grey[700],
      ),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 2,
        color: Colors.grey[700],
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        // borderSide: const BorderSide(color: Colors.black, width: 1.2)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(45),
        // borderSide: const BorderSide(color: Colors.black, width: 1.2)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35),
        // borderSide: const BorderSide(color: Colors.black, width: 1.2),
      ),
      prefixIcon: pIcon,
      suffixIcon: sIcon,
    ),
  );
}

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? textStyle,
  TextStyle? labelStyle,
  InputBorder? enabledBorder,
  bool isPassword = false,
  ValueChanged? change,
  VoidCallback? suffixPressed,
  required FormFieldValidator validate,
  String? label,
  IconData? prefix,
  String? hintText,
  OutlineInputBorder? myfocusborder,
  ValueChanged? onSubmit,
  IconData? suffix,
  bool isClickable = true,
  GestureTapCallback? TapWhenClick,
}) =>
    TextFormField(
      onTap: TapWhenClick,
      controller: controller,
      style: textStyle,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      enabled: isClickable,
      onChanged: change,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: enabledBorder,
        labelText: label,
        labelStyle: labelStyle,
        focusedBorder: myfocusborder,
        contentPadding: contentPadding,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );


Widget builditemCategories(context,ItemDetail) => Container(
  width: 250,
  height: 120,
  decoration: BoxDecoration(
    borderRadius: new BorderRadius.circular(20),
    color: Colors.white,
  ),
  child:   InkWell(
    onTap: () async {
      // buildbottomsheet(context);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1661538755865-fcca131da8f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=60'), fit: BoxFit.cover),
                borderRadius: new BorderRadius.circular(20)),
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ItemDetail['name'], maxLines: 3,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 20,

                child: Text(
                  ItemDetail['address'],

                  maxLines: 3,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row( mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(child: const Icon(Icons.call),onTap: ()async{

                      final String phoneUrl = 'tel: ${ItemDetail['phone']}';
                      if (await canLaunch(phoneUrl)) {
                        await launch(phoneUrl);
                      } else {
                        throw 'Could not launch $phoneUrl';
                      }

                    },),
                    const SizedBox(width: 10,),
                    InkWell(child: const Icon(Icons.add_location_outlined),onTap: (){
                      // MapUtils.map(double.parse(ItemDetail['lat']), double.parse(ItemDetail['long']));
                    },),
                    const Spacer(),
                    ItemDetail['rate']>0?const Icon(Icons.star,size: 15,color: Colors.yellow,):const Icon(Icons.star_border_purple500_sharp,size: 15,),
                    ItemDetail['rate']>1?const Icon(Icons.star,size: 15,color: Colors.yellow,):const Icon(Icons.star_border_purple500_sharp,size: 15,),
                    ItemDetail['rate']>2?const Icon(Icons.star,size: 15,color: Colors.yellow,):const Icon(Icons.star_border_purple500_sharp,size: 15,),
                    ItemDetail['rate']>3?const Icon(Icons.star,size: 15,color: Colors.yellow,):const Icon(Icons.star_border_purple500_sharp,size: 15,),
                    ItemDetail['rate']>4?const Icon(Icons.star,size: 15,color: Colors.yellow,):const Icon(Icons.star_border_purple500_sharp,size: 15,),


                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  ),
);

//
// Future buildbottomsheet(context) => showModalBottomSheet(
//   clipBehavior: Clip.antiAliasWithSaveLayer,
//   isScrollControlled: true,
//   shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20),
//       )),
//   context: context,
//   builder: (context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white70,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Stack(
//               alignment: AlignmentDirectional.topStart,
//               children: [
//                 Container(
//                   height: 320,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: NetworkImage('https://images.unsplash.com/photo-1661548735469-900d33d34808?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=60'),
//                           fit: BoxFit.cover),
//                       borderRadius: new BorderRadius.circular(20)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 25.0, left: 8),
//                   child: InkWell(
//                     child: const Icon(Icons.arrow_back),
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding:
//               const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const Text(
//                     'Dhoom',
//                     style: const TextStyle(
//                         fontSize: 25, fontWeight: FontWeight.w700),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Icon(Icons.star_border_purple500_sharp),
//                       const Icon(Icons.star_border_purple500_sharp),
//                       const Icon(Icons.star_border_purple500_sharp),
//                       const Icon(Icons.star_border_purple500_sharp),
//                       const Icon(Icons.star_border_purple500_sharp),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       const Text('4,1'),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Text('يغلق عند الساعة 2 ص'),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       const Text(
//                         'مفتوح',
//                         style: const TextStyle(color: Colors.green),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const Text('35 د'),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       const Icon(Icons.drive_eta),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       const Text('مطعم وجبات سريعه'),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 60,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: ListView.separated(
//                         physics: const BouncingScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) => Padding(
//                           padding:
//                           const EdgeInsets.symmetric(vertical: 8.0),
//                           child: defaultButton(
//                               icon: true,
//                               shape: true,
//                               width: 170,
//                               icons: detailscategoriesList[index].icon,
//                               Textcolor: Colors.blue,
//                               background: Colors.white,
//                               function: () {
//
//                               },
//                               text: detailscategoriesList[index].title,
//                               isUpperCase: false),
//                         ),
//                         itemCount: detailscategoriesList.length,
//                         separatorBuilder: (context, index) => const SizedBox(
//                           width: 5,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 130,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView.separated(
//                           physics: const BouncingScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               width: 130,
//                               decoration: BoxDecoration(
//                                   image: const DecorationImage(
//                                       image: NetworkImage('https://images.unsplash.com/photo-1661548735469-900d33d34808?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=60'),
//                                       fit: BoxFit.cover),
//                                   borderRadius:
//                                   new BorderRadius.circular(20)),
//                             );
//                           },
//                           separatorBuilder: (context, index) => const SizedBox(
//                             width: 5,
//                           ),
//                           itemCount: 10),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );

buildappbar(searchController)=>AppBar(
  title: Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.0)),
    child: defaultFormField(
        controller: searchController,
        type: TextInputType.text,
        suffix: Icons.cancel,
        label:'labelSearch',
        prefix: Icons.location_on,
        validate: (value) {}),
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.orangeAccent,
  Color Textcolor = Colors.white,
  dynamic? Iconcolor,
  bool isUpperCase = true,
  double radius = 3.0,
  bool shape = true,
  bool checkwidth = true,
  dynamic icons = Icons.shopping_cart_outlined,
  bool icon = false,
  required VoidCallback? function,
  required String text,
}) =>
    checkwidth
        ? Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: width,
      height: 50.0,
      decoration: shape
          ? const ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            width: 2,
            color: Colors.black12,
          ),
        ),
      )
          : ShapeDecoration(
        color: background,
        shape: const StadiumBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
      ),
      child: MaterialButton(
          onPressed: function,
          child: icon
              ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icons, color: Iconcolor),
              const SizedBox(
                width: 10,
              ),
              Text(
                isUpperCase ? text.toUpperCase() : text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Textcolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ],
          )
              : Center(
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Textcolor,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          )),
    )
        : Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 50.0,
      decoration: shape
          ? const ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(
            width: 2,
            color: Colors.black12,
          ),
        ),
      )
          : ShapeDecoration(
        color: background,
        shape: const StadiumBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
      ),
      child: MaterialButton(
          onPressed: function,
          child: icon
              ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Icon(icons, color: Iconcolor),
                onTap: () {},
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                isUpperCase ? text.toUpperCase() : text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Textcolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ],
          )
              : Center(
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Textcolor,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          )),
    );