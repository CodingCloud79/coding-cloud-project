import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
            ListTile(
              title: const Row(children: [
                Icon(Icons.home_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("Home")
              ]),
              onTap: () {
                debugPrint("Drawer : Home ");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.person_outline),
                SizedBox(
                  width: 10,
                ),
                Text("My Profile ")
              ]),
              onTap: () {
                debugPrint("Drawer : My Profile ");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.contacts_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("My Contacts")
              ]),
              onTap: () {
                debugPrint("Drawer : My Contacts ");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.attach_money),
                SizedBox(
                  width: 10,
                ),
                Text("Reward Points ")
              ]),
              onTap: () {
                debugPrint("Drawer : Reward Points ");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.payments_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("Withdrawls")
              ]),
              onTap: () {
                debugPrint("Drawer : Withdrawls");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.local_library_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("Learn New Course ")
              ]),
              onTap: () {
                debugPrint("Drawer : Learn New Course ");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.info_outline),
                SizedBox(
                  width: 10,
                ),
                Text("Privacy Policy")
              ]),
              onTap: () {
                debugPrint("Drawer : Privacy Policy");
              },
            ),
            ListTile(
              title: const Row(children: [
                Icon(Icons.logout),
                SizedBox(
                  width: 10,
                ),
                Text("Logout")
              ]),
              onTap: () {
                debugPrint("Drawer : Logout");
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {}, icon: Icon(Icons.local_library_outlined)),
            label: "Learn",
          ),
          BottomNavigationBarItem(
            icon:
                IconButton(onPressed: () {}, icon: Icon(Icons.currency_rupee)),
            label: "Earn",
          ),
          BottomNavigationBarItem(
            icon: IconButton(onPressed: () {}, icon: Icon(Icons.contacts)),
            label: "My Contacts ",
          ),
        ],
      ),
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
