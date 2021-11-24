import 'package:darshan_consultancy/helper/phoneauth.dart';
import 'package:darshan_consultancy/page/document.dart';
import 'package:darshan_consultancy/page/drawer.dart';
import 'package:darshan_consultancy/page/test.dart';
import 'package:darshan_consultancy/widgets/button.dart';
// import 'package:darshan_consultancy/page/onBoading.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  AuthClass authClass = AuthClass();
  final GlobalKey<ScaffoldState> _keys = GlobalKey<ScaffoldState>();

  final List<String> imgList = [
    'assets/images/1.jpeg',
    'assets/images/2.jpeg',
    'assets/images/3.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerSide(),
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w900,
                fontSize: 25.0),
          ),

          elevation: 0,
          backgroundColor: Colors.transparent,
          // automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/1.jpeg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/2.jpeg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  //3rd Image of Slider
                  Container(
                    margin: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/3.jpeg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * .35,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.9,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Column(
                children: List.generate(5, (index) => profileCard(context)),
              ),

              Container(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFFf1faee),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  size: 55,
                                  color: Colors.black,
                                ),
                                radius: 35,
                                backgroundColor: Colors.transparent,
                              ),
                              Text(
                                "Mayank Pareshbhai",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 60,
                                  width: 60,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/aadhhar_card.png"),
                                  )),
                              Text(
                                "90547300132",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 60,
                                  width: 60,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/pan_card.jpg"),
                                  )),
                              Text(
                                "90547300132",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ]),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DocumentPage(),
        ));
      },
      child: Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color(0xFFf5f3f4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.black,
                        ),
                        radius: 35,
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        "Mayank Pareshbhai",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          child: Image(
                            image: AssetImage("assets/images/aadhhar_card.png"),
                          )),
                      Text(
                        "90547300132",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 60,
                          width: 60,
                          child: Image(
                            image: AssetImage("assets/images/pan_card.jpg"),
                          )),
                      Text(
                        "90547300132",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
