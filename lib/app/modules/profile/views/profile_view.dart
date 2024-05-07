import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  String? role;
  int? id;
  ProfileView({String? role});

  @override
  Widget build(BuildContext context) {
    controller.id = id;
    controller.role = role;
    return Scaffold(
      backgroundColor: Color(0xFFFe4c1f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFF735DA5),
        title: Text(
          'Gestion Utilisateur',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: controller.role == "admin"
          ? Drawer(
        backgroundColor: Color(0xFFFc19ee0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFe4c1f9),
              ),
              child: SizedBox(
                height: 50.0,
                child: Center(
                  child: Text(
                    'Gestionnaire',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Gestion utilisateur'),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
            ListTile(
              title: Text('Gestion Quizs'),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
            ListTile(
              title: Text('Gestion Questions'),
              onTap: () {
                // Action à effectuer lors du clic sur cet élément
              },
            ),
          ],
        ),
      )
          : null,
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              var user = controller.users[index];
              return ListTile(
                title: Text(user.email ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username ?? ''),
                    Text('Roles: ${user.roles?.map((role) => role.name).join(
                        ", ") ?? ''}'),
                  ],
                ),
              );
            },
          );
        }
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchAllUsers();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
