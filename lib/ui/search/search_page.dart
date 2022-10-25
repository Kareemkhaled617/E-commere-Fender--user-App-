import 'package:flutter/material.dart';
import 'package:test_provider/ui/custom_image.dart';
import 'package:test_provider/ui/search/taps/service_tap.dart';
import 'package:test_provider/ui/search/taps/shop_tap.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.token, required this.search})
      : super(key: key);
  String token;
  String search;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = const Color(0xff1a73e8);
  int index = 0;
  final _tabs = [
    const Tab(
      child: CustomImage(
        'https://ibtikarsoft.net/la2iny_V1/public/app-assets/imgs/search_icons/markets.png',
        width: 50,
        height: 50,

      ),
    ),
    const Tab(  child: CustomImage(
      'https://ibtikarsoft.net/la2iny_V1/public/app-assets/imgs/search_icons/services.png',
      width: 50,
      height: 50,

    ),),
    const Tab(  child: CustomImage(
      'https://ibtikarsoft.net/la2iny_V1/public/app-assets/imgs/search_icons/products.png',
      width: 50,
      height: 50,

    ),),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ShopTap(
        token: widget.token,
        search: widget.search,
      ),
      ServicesTap(
        token: widget.token,
        search: widget.search,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: kToolbarHeight - 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: _selectedColor),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: _tabs,
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
              ),
            ),
            IndexedStack(
              index: index,
              children: pages,
            ),
          ]),
        ),
      ),
    );
  }
}

class MaterialDesignIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const MaterialDesignIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  _MaterialDesignPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MaterialDesignPainter(this, onChanged);
  }
}

class _MaterialDesignPainter extends BoxPainter {
  final MaterialDesignIndicator decoration;

  _MaterialDesignPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = Offset(
          offset.dx,
          configuration.size!.height - decoration.indicatorHeight,
        ) &
        Size(configuration.size!.width, decoration.indicatorHeight);

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: Radius.circular(8),
        topLeft: Radius.circular(8),
      ),
      paint,
    );
  }
}
