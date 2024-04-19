import 'package:codecrafter/app/modules/niveau/views/niveau_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  int? id;
  HomeView({this.id});

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
  ];

  @override
  Widget build(BuildContext context) {
    controller.id = id;
    return Scaffold(
      backgroundColor: Color(0xFFFe4c1f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF735DA5),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildGridView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
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
    );
  }

  Widget _buildGridTile(int index) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          String imageUrl =
          images[index]; // Récupère l'URL de l'image sélectionnée
          Get.to(() => NiveauView(imageUrl: imageUrl));
        },
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
      ),
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
}
