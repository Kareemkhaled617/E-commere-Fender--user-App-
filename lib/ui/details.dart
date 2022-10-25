import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/text_field.dart';




class details_screen extends StatelessWidget {
  const details_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.redAccent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 31.4,
                left: 2,
                right: 2,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Container(
                            height: 125,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: NetworkImage('https://images.unsplash.com/photo-1661607775751-dc9efc8f3a9c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=400&q=60'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 8),
                          child: InkWell(
                            child: const Icon(Icons.arrow_back),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // builditemCategories(context),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Descripes',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Masasaa losdasld alsdlasdao asldlasldo asdlalsdoa lalsdoa sdasdasd asdasda asdasd asda .',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    child: Row(
                                      children: <Widget>[
                                        const Text(
                                          'Size ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 60,
                                          child: ElevatedButton(
                                            onPressed: () {

                                            },
                                            child: const Text('12 *'),
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                   Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 60,
                                          child: ElevatedButton(
                                            onPressed: () {

                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                            ),
                                            child: const Text('12 *'),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 60,
                                          child: ElevatedButton(
                                            onPressed: () {

                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary:  Colors.white,
                                            ),
                                            child: const Text('12 *'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, bottom: 20),
                                    child: Row(
                                      children: <Widget>[
                                        const Text(
                                          'Quenasdasd ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:  Colors.white,
                                            border: Border.all(
                                                color: Colors.white70,
                                                width: 1.0,
                                                style: BorderStyle.solid),
                                          ),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {

                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white

                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '{cubic.counter} ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white70,
                                                width: 1.0,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:  Colors.white,
                                          ),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {

                                              },
                                              child: Icon(
                                                Icons.add,
                                                color:Colors.redAccent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Addons ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 90,
                                          child: ListView.separated(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return SizedBox(
                                                  height: 90,
                                                  width: 90,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {

                                                          },
                                                          child: Container(
                                                            width: 90,
                                                            height: 65,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(10),
                                                              color: Colors.redAccent,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Text('Cheese'),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text('& 5.00'),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                child: const Icon(
                                                                  Icons.remove,
                                                                  size: 16,
                                                                ),
                                                                onTap: () {},
                                                              ),
                                                              const Spacer(),
                                                              const Text('0'),
                                                              const Spacer(),
                                                              InkWell(
                                                                child: const Icon(
                                                                  Icons.add,
                                                                  size: 16,
                                                                ),
                                                                onTap: () {},
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) => const SizedBox(),
                                              itemCount: 4),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              const Text(
                                                'Total Amounts : ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                '& 20.25',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.redAccent),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Review ',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.redAccent,
                                                  size: 15,
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.redAccent,
                                                  size: 15,
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.redAccent,
                                                  size: 15,
                                                ),
                                                const Icon(
                                                  Icons
                                                      .star_border_purple500_sharp,
                                                  size: 15,
                                                ),
                                                const Icon(
                                                  Icons
                                                      .star_border_purple500_sharp,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Text('(212)'),
                                              ],
                                            ),
                                            const Spacer(),
                                            TextButton(
                                                onPressed: () {

                                                },
                                                child: const Text('View All'))
                                          ],
                                        ),
                                        SizedBox(height: 220,
                                          child: ListView.separated(physics: const NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
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
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    '11 Septemper 2020 ',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w300,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'A******** ',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w400,
                                                            color:
                                                            Colors.black),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors.redAccent,
                                                              size: 15,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors.redAccent,
                                                              size: 15,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors.redAccent,
                                                              size: 15,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .star_border_purple500_sharp,
                                                              size: 15,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .star_border_purple500_sharp,
                                                              size: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: const Text(
                                                    'Every came in the very well packet 0000000 is edcadaksdas asa asdas dasd asd asd asda',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w300,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }, separatorBuilder: (context, index) =>  Padding(
                                            padding: const EdgeInsetsDirectional.only(
                                              start: 20.0,
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 1.0,
                                              color: Colors.grey[300],
                                            ),
                                          ), itemCount: 3),
                                        ),

                                        const SizedBox(
                                          height: 5,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        defaultButton(
                                            icon: false,
                                            width: 350,
                                            shape: true,
                                            function: () {
                                            },
                                            text: 'Add To Cart',
                                            isUpperCase: false),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

  }




