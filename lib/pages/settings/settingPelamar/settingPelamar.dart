import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/cvPelamar/buatCV.dart';
import 'package:flutter_application_1/pages/cvPelamar/cvPelamar.dart';

class ProfilePage extends StatelessWidget {
  final int userId;
  final String nama;
  final String jobTitle;
  const ProfilePage({
    super.key,
    required this.userId,
    required this.nama,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back icon + profile header
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            // Photo + Name + Role
            Column(
              children: [
                Icon(Icons.account_circle, size: 110, color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  nama,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  jobTitle,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
              ],
            ),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 18),
                    const Text(
                      "PROFILE",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    _menuTile(
                      icon: Icons.edit,
                      text: "Edit Profile",
                      onTap: () => print("Edit Profile tapped"),
                    ),
                    _menuTile(
                      icon: Icons.info_outline,
                      text: "Informasi Profile",
                      onTap: () => print("Informasi Profile tapped"),
                    ),
                    _menuTile(
                      icon: Icons.settings_suggest,
                      text: "Pengaturan Aplikasi",
                      onTap: () => print("Pengaturan Aplikasi tapped"),
                    ),
                    _menuTile(
                      icon: Icons.settings_suggest,
                      text: "CV Anda",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CVPage(
                              userId: userId, // data yang dikirim
                            ),
                          ),
                        );
                      },
                    ),
                    _menuTile(
                      icon: Icons.logout,
                      text: "Logout",
                      onTap: () => print("Logout tapped"),
                    ),

                    const SizedBox(height: 25),
                    const Text(
                      "TENTANG KITA",
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    _menuTile(
                      icon: Icons.shield_outlined,
                      text: "Kebijakan Privasi",
                      onTap: () => print("Kebijakan Privasi tapped"),
                    ),
                    _menuTile(
                      icon: Icons.check_circle_outline,
                      text: "Visi Misi",
                      onTap: () => print("Visi Misi tapped"),
                    ),
                    _menuTile(
                      icon: Icons.headset_mic,
                      text: "Pusat Bantuan",
                      onTap: () => print("Pusat Bantuan tapped"),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List tile custom
  Widget _menuTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: Icon(icon, size: 26),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
      onTap: onTap,
    );
  }
}
