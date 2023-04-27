import 'package:ebook/app_colors.dart' as AppColors;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.background,
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
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      left: -30,
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 0.8),
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: 5,
                            itemBuilder: (_, i) {
                              return Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage("images/image-1.jpg"),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
