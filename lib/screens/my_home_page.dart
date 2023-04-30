import 'dart:convert';

import 'package:ebook/app_colors.dart' as AppColors;
import 'package:ebook/app_tabs.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List _popularBooks = [];
  late List _books = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/PopularBooks.json")
        .then((S) {
      setState(() {
        _popularBooks = json.decode(S);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((S) {
      setState(() {
        _books = json.decode(S);
      });
    });

    print("This is theh numer of books " + _books.length.toString());
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.backGround,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage('images/menu.png'),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(Icons.notifications_active),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screen_height * 0.04,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30, color: Colors.black45),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      left: -30,
                      child: Container(
                        height: 210,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 0.6),
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.85),
                            itemCount: _popularBooks == null
                                ? 0
                                : _popularBooks.length,
                            itemBuilder: (_, i) {
                              return Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(_popularBooks[i]['img']),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(35),
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 7, left: 0, right: 5),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 12),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    //offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              tabs: [
                                AppTabs(
                                    color: AppColors.menu1Color, text: "New"),
                                AppTabs(
                                    color: AppColors.menu2Color, text: "Short"),
                                AppTabs(
                                    color: AppColors.menu3Color,
                                    text: "Inspirational"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: _books == null ? 0 : _books.length,
                          itemBuilder: (_, i) {
                            return Container(
                              margin: const EdgeInsets.all(8),
                              height: 110,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.tabVarViewColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2)),
                                  ],
                                ),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 4, bottom: 4, right: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(_books[i]["img"]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: AppColors.starColor,
                                              ),
                                              Text(
                                                _books[i]["rating"],
                                                style: TextStyle(
                                                    color: AppColors.menu2Color,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                          Text(
                                            _books[i]["title"],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            _books[i]["text"],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.subTitleColor,
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text(
                                              "Love",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                          title: Text("Content 2"),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                          ),
                          title: Text("Content 3"),
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
    );
  }
}
