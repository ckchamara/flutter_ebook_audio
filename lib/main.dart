import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ebook_audio/src/AppColors.dart';
import 'package:flutter_ebook_audio/src/my_tabs.dart';
// import 'package:flutter_ebook_audio/src/AppColors.dart' as AppColors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List popularBooks = List.empty();
  late List books = List.empty();
  late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((value) {
      setState(() {
        popularBooks = json.decode(value);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((value) {
      setState(() {
        books = json.decode(value);
      });
    });
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
    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            //mainViewAppColumn
            children: [
              //TopMenuBar
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.menu,
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.search,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Popular Books
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //Horizontal Scroller
              Container(
                key: const ObjectKey('Horizontal_Scroller'),
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: -30,
                        right: 0,
                        child: SizedBox(
                          height: 180,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks == null
                                  ? 0
                                  : popularBooks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.green,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              popularBooks[index]["img"]),
                                          fit: BoxFit.cover)),
                                );
                              }),
                        ))
                  ],
                ),
              ),
              //Scrollable TabBar with Tabs
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
                              preferredSize: Size.fromHeight(50),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20, left: 10),
                                child: TabBar(
                                    indicatorPadding: EdgeInsets.only(),
                                    //check
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelPadding: EdgeInsets.only(right: 10),
                                    controller: _tabController,
                                    isScrollable: true,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: Offset(0, 0))
                                        ]),
                                    tabs: [
                                      AppTabs(
                                          text: 'New',
                                          color: AppColors.menu1Color),
                                      AppTabs(
                                          text: 'Popular',
                                          color: AppColors.menu2Color),
                                      AppTabs(
                                          text: 'Trending',
                                          color: AppColors.menu3Color),
                                    ]),
                              ),
                            ),
                          )
                        ];
                      },
                      body: TabBarView(controller: _tabController, children: [
                        ListView.builder(
                            itemBuilder: (BuildContext context, int indexi) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.tabVarViewColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2)),
                                  ]),
                              child: Container(
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "img/abstract1.jpg"))),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text('Content'),
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                            ),
                            title: Text('Content'),
                          ),
                        ),
                      ])))
            ],
          ),
        ),
      ),
    );
  }
}
