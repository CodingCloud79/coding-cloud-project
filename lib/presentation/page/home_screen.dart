import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/tab_bloc/tab_bloc.dart';
import 'package:flutter_application_1/presentation/page/tabs/earn_money.dart';
import 'package:flutter_application_1/presentation/page/tabs/learn_courses_tab.dart';
import 'package:flutter_application_1/presentation/page/tabs/my_connects_tab.dart';
import 'package:flutter_application_1/presentation/page/tabs/my_profile.dart';
import 'package:flutter_application_1/presentation/page/tabs/privacy_policy.dart';
import 'package:flutter_application_1/presentation/widgets/home_screen_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenBloc _homeScreenBloc = HomeScreenBloc();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  List<int> list = [1, 2, 3, 4, 5];
  late String? profileUrl = '';
  late String? name;
  late String? phone;
  late String? uuid;
  late String? id;

  List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_library_outlined),
      label: 'Learn',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.currency_rupee),
      label: 'Earn',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.contacts),
      label: 'My Connects',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabBloc>(
          create: (BuildContext context) => TabBloc(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (BuildContext context) => HomeScreenBloc(),
        ),
      ],
      child: BlocConsumer<TabBloc, TabState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar( title: const Text("CodingCloud"),),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: index));
              },
            ),
            drawer: _drawer(),
            body: BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                if (state.tabIndex == 0) {
                  return Animate(
                    effects: const [
                      FadeEffect(duration: Duration(milliseconds: 300)),
                      SlideEffect(
                          begin: Offset(-1.0, 0.0),
                          duration: Duration(milliseconds: 500))
                    ],
                    child: HomeTabWidget(),
                  );
                } else if (state.tabIndex == 1) {
                  return Animate(
                    effects: const [
                      FadeEffect(duration: Duration(milliseconds: 300)),
                      ScaleEffect(duration: Duration(milliseconds: 300))
                    ],
                    child: LearnCourses()
                  );
                } else if (state.tabIndex == 2) {
                  return Animate(
                    effects: const [
                      FadeEffect(duration: Duration(milliseconds: 300)),
                      ScaleEffect(duration: Duration(milliseconds: 300))
                    ],
                    child: EarnMoney()
                  );
                } else if (state.tabIndex == 3) {}
                return Animate(effects: const [
                  FadeEffect(duration: Duration(milliseconds: 300)),
                  ScaleEffect(duration: Duration(milliseconds: 300))
                ], child: MyConnects(id: uuid!,));
              },
            ),
          );
        },
      ),
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
      child: BlocConsumer<TabBloc, TabState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          child: profileUrl == null
                              ? const Icon(
                                  Icons.person,
                                  size: 64,
                                  color: Colors.grey,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    profileUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        name!,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "+91 $phone ",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              _listTile(const Icon(Icons.home_outlined), "Home", () {
                debugPrint("Drawer : Home ");
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 0));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.person_outline), "My Profile", () {
                debugPrint("Drawer : My Profile ");
                _homeScreenBloc.add(NavigateToMyProfileEvent());
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyProfile()));
              }),
              _listTile(const Icon(Icons.contacts_outlined), "My Connects", () {
                debugPrint("Drawer : My Connects ");
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 3));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.attach_money), "Reward Points", () {
                debugPrint("Drawer : Reward Points ");
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 2));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.payments_outlined), "Withdrawls", () {
                debugPrint("Drawer : Withdrawls");
                _homeScreenBloc.add(NavigateToWithdrawlsEvent());
                Navigator.pop(context);
              }),
              _listTile(
                  const Icon(Icons.local_library_outlined), "Learn New Course",
                  () {
                debugPrint("Drawer : Learn New Course ");
                  Navigator.pop(context);
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 1));
              }),
              _listTile(const Icon(Icons.info_outline), "Privacy Policy", () {
                debugPrint("Drawer : Privacy Policy");
                _homeScreenBloc.add(NavigateToPrivacyPolicyEvent());
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicy()));

              }),
              _listTile(const Icon(Icons.logout), "Logout", () {
                debugPrint("Drawer : Logout");
              })
            ],
          );
        },
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

  Future<void> getData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs.getString('name');
      profileUrl = _prefs.getString('profileUrl');
      phone = _prefs.getString('phone');
      uuid = _prefs.getString('uuid');
    });
  }
}
