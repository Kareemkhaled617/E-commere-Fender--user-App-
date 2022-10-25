
import 'package:flutter/material.dart';
import 'package:test_provider/ui/search/settings_page.dart';

import '../home/setting.dart';
import 'account.dart';


class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  _profile_screenState createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => _showStartDialog()
    );
    super.initState();
  }

  Future<void> _showStartDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only( left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Account()));
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1661548735469-900d33d34808?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=60'),
                      radius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, bottom: 5, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Robert Steven',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Account Information',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(
                          children: [
                            Text(
                              name[index],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                            const Spacer(),
                            InkWell(
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 20.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                    itemCount: name.length),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 20.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Settings()));
                  },
                  child: Row(
                    children: [
                      const Text(
                        'Setting',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      InkWell(
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                width: 120,
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.settings_power_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Sign Out')
                      ],
                    )),
              ),
              const SizedBox(height: 300,),
            ],
          ),
        ),
      ),
    );
  }
}

List name = [
  'Set Address for Delivery',
  'Order  List',
  'Payment  Method',
  'Last Seen  Product',
  'Notification Setting',
  'About',
  'Terms and Conditions',
  'Privacy Policy',
];
