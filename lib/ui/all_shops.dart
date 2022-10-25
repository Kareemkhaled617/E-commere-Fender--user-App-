import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';
import 'package:test_provider/ui/recipe_item.dart';
import 'package:test_provider/ui/shop_ui/shop.dart';


import 'category_item.dart';
import 'custom_round_textbox.dart';
import 'icon_box.dart';



class AllShops extends StatefulWidget {
   AllShops({Key? key,required this.token}) : super(key: key);
  String token;

  @override
  _AllShopsState createState() => _AllShopsState();
}

class _AllShopsState extends State<AllShops> {

  int selectedCategoryIndex = 0;
  bool isLoadingVertical = false;
  int numOfPage=1;
  @override

  Future _loadMoreVertical() async {
    setState(() {
      isLoadingVertical = true;
      numOfPage++;
    });

    await Future.delayed(const Duration(seconds: 2));


    setState(() {
      isLoadingVertical = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: buildHeader(),
      ),
      body: Column(
        children: <Widget>[
          buildSearchBlcok(),
          // FutureBuilder(
          //   future: pro.getData('0'),
          //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //     if (snapshot.hasData) {
          //       final list = snapshot.data as List;
          //       return buildCategory(list);
          //     } else {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //   },
          // ),
          LazyLoadScrollView(
              isLoading: isLoadingVertical,
              onEndOfPage: () => _loadMoreVertical(),

              child: FutureBuilder(
                future: pro.getShops('0',pro.lat!,pro.long!,widget.token,'','$numOfPage'),
                builder: (BuildContext context,  snapshot) {
                  if(snapshot.hasData && pro.shops.isNotEmpty){
                    final list = snapshot.data as List;
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index)=>RecipeItem(
                          data: list[index],
                          onFavoriteTap: () {},
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                builder: (context) => Shop(
                                  id: list[index]['id'],  token: widget.token??'',
                                )));
                          },
                        ),),
                    );
                  }else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },),
          ),

        ],
      ),
    );
  }

  SliverList buildSliverList(List<dynamic> list) {
    return SliverList(
                 delegate: SliverChildBuilderDelegate(
                       (context, index) => RecipeItem(
                     data: list[index],
                     onFavoriteTap: () {},
                     onTap: () {},
                   ),
                   childCount:list.length,
                 ));
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Explore",
          style: TextStyle(
            fontSize: 28,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildSearchBlcok() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Row(
        children: [
          const Expanded(
            child: CustomRoundTextBox(
              hint: "Search",
              prefix: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconBox(
            radius: 50,
            padding: 8,
            child: SvgPicture.asset(
              "assets/icons/filter1.svg",
              color: const Color(0xFF3E4249),
              width: 18,
              height: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategory(List list) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15, 5, 7, 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          list.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              data: list[index],
              isSelected: index == selectedCategoryIndex,
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
