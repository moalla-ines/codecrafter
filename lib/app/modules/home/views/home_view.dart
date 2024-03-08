import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final List<String> images = [
    "assets/images/Angular.png",
    "assets/images/C++.png",
    "assets/images/Laravel.png",
    "assets/images/flutter.png",
    "assets/images/java.png",
    "assets/images/js.png",
    "assets/images/Python-logo.png",
    "assets/images/react.png"
  ];

  final List<String> languages = [
    "Angular",
    "C++",
    "Laravel",
    "Flutter",
    "Java",
    "JavaScript",
    "Python",
    "React",
    // Ajoutez ici les noms des autres langages
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFe4c1f9),

      appBar: AppBar(  backgroundColor: Color(0xFFF735DA5) ,title: Text(
        'Home',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      ),
      body: _buildGridView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGridView() {
    return Stack(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildGridTile(index);
          },
        ),
             ],
    );
  }

  Widget _buildGridTile(int index) {
    return GridTile(
      child: Container(
        color: Color(0xFFFc19ee0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                languages[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 30.0),
              Image.asset(
                images[index],
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
//#1E2761, #408EC6, #7A2048
  Widget _buildBottomNavigationBar() {
    return Obx(() => GNav(
      backgroundColor: Color(0xFFF735DA5) ,

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
}
// 735DA5, #D3C5E5

