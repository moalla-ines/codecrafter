import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/home_controller.dart';
import 'home_view.dart';


class SettingsView extends GetView<HomeController> {
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFD3C5E5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF735DA5),
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 22, color: Colors.white , fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      "Account",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF735DA5)),
                    ),
                    trailing: Icon(
                      Icons.person,
                      color: Color(0xFFF735DA5),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.lock_clock_outlined,
                            color: Color(0xFFF735DA5)),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      _buildExpansionTile(context, "Change Language",
                          Color(0xFFFE5D4FF)),
                      _buildDivider(),
                      ListTile(
                        leading: Icon(Icons.location_pin, color: Color(0xFFF735DA5)),
                        title: Text("Change Location "),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                        "Notification Settings",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF735DA5),
                        )
                    ),
                  ),
                ),
                SwitchListTile(
                  activeColor: Color(0xFFF735DA5),
                  contentPadding: const EdgeInsets.all(5),
                  value: true,
                  title: Text("Received Notification"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color(0xFFF735DA5),
                  contentPadding: const EdgeInsets.all(5),
                  value: true,
                  title: Text("Received offer Notification"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color(0xFFF735DA5),
                  contentPadding: const EdgeInsets.all(5),
                  value: false,
                  title: Text("Received Newsletter"),
                  onChanged: (val) {},
                ),
                SwitchListTile(
                  activeColor: Color(0xFFF735DA5),
                  contentPadding: const EdgeInsets.all(5),
                  value: false,
                  title: Text("Received App Updates"),
                  onChanged: (val) {},
                ),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => GNav(
      backgroundColor: Color(0xFFF735DA5),
      color: Colors.white,
      activeColor: Color(0xFFF735DA5),
      tabBackgroundColor: Colors.grey.shade50,
      padding: EdgeInsets.all(20),
      gap: 8,
      selectedIndex: controller.selectedIndex.value,
      onTabChange: controller.onItemTapped,
      tabs: [
        GButton(icon: Icons.settings, text: 'Settings'),
        GButton(icon: Icons.home, text: 'Home'),
        GButton(icon: Icons.list, text: 'List'),
      ],
    ));
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade200,
    );
  }

  Widget _buildExpansionTile(BuildContext context, String title, Color color) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      backgroundColor: color,
      children: [
        ListTile(
          title: Text(
            "Francais",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        ListTile(
          title: Text(
            "Anglais",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        ListTile(
          title: Text(
            "Arabe",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

