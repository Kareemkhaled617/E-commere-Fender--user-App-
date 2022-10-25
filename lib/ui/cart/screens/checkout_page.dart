import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../provider/provider_home.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, cart, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Checkout Page [\$ ${cart.totalPrice}]'),
            ),
            body: cart.basketItems.isEmpty
                ? const Text('no items in your cart')
                : ListView.builder(
                    itemCount: cart.basketItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(cart.basketItems[index].title!),
                          subtitle:
                              Text(cart.basketItems[index].price.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cart.remove(cart.basketItems[index]);
                            },
                          ),
                        ),
                      );
                    },
                  ));
      },
    );
  }
}
