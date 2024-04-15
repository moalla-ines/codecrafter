import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/home_controller.dart';

class SettingsView extends GetView<HomeController> {
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFD3C5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF735DA5),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildListTile("Account", Icons.person, () {}),
          const SizedBox(height: 10.0),
          _buildCard(ListTile(
            leading: const Icon(Icons.lock_clock_outlined, color: Color(0xFFF735DA5)),
            title: const Text("Change Password"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: controller.changePassword,
          )),
          _buildListTile("Notification Settings", null, () {}),
          _buildSwitchListTile("Received Notification", true),
          _buildSwitchListTile("Received offer Notification", true),
          _buildSwitchListTile("Received Newsletter", false),
          _buildSwitchListTile("Received App Updates", false),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildListTile(String title, IconData? icon, VoidCallback onTap) {
    return Card(
      color: Colors.grey.shade200,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFF735DA5)),
        ),
        trailing: icon != null ? Icon(icon, color: const Color(0xFFF735DA5)) : null,
      ),
    );
  }

  Widget _buildCard(Widget child) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: child,
    );
  }

  Widget _buildSwitchListTile(String title, bool value) {
    return SwitchListTile(
      activeColor: const Color(0xFFF735DA5),
      contentPadding: const EdgeInsets.all(5),
      value: value,
      title: Text(title),
      onChanged: (val) {},
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
          () => GNav(
        backgroundColor: const Color(0xFFF735DA5),
        color: Colors.white,
        activeColor: const Color(0xFFF735DA5),
        tabBackgroundColor: Colors.grey.shade50,
        padding: const EdgeInsets.all(20),
        gap: 8,
        selectedIndex: controller.selectedIndex.value,
        onTabChange: controller.onItemTapped,
        tabs: const [
          GButton(icon: Icons.settings, text: 'Settings'),
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.list, text: 'List'),
        ],
      ),
    );
  }
}

