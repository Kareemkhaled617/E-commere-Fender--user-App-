

import 'package:flutter/material.dart';

import '../model/reusable_widget.dart';
import '../model/review_model.dart';

class ProductReviewPage extends StatefulWidget {
  const ProductReviewPage({Key? key}) : super(key: key);

  @override
  _ProductReviewPageState createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  // initialize reusable widget
  final _reusableWidget = ReusableWidget();

  List<String> starList = ['All Review', '1', '2', '3', '4', '5'];
  int starIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          elevation: 2,
          title: Text(
            'Product Review',
          ),
          backgroundColor: Colors.white,
          bottom: _reusableWidget.bottomAppBar(),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(starList.length, (index) {
                  return radioStar(starList[index], index);
                }),
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: reviewData.length,
                // Add one more item for progress indicator
                itemBuilder: (BuildContext context, int index) {
                  return _buildReviewCard(index);
                },
              ),
            ),
          ],
        )
    );
  }

  Widget radioStar(String txt, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          starIndex = index;
        });
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: starIndex == index ? Colors.white : Colors.white,
              border: Border.all(
                  width: 1,
                  color: starIndex == index ? Colors.white : Colors.grey[300]!),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: index == 0
              ? Text(txt, style: TextStyle(color: starIndex == index ? Colors.white : Colors.black))
              : Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(txt, style: TextStyle(color: starIndex == index ? Colors.white :  Colors.black)),
              SizedBox(width: 2),
              Icon(Icons.star, color: starIndex == index ? Colors.white : Colors.yellow[700], size: 12),
            ],
          )),
    );
  }

  Widget _buildReviewCard(index){
    return Card(
      margin: EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(reviewData[index].date, style: TextStyle(fontSize: 13, color: Colors.grey)),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reviewData[index].name, style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold
                )),
                _reusableWidget.createRatingBar(rating: reviewData[index].rating, size: 12)
              ],
            ),
            SizedBox(height: 4),
            Text(reviewData[index].review)
          ],
        ),
      ),
    );
  }
}
