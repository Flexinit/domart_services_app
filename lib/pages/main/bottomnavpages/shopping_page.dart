import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soko/pages/payments/shopping_checkout.dart';

import 'data.dart';
import 'item.dart';

void main() {
  runApp(ShoppingPage());
}

/*class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buy Delicious Honey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "Montserrat",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
*/


class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Row(
                  children: [
                    /*Image.asset(
                      'assets/menuicon.png',
                      height: 25,
                    ),*/
                    Expanded(
                      child: Container(),
                    ),
                   // FaIcon(FontAwesomeIcons.search),
                    SizedBox(
                      width: 25,
                    ),
                  // Icon(Icons.shopping_bag)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sweet Honey',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                    Text(
                      'See All',
                      style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.73),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShoppingCheckout(data[index]['name'], data[index]['price'])));

                             /* MaterialPageRoute(
                                builder: (context) => Item(),
                              ),*/
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Color(data[index]['color']),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 55,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 55,
                                            backgroundColor:
                                            Color(data[index]['color'])
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        Image.network(
                                          data[index]['image'],
                                          height: 160,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(data[index]['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                              Text(
                                r'Kshs.' + data[index]['price'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}