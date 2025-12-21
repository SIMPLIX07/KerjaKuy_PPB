import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'dart:io';
import 'package:flutter_application_1/pages/cvPelamar/buatCV.dart';
import 'package:flutter_application_1/pages/cvPelamar/cvPelamar.dart';
import 'package:flutter_application_1/pages/pilihRole/pilihRole.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/profile_local_service.dart';

class ProfilePage extends StatefulWidget {
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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text("Edit Profile"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<Map<String, dynamic>?>(
                    future: DBHelper.getUserById(widget.userId),
                    builder: (context, snapshot) {
                      final photoPath = snapshot.data?['photo_path'];

                      return CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF28AE9D),
                        backgroundImage:
                            photoPath != null && photoPath.toString().isNotEmpty
                            ? FileImage(File(photoPath))
                            : null,
                        child:
                            (photoPath == null || photoPath.toString().isEmpty)
                            ? const Icon(Icons.person, color: Colors.white)
                            : null,
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    onPressed: () async {
                      final picked = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 75,
                      );

                      if (picked != null) {
                        setDialogState(() {
                          _selectedImage = File(picked.path);
                        });
                      }
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text("Pilih Foto"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _selectedImage = null;
                    Navigator.pop(context);
                  },
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: _selectedImage == null
                      ? null
                      : () async {
                          await ProfileLocalService.saveProfileImage(
                            userId: widget.userId,
                            imageFile: _selectedImage!,
                          );

                          if (!mounted) return;

                          setState(() {
                            _selectedImage = null;
                          });

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Foto profile berhasil diperbarui"),
                            ),
                          );
                        },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                FutureBuilder<Map<String, dynamic>?>(
                  future: DBHelper.getUserById(widget.userId),
                  builder: (context, snapshot) {
                    final photoPath = snapshot.data?['photo_path'];

                    return CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFF28AE9D),
                      backgroundImage:
                          photoPath != null && photoPath.toString().isNotEmpty
                          ? FileImage(File(photoPath))
                          : null,
                      child: (photoPath == null || photoPath.toString().isEmpty)
                          ? const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white,
                            )
                          : null,
                    );
                  },
                ),

                SizedBox(height: 8),
                Text(
                  widget.nama,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.jobTitle,
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
                      onTap: _showEditProfileDialog,
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
                              userId: widget.userId, // data yang dikirim
                            ),
                          ),
                        );
                      },
                    ),
                    _menuTile(
                      icon: Icons.logout,
                      text: "Logout",
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LandingPage(),
                          ),
                          (route) => false,
                        );
                      },
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
