import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../pages/home/home_page_perusahaan.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final isValid =
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  Widget _buildTextLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF28AE9D),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // BAGIAN ATAS
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      "Masuk Akun Perusahaan",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Gunakan email dan password akun perusahaan Anda.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    // Email
                    _buildTextLabel("Email Perusahaan"),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan email perusahaan disini.",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Divider(),

                    // Kata Sandi
                    _buildTextLabel("Kata Sandi"),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Masukkan kata sandi akun perusahaan.",
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),

            // BAGIAN BAWAH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _isFormValid
                        ? () async {
                            final perusahaan = await DBHelper.loginPerusahaan(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            if (perusahaan != null) {
                              print("=== LOGIN PERUSAHAAN BERHASIL ===");
                              print("ID Perusahaan   : ${perusahaan['id']}");
                              print(
                                "Nama Perusahaan : ${perusahaan['nama_perusahaan']}",
                              );
                              print("Email           : ${perusahaan['email']}");
                              print(
                                "Deskripsi       : ${perusahaan['deskripsi']}",
                              );
                              print(
                                "Alamat          : ${perusahaan['alamat']}",
                              );
                              print(
                                "No Telepon      : ${perusahaan['no_telepon']}",
                              );
                              print(
                                "===========================================",
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Login berhasil"),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              // sementara belum ada HomePerusahaan
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePagePerusahaan(
                                    namaPerusahaan:
                                        perusahaan['namaPerusahaan'],
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Email atau Password salah"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid
                          ? const Color(0xFF28AE9D)
                          : Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Masuk"),
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
