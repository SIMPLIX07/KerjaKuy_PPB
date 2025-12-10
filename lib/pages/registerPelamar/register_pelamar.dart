import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../../database/db_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 1. Controller untuk setiap TextField
  final _nameController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _skill = TextEditingController();

  // 2. Variabel status untuk melacak validitas form
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // 3. Tambahkan listener ke setiap controller
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

  // 4. Fungsi yang memeriksa apakah semua field sudah diisi
  void _checkFormValidity() {
    final name = _nameController.text.trim();
    final fullname = _fullnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final skill = _skill.text.trim();

    // Logika validitas: semua field harus tidak kosong (isNotEmpty)
    final isValid =
        (name.isNotEmpty &&
            fullname.isNotEmpty &&
            email.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            skill.isNotEmpty) &&
        password == confirmPassword;

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

              // --- INPUT FIELDS ---

              // Nama
              _buildTextLabel("Username"),
              TextField(
                controller: _nameController, // <-- Hubungkan controller
                decoration: InputDecoration(
                  hintText: "Masukkan username anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Nama
              _buildTextLabel("Nama Lengkap"),
              TextField(
                controller: _fullnameController, // <-- Hubungkan controller
                decoration: InputDecoration(
                  hintText: "Masukkan nama anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              // Email
              _buildTextLabel("Email"),
              TextField(
                controller: _emailController, // <-- Hubungkan controller
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
                controller: _passwordController, // <-- Hubungkan controller
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
                    _confirmPasswordController, // <-- Hubungkan controller
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
                controller: _skill, // <-- Hubungkan controller
                obscureText: false,
                decoration: InputDecoration(
                  hintText:
                      "Pisahkan dengan koma jika lebih dari 1 (Programming, Menggambar, Critical Thinking)",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              SizedBox(height: 40),

              // --- ELEVATED BUTTON (Tombol) ---
              ElevatedButton(
                // 5. onPressed hanya aktif jika form valid (_isFormValid == true)
                onPressed: _isFormValid
                    ? () async {
                        int userId = await DBHelper.registerUser(
                          fullname: _fullnameController.text,
                          username: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        List<String> skills = _skill.text.split(',');
                        for (var s in skills) {
                          await DBHelper.tambahSkill(userId, s.trim());
                        }
                        // Logika pendaftaran dan navigasi
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              username: _nameController.text,
                              userId: userId, 
                              jobTitle: "Pelamar",
                            ),
                          ),
                        );
                      }
                    : null, // Jika tidak valid, tombol dinonaktifkan

                style: ElevatedButton.styleFrom(
                  // 6. Logika Perubahan Warna
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
