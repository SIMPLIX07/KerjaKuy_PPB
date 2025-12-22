import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../home/home_page.dart';
import '../../database/db_helper.dart';
import '../../pages/home/home_page_perusahaan.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _photoProfile;
  File? _photoBackground;

  Future<void> _pickImage(bool isProfile) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (picked != null) {
      setState(() {
        if (isProfile) {
          _photoProfile = File(picked.path);
        } else {
          _photoBackground = File(picked.path);
        }
      });
    }
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _alamat = TextEditingController();
  final _deskripsi = TextEditingController();
  final _noTelepon = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _emailController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
    _confirmPasswordController.addListener(_checkFormValidity);
    _alamat.addListener(_checkFormValidity);
    _deskripsi.addListener(_checkFormValidity);
    _noTelepon.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _alamat.dispose();
    _deskripsi.dispose();
    _noTelepon.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final isValid =
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _alamat.text.isNotEmpty &&
        _deskripsi.text.isNotEmpty &&
        _noTelepon.text.isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  // Helper Widget
  Widget _buildTextLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 16),
      child: Text(
        text,
        style: TextStyle(color: Color(0xFF28AE9D), fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),

              Text(
                "Daftar KerjaKuy",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8),

              Text(
                "Hai calon Jobhunters ! Silahkan mendaftar\nmenggunakan email atau akun sosial media.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 28),

              /// SOCIAL BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.facebook, size: 32, color: Colors.blue),
                  ),
                  SizedBox(width: 18),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.mail, size: 32, color: Colors.red),
                  ),
                  SizedBox(width: 18),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.apple, size: 32, color: Colors.black),
                  ),
                ],
              ),

              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR", style: TextStyle(color: Colors.black45)),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),

              SizedBox(height: 30),
              // Nama
              _buildTextLabel("nama Perusahaan"),
              TextField(
                controller: _nameController, 
                decoration: InputDecoration(
                  hintText: "Masukkan nama Perusahaan anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Email
              _buildTextLabel("Email"),
              TextField(
                controller: _emailController, 
                decoration: InputDecoration(
                  hintText: "Masukkan email anda disini.",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              Divider(),

              // Kata Sandi
              _buildTextLabel("Buat Kata Sandi"),
              TextField(
                controller: _passwordController, 
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukkan kata sandi anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Konfirmasi Kata Sandi
              _buildTextLabel("Konfirmasi Kata Sandi"),
              TextField(
                controller:
                    _confirmPasswordController, 
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Konfirmasi kata sandi anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Konfirmasi Kata Sandi
              _buildTextLabel("Alamat"),
              TextField(
                controller: _alamat, 
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Jl. Bojongsoang Kec Sukabirus",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Konfirmasi Kata Sandi
              _buildTextLabel("Deskripsi"),
              TextField(
                controller: _deskripsi, 
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Masukan deskripsi perusahaan ana",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              _buildTextLabel("Foto Profile Perusahaan"),
              GestureDetector(
                onTap: () => _pickImage(true),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    image: _photoProfile != null
                        ? DecorationImage(
                            image: FileImage(_photoProfile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _photoProfile == null
                      ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                      : null,
                ),
              ),

              _buildTextLabel("Foto Background Perusahaan"),
              GestureDetector(
                onTap: () => _pickImage(false),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    image: _photoBackground != null
                        ? DecorationImage(
                            image: FileImage(_photoBackground!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _photoBackground == null
                      ? Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                ),
              ),

              // Konfirmasi Kata Sandi
              _buildTextLabel("NoTelepon"),
              TextField(
                controller: _noTelepon, 
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "+62xxxxxx",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isFormValid
                    ? () async {
                        // Cek Format Email
                        if (!_emailController.text.contains('@') ||
                            !_emailController.text.contains('.')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Format email salah (harus ada @ dan .)",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Cek Panjang Password
                        if (_passwordController.text.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Password minimal harus 8 karakter!",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Cek Kesamaan Password
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Konfirmasi password tidak cocok!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        try {
                          int userId = await DBHelper.registerPerusahaan(
                            namaPerusahaan: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            deskripsi: _deskripsi.text,
                            alamat: _alamat.text,
                            noTelepon: _noTelepon.text,
                            photoProfile: _photoProfile?.path,
                            photoBackground: _photoBackground?.path,
                          );

                          print("=== DATA PERUSAHAAN BERHASIL DIKIRIM ===");
                          print("ID Perusahaan   : $userId");
                          print("Nama Perusahaan : ${_nameController.text}");
                          print("Email           : ${_emailController.text}");
                          print(
                            "Password        : ${_passwordController.text}",
                          );
                          print("Alamat          : ${_alamat.text}");
                          print("Deskripsi       : ${_deskripsi.text}");
                          print("No Telepon      : ${_noTelepon.text}");
                          print("========================================");

                          // NOTIFIKASI BERHASIL
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Pendaftaran berhasil"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // NAVIGASI KE HOME PERUSAHAAN
                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePagePerusahaan(
                                  perusahaanId: userId,
                                  namaPerusahaan: _nameController.text,
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          print("Database Error: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Email atau Nama Perusahaan sudah terdaftar!",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid
                      ? Color(0xFF28AE9D)
                      : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Daftar"),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
