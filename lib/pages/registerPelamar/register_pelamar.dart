import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../../database/db_helper.dart';
import '../../services/profile_local_service.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk setiap TextField
  final _nameController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _skill = TextEditingController();

  // Variabel status untuk melacak validitas form
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Tambahkan listener ke setiap controller
    _nameController.addListener(_checkFormValidity);
    _fullnameController.addListener(_checkFormValidity);
    _emailController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
    _confirmPasswordController.addListener(_checkFormValidity);
    _skill.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    // Pastikan controller dibuang untuk menghindari kebocoran memori
    _nameController.dispose(); 
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _skill.dispose();
    super.dispose();
  }

  // Fungsi yang memeriksa apakah semua field sudah diisi
  void _checkFormValidity() {
    final isValid =
        _nameController.text.isNotEmpty &&
        _fullnameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _skill.text.isNotEmpty;

    // Hanya panggil setState jika status validitas berubah
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

              // INPUT FIELDS

              // Nama
              _buildTextLabel("Username"),
              TextField(
                controller: _nameController, 
                decoration: InputDecoration(
                  hintText: "Masukkan username anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Nama
              _buildTextLabel("Nama Lengkap"),
              TextField(
                controller: _fullnameController, 
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                decoration: InputDecoration(
                  hintText: "Masukkan nama anda disini.",
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
              _buildTextLabel("Keahlian"),
              TextField(
                controller: _skill, 
                obscureText: false,
                decoration: InputDecoration(
                  hintText:
                      "Masukan Keahlian paling Dominan(Rekomendasi berdasarkan keahlian anda)",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              SizedBox(height: 40),

              // Tombol Daftar
              ElevatedButton(
                // onPressed hanya aktif jika form valid (_isFormValid == true)
                onPressed: _isFormValid
                    ? () async {

                      String cleanUsername = _nameController.text.trim();
                        // Cek Username 
                        if (cleanUsername.contains(' ')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Username tidak boleh mengandung spasi!",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return; // Berhenti di sini, jangan lanjut ke database
                        }

                        final charRegExp = RegExp(
                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%/-]',
                        );
                        if (charRegExp.hasMatch(_fullnameController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Nama Lengkap tidak boleh mengandung karakter spesial!",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Cek Email 
                        if (!_emailController.text.trim().endsWith('@gmail.com')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Format email tidak valid",
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
                                "Password harus lebih dari 8 karakter!",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Konfirmasi Password
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

                        // Jika semua pengecekan sudaha benar, maka masuk ke database
                        try {
                          int userId = await DBHelper.registerUser(
                            fullname: _fullnameController.text.trim(),
                            username: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          List<String> skills = _skill.text.split(',');
                          for (var s in skills) {
                            if (s.trim().isNotEmpty) {
                              await DBHelper.tambahSkill(userId, s.trim());
                            }
                          }

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Registrasi Berhasil! Selamat berjuang mencari kerja.",
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }

                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  username: _nameController.text.trim(),
                                  userId: userId,
                                  jobTitle: "Pelamar",
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Registrasi Gagal. Username/Email mungkin sudah terdaftar.",
                              ),
                            ),
                          );
                        }
                      }
                    : null, // Jika tidak valid, tombol dinonaktifkan

                style: ElevatedButton.styleFrom(
                  // Perubahan Warna
                  backgroundColor: _isFormValid
                      ? Color(0xFF28AE9D) // Warna Hijau jika valid
                      : Colors.grey.shade300, // Warna Abu-abu jika tidak valid

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
