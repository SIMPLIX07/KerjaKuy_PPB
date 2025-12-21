import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db_helper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePerusahaanPage extends StatefulWidget {
  final int perusahaanId;
  final String namaPerusahaan;

  const EditProfilePerusahaanPage({
    super.key,
    required this.perusahaanId,
    required this.namaPerusahaan,
  });

  @override
  State<EditProfilePerusahaanPage> createState() =>
      _EditProfilePerusahaanPageState();
}

class _EditProfilePerusahaanPageState extends State<EditProfilePerusahaanPage> {
  final _email = TextEditingController();
  final _alamat = TextEditingController();
  final _deskripsi = TextEditingController();
  final _noTelepon = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  String? photoProfile;
  String? photoBackground;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _email.dispose();
    _alamat.dispose();
    _deskripsi.dispose();
    _noTelepon.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final data = await DBHelper.getPerusahaanById(widget.perusahaanId);
    if (data != null) {
      _email.text = data['email'] ?? '';
      _alamat.text = data['alamat'] ?? '';
      _deskripsi.text = data['deskripsi'] ?? '';
      _noTelepon.text = data['noTelepon'] ?? '';
      photoProfile = data['photo_profile'];
      photoBackground = data['photo_background'];
      setState(() {});
    }
  }

  Future<void> _pickImage(bool isProfile) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      if (isProfile) {
        photoProfile = file.path;
      } else {
        photoBackground = file.path;
      }
    });
  }

  Future<void> _save() async {
    if (_password.text.isNotEmpty && _password.text != _confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password dan konfirmasi tidak sama"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await DBHelper.updatePerusahaan(
      perusahaanId: widget.perusahaanId,
      email: _email.text,
      alamat: _alamat.text,
      deskripsi: _deskripsi.text,
      noTelepon: _noTelepon.text,
      password: _password.text.isNotEmpty ? _password.text : null,
      photoProfile: photoProfile,
      photoBackground: photoBackground,
    );

    if (mounted) {
      Navigator.pop(context, true); // 🔥 trigger refresh halaman sebelumnya
    }
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(false),
                        child: Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: photoBackground != null
                                ? DecorationImage(
                                    image: FileImage(File(photoBackground!)),
                                    fit: BoxFit.cover,
                                  )
                                : const DecorationImage(
                                    image: AssetImage(
                                      "lib/assets/header_bg.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),

                      Container(
                        height: 220,
                        color: Colors.black.withOpacity(0.35),
                      ),

                      Positioned(
                        bottom: 18,
                        left: 18,
                        child: GestureDetector(
                          onTap: () => _pickImage(true),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: photoProfile != null
                                  ? DecorationImage(
                                      image: FileImage(File(photoProfile!)),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: Colors.white,
                            ),
                            child: photoProfile == null
                                ? const Icon(Icons.business, size: 30)
                                : null,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 32,
                        left: 90,
                        right: 16,
                        child: Text(
                          widget.namaPerusahaan,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// ================= FORM =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  _field("Email", _email),
                  _field("Alamat", _alamat),
                  _field("Deskripsi", _deskripsi, maxLines: 3),
                  _field("No Telepon", _noTelepon),

                  const SizedBox(height: 10),
                  const Divider(),

                  _field("Password Baru", _password, obscure: true),
                  _field(
                    "Konfirmasi Password",
                    _confirmPassword,
                    obscure: true,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28AE9D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Simpan Perubahan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
