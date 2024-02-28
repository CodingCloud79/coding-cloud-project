import 'package:flutter/material.dart';
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
      selectedColor: Color(0xFF629AB5),
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        bloc: _homeScreenBloc,
        listener: (context, state) {
          if (state is NavigateToPrivacyPolicyState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()));
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
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF3A5B6B)),
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
                          child: widget.profileUrl == null
                              ? const Icon(
                                  Icons.person,
                                  size: 64,
                                  color: Colors.grey,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(
                                    widget.profileUrl!,
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
                        widget.name!,
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
                        "+91 ${widget.phone} ",
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
                // _homeScreenBloc.add(NavigateToHomeTabEvent());
                _homeScreenBloc.add(DrawerTabChangeEvent(tabIndex: 0));
                Navigator.pop(context);
              }),
              _listTile(const Icon(Icons.person_outline), "My Profile", () {
                debugPrint("Drawer : My Profile ");
                _homeScreenBloc.add(NavigateToMyProfileEvent());
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
