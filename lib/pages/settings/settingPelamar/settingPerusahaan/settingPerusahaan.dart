import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:flutter_application_1/pages/pilihRole/pilihRole.dart';
import 'package:flutter_application_1/pages/settings/settingPelamar/settingPerusahaan/edit_profile_perusahaan.dart';

class ProfilePage extends StatefulWidget {
  final int perusahaanId;
  final String namaPerusahaan;

  const ProfilePage({
    super.key,
    required this.perusahaanId,
    required this.namaPerusahaan,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? perusahaan;

  @override
  void initState() {
    super.initState();
    _loadPerusahaan();
  }

  Future<void> _loadPerusahaan() async {
    final data = await DBHelper.getPerusahaanById(widget.perusahaanId);
    setState(() {
      perusahaan = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ),

            // Photo + Name
            Column(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                    image:
                        perusahaan?['photo_profile'] != null &&
                            perusahaan!['photo_profile'].toString().isNotEmpty
                        ? DecorationImage(
                            image: FileImage(
                              File(perusahaan!['photo_profile']),
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      perusahaan?['photo_profile'] == null ||
                          perusahaan!['photo_profile'].toString().isEmpty
                      ? const Icon(
                          Icons.business,
                          size: 60,
                          color: Colors.white,
                        )
                      : null,
                ),

                const SizedBox(height: 8),
                Text(
                  widget.namaPerusahaan,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfilePerusahaanPage(
                              perusahaanId: widget.perusahaanId,
                              namaPerusahaan: widget.namaPerusahaan,
                            ),
                          ),
                        );

                        if (result == true) {
                          _loadPerusahaan();
                        }
                      },
                    ),

                    _menuTile(
                      icon: Icons.info_outline,
                      text: "Informasi Perusahaan",
                      onTap: () {},
                    ),
                    _menuTile(
                      icon: Icons.settings,
                      text: "Pengaturan Aplikasi",
                      onTap: () {},
                    ),
                    _menuTile(
                      icon: Icons.logout,
                      text: "Logout",
                      onTap: () => _logout(context),
                    ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Logout sama persis dengan pelamar
  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LandingPage()),
      (route) => false,
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
      onTap: onTap,
    );
  }
}
