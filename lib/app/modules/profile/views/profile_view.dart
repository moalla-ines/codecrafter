import 'package:codecrafter/app/modules/gestions/views/gestions_view.dart';
import 'package:codecrafter/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final String? role;
  final int? id;

  ProfileView({this.role, this.id});

  @override
  Widget build(BuildContext context) {
    controller.id = id;
    controller.role = role;
    return Scaffold(
      backgroundColor: const Color(0xFFFF1F1F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2C4E80),
        title: Text(
          'Gestion Utilisateur',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              for (var id in controller.selectedUser) {
                controller.onDeleteUsers(id);
              }
              controller.selectedUser.clear();
              Get.snackbar('Succès', 'Utilisateur supprimé avec succès !');
            },
          ),
        ],
      ),
      drawer: controller.role == "admin"
          ? Drawer(
        backgroundColor: Color(0xFFFF1F1F2),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF1F1F2),
              ),
              child: SizedBox(
                height: 50.0,
                child: Center(
                  child: Text(
                    'Gestionnaire',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
                Get.to(() => GestionsView(role: role, id: id));
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(() => HomeView(role: role, id: id));
                  },
                  child: Icon(Icons.home, color: Color(0xFFF2C4E80)),
                ),
              ),
            ),
          ],
        ),
      )
          : null,
      body: Obx(() {
        if (controller.users.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: Color(0xFFF2C4E80)),
          );
        } else {
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              var user = controller.users[index];
              return CheckboxListTile(
                checkColor: Color(0xFFF2C4E80),
                title: Text(user.email ?? '',style: TextStyle(color:Colors.black,fontSize: 18, fontWeight: FontWeight.w500)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username ?? '', style: TextStyle(color:Colors.black)),
                    Text('Roles: ${user.roles?.map((role) => role.name).join(", ") ?? ''}', style: TextStyle(color:Colors.black)),
                  ],
                ),
                value: controller.selectedUser.contains(user.id),
                onChanged: (value) {
                  if (value != null && value) {
                    controller.toggleUserSelection(user.id ?? 0);
                  }
                },
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF2C4E80),
        onPressed: () {
          controller.fetchAllUsers();
        },
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
