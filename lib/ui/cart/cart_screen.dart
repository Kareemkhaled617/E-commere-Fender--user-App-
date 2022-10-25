import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/provider_home.dart';
import 'package:test_provider/ui/cart/empty_cart.dart';
import 'package:test_provider/ui/home/widgets/animated_switcher_wrapper.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, cart, child) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 10,
              child: cart.basketItems.isNotEmpty
                  ? ListView.separated(
                      itemCount: cart.basketItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(cart.basketItems[index].image!),),
                                const SizedBox(width: 15,),
                                Column(
                                  children: [
                                    Text(cart.basketItems[index].title!),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(cart.basketItems[index].price.toString()),
                                    ),
                                  ],
                                )
                              ],
                            ),

                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                cart.remove(cart.basketItems[index]);
                              },
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 10,),
                    )
                  : const EmptyCart(),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                    AnimatedSwitcherWrapper(
                      child: Text(
                        "\$${cart.totalPrice}",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFEC6813),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                    ),
                    onPressed: cart.basketItems.isEmpty ? null : () {},
                    child: const Text("Buy Now"),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      );
    });
  }
}
