import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _homeScreenBloc = HomeScreenBloc();
  List<int> list = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      bloc: _homeScreenBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          drawer: _drawer(),
          bottomNavigationBar: _bottomNavBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 18 / 9,
                        viewportFraction: 1),
                    items: list
                        .map((item) => Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  item.toString(),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Share.share("Fefer to your Friend",
                                subject: "Referal");
                          },
                          child: _card("Refer Friends")),
                      GestureDetector(
                          onTap: () {}, child: _card("My Earning ")),
                      GestureDetector(onTap: () {}, child: _card("My Course "))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Quiz ",
                          style: GoogleFonts.montserrat(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top Contributor ",
                        style: GoogleFonts.montserrat(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          _contributor(),
                          _contributor(),
                          _contributor(),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _card(String label) {
    return Container(
      height: 80,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        label,
        textAlign: TextAlign.center,
      )),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String label, Icon icon, VoidCallback onPressed) {
    return BottomNavigationBarItem(
      icon: IconButton(onPressed: onPressed, icon: icon),
      label: label,
    );
  }

  ListTile _listTile(Icon icon, String label, VoidCallback onTap) {
    return ListTile(
      title: Row(children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(label)
      ]),
      onTap: onTap,
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          _listTile(const Icon(Icons.home_outlined), "Home", () {
            debugPrint("Drawer : Home ");
          }),
          _listTile(const Icon(Icons.person_outline), "My Profile", () {
            debugPrint("Drawer : My Profile ");
          }),
          _listTile(const Icon(Icons.contacts_outlined), "My Contacts", () {
            debugPrint("Drawer : My Contacts ");
          }),
          _listTile(const Icon(Icons.attach_money), "Reward Points", () {
            debugPrint("Drawer : Reward Points ");
          }),
          _listTile(const Icon(Icons.payments_outlined), "Withdrawls", () {
            debugPrint("Drawer : Withdrawls");
          }),
          _listTile(
              const Icon(Icons.local_library_outlined), "Learn New Course", () {
            debugPrint("Drawer : Learn New Course ");
          }),
          _listTile(const Icon(Icons.info_outline), "Privacy Policy", () {
            debugPrint("Drawer : Privacy Policy");
          }),
          _listTile(const Icon(Icons.logout), "Logout", () {
            debugPrint("Drawer : Logout");
          })
        ],
      ),
    );
  }

  Widget _contributor() {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Icon(
        Icons.person,
        size: 32,
        color: Colors.grey,
      ),
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _bottomNavigationBarItem(
          "Home ",
          const Icon(Icons.home),
          () {
            debugPrint("BNB : Home");
          },
        ),
        _bottomNavigationBarItem(
          "Learn ",
          const Icon(Icons.local_library_outlined),
          () {
            debugPrint("BNB : Learn");
          },
        ),
        _bottomNavigationBarItem(
          "Earn",
          const Icon(Icons.currency_rupee),
          () {
            debugPrint("BNB : Earn ");
          },
        ),
        _bottomNavigationBarItem(
          "My Contacts",
          const Icon(Icons.contacts),
          () {
            debugPrint("BNB :  My Contacts ");
          },
        )
      ],
    );
  }
}
