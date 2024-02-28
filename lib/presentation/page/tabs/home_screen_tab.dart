import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:flutter_application_1/presentation/bloc/home_screen_bloc/tab_bloc/tab_bloc.dart';
import 'package:flutter_application_1/presentation/page/tabs/earn_money_tab.dart';
import 'package:flutter_application_1/presentation/page/tabs/learn_courses_tab.dart';
import 'package:flutter_application_1/presentation/page/tabs/my_connects_tab.dart';
import 'package:flutter_application_1/presentation/page/tabs/my_profile.dart';
import 'package:flutter_application_1/presentation/page/tabs/privacy_policy.dart';
import 'package:flutter_application_1/presentation/widgets/home_screen_widgets.dart';
import 'package:flutter_application_1/presentation/widgets/menu_drawer_widget.dart';
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
  late String? name = ' ';
  late String? phone = ' ';
  late String? uuid = ' ';
  late String? id = '';

  List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home_filled),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_library_outlined),
      label: 'Learn',
      activeIcon: Icon(Icons.local_library_rounded),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.currency_rupee_outlined),
      activeIcon: Icon(Icons.currency_rupee_sharp),
      label: 'Earn',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.contacts_outlined),
      activeIcon: Icon(Icons.contacts_rounded),
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
        child: Scaffold(
          appBar: AppBar(
            title:  Text("CodingCloud" , style: GoogleFonts.montserrat(fontSize:25, fontWeight : FontWeight.w500),),
            backgroundColor: const Color(0xFF8AD9FF),
          ),
          bottomNavigationBar: BlocConsumer<TabBloc, TabState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor:  Color(0xFF8AD9FF),
                items: bottomNavItems,
                currentIndex: state.tabIndex,
                selectedItemColor: Color.fromARGB(255, 44, 72, 87),
                unselectedItemColor: Colors.black26,
                onTap: (index) {
                  BlocProvider.of<TabBloc>(context)
                      .add(TabChangeEvent(tabIndex: index));
                },
              );
            },
          ),
          drawer: MenuDrawer(
            name: name,
            profileUrl: profileUrl,
            phone: phone,
          ),
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
                return Animate(effects: const [
                  FadeEffect(duration: Duration(milliseconds: 300)),
                  ScaleEffect(duration: Duration(milliseconds: 300))
                ], child: LearnCourses());
              } else if (state.tabIndex == 2) {
                return Animate(effects: const [
                  FadeEffect(duration: Duration(milliseconds: 300)),
                  ScaleEffect(duration: Duration(milliseconds: 300))
                ], child: EarnMoney());
              } else if (state.tabIndex == 3) {}
              return Animate(
                  effects: const [
                    FadeEffect(duration: Duration(milliseconds: 300)),
                    ScaleEffect(duration: Duration(milliseconds: 300))
                  ],
                  child: MyConnects(
                    id: uuid!,
                  ));
            },
          ),
        ));
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
