import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ebook_audio/src/AppColors.dart';
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
                                  margin: const EdgeInsets.only(left: 5, right: 5),
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
                            backgroundColor: Colors.white,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                              child: Container(
                                margin: EdgeInsets.all(0),
                                child: TabBar(
                                    indicatorPadding: EdgeInsets.only(),
                                    //check
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelPadding: EdgeInsets.all(0),
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
                                      Container(
                                          width: 120,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.menu1Color ,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    blurRadius: 7,
                                                    offset: const Offset(0, 0)),
                                              ]),
                                          child: const Text(
                                            'New',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      Container(
                                          width: 120,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.menu2Color,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    blurRadius: 7,
                                                    offset: Offset(0, 0)),
                                              ]),
                                          child: const Text(
                                            'New',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      Container(
                                          width: 120,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.menu3Color,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    blurRadius: 7,
                                                    offset: Offset(0, 0)),
                                              ]),
                                          child: const Text(
                                            'New',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ]),
                              ),
                            ),
                          )
                        ];
                      },
                      body: TabBarView(
                        controller: _tabController,
                          children: const [
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
