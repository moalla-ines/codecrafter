import 'package:codecrafter/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



class ListViewPage extends GetView<HomeController> {
  ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFD3C5E5),
      appBar: AppBar(
        title: Text('List', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFFF735DA5),
      ),
      body: ListView(
        children: [
          _buildExpansionTile(context, "event 0", Colors.grey.shade100),
          _buildExpansionTile(context, "event 1", Colors.grey.shade100),
          _buildExpansionTile(context, "event 2", Colors.grey.shade100),
          _buildExpansionTile(context, "event 3", Colors.grey.shade100),
          _buildExpansionTile(context, "event 4", Colors.grey.shade100),
          _buildExpansionTile(context, "event 5", Colors.grey.shade100),
          _buildExpansionTile(context, "event 6", Colors.grey.shade100),
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

  Widget _buildExpansionTile(BuildContext context, String title, Color color) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 22, color: Color(0xFFF735DA5), fontWeight: FontWeight.w500),
      ),
      backgroundColor: color,
      children: [
        ListTile(
          title: Text("choisir niveau 1", style: TextStyle(color: Color(0xFFF735DA5))),
        ),
        ListTile(
          title: Text("choisir niveau 2", style: TextStyle(color: Color(0xFFF735DA5)) ),
        ),
        ListTile(
            title: Text("choisir niveau 3", style: TextStyle(color: Color(0xFFF735DA5)))),
      ],
    );
  }
}

