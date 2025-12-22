import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../../database/db_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final isValid =
        _nameController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty;

    if (isValid != _isFormValid) {
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
            // =================== BAGIAN ATAS ===================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      "Masuk ke KerjaKuy",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Hai calon Jobhunters ! Silahkan masuk\nmenggunakan akun anda.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 28),

                    // SOCIAL BUTTONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.facebook,
                            size: 32,
                            color: Colors.blue,
                          ),
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
                          child: Icon(
                            Icons.apple,
                            size: 32,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // USERNAME
                    _buildTextLabel("Username"),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan username anda.",
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(),

                    // PASSWORD
                    _buildTextLabel("Kata Sandi"),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Masukkan kata sandi anda.",
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // =================== BAGIAN BAWAH ===================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _isFormValid
                        ? () async {
                            final user = await DBHelper.loginUser(
                              usernameOrEmail: _nameController.text,
                              password: _passwordController.text,
                            );

                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    username: user['username'],
                                    jobTitle: user['pekerjaan'],
                                    userId: user['id'],
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Username atau Password tidak valid",
                                  ),
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

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Lupa kata sandi?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF28AE9D),
                        fontWeight: FontWeight.w600,
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
