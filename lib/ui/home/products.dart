
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProviderController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: Row(
          children: [
            SizedBox(
                width: 110,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      pro.supCategory.clear();
                      pro.getSupData(pro.category[index]['id']);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                            '${pro.category[index]['name']}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    color: Colors.grey,
                  ),
                  itemCount: pro.category.length,
                )),
            Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  primary: false,
                  childAspectRatio: 7/8,
                  shrinkWrap: true,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                  children:List.generate(pro.supCategory.length, (index) =>Container(
                    // padding: const EdgeInsets.only(top: 15, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black
                        )

                    ),
                    child: Center(
                        child: Text(
                          '${pro.supCategory[index]['name']}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )),
                  ) ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
