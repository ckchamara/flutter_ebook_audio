import 'package:flutter/material.dart';
// import 'package:flutter_ebook_audio/src/colors.dart' as AppColors;

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

class _MyHomePageState extends State<MyHomePage> {
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
                    Icon(
                      Icons.menu,
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
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
              SizedBox(
                height: 20,
              ),
              //Popular Books
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              //Horizontal Scroller
              Container(
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
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/img/abstract5.jpg'),
                                      fit: BoxFit.cover)),
                            );
                          }),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
