import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/presentation/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:flutter_application_1/presentation/page/enter_phone_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/home_screen_bloc/home_screen_bloc.dart';
import '../bloc/home_screen_bloc/tab_bloc/tab_bloc.dart';
import '../page/tabs/my_profile.dart';
import '../page/tabs/privacy_policy.dart';

// ignore: must_be_immutable
class MenuDrawer extends StatefulWidget {
  final String? profileUrl;
  final String? name;
  final String? phone;

  MenuDrawer({
    super.key,
    this.profileUrl,
    this.name,
    this.phone,
  });

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  int tabindex = 0;
  Widget _listTile(Icon icon, String label, VoidCallback onTap) {
    return ListTile(
      selectedColor: const Color(0xFF629AB5),
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

  HomeScreenBloc _homeScreenBloc = HomeScreenBloc();
  MyProfileBloc _myProfileBloc = MyProfileBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        bloc: _homeScreenBloc,
        listener: (context, state) {
          if (state is NavigateToPrivacyPolicyState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
          } else if (state is NavigateToMyProfileState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyProfile()));
          } else if (state is HomeScreenLogoutState) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Logout '),
                content: const Text('Are are sure you want to Logout ?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences _prefs =
                          await SharedPreferences.getInstance();
                      _prefs.clear();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PhoneScreen(),
                        ),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 70,
                      color: const Color(0xFF8AD9FF),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 105,
                      left: 105,
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(52),
                          color: Colors.white,
                          border: Border.all(
                            width: 4,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Colors.white,
                          ),
                        ),
                        child: widget.profileUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 76,
                                color: Colors.grey,
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyProfile(),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'profileImage',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      widget.profileUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              _listTile(const Icon(Icons.home_outlined), "Home", () {
                debugPrint("Drawer : Home ");
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 0));
                // _homeScreenBloc.add(NavigateToHomeTabEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 0));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.person_outline), "My Profile", () {
                debugPrint("Drawer : My Profile ");
                _homeScreenBloc.add(NavigateToMyProfileEvent());
                // _myProfileBloc.add(LoadMyProfileEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 1));
              }),
              _listTile(const Icon(Icons.contacts_outlined), "My Connects", () {
                debugPrint("Drawer : My Connects ");
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 3));
                _homeScreenBloc.add(NavigateToMyConnectsTabEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 2));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.attach_money), "Reward Points", () {
                debugPrint("Drawer : Reward Points ");
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 2));
                _homeScreenBloc.add(NavigateToRewardPointsEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 3));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.payments_outlined), "Withdrawls", () {
                debugPrint("Drawer : Withdrawls");
                _homeScreenBloc.add(NavigateToWithdrawlsEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 4));
                Navigator.pop(context);
              }),
              _listTile(
                  const Icon(Icons.local_library_outlined), "Learn New Course",
                  () {
                debugPrint("Drawer : Learn New Course ");
                _homeScreenBloc.add(NavigateToLearnTabEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 5));
                Navigator.pop(context);
                BlocProvider.of<TabBloc>(context)
                    .add(TabChangeEvent(tabIndex: 1));
              }),
              _listTile(const Icon(Icons.info_outline), "Privacy Policy", () {
                debugPrint("Drawer : Privacy Policy");
                _homeScreenBloc.add(NavigateToPrivacyPolicyEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 6));
              }),
              _listTile(const Icon(Icons.logout), "Logout", () {
                debugPrint("Drawer : Logout");
                _homeScreenBloc.add(HomeScreenLogoutEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 7));
              })
            ],
          );
        },
      ),
    );
  }
}
