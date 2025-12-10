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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _emailController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
    _confirmPasswordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final isValid =
        _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
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
            // =============== BAGIAN ATAS (Tetap scrollable) ==================
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
                      "Hai calon Jobhunters ! Silahkan mendaftar\nmenggunakan email atau akun sosial media.",
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

                    // Username
                    _buildTextLabel("Username"),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan nama anda disini.",
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(),

                    // Email
                    _buildTextLabel("Email"),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Masukkan email anda disini.",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const Divider(),

                    // Kata sandi
                    _buildTextLabel("Kata Sandi"),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Masukkan kata sandi anda disini.",
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // =============== BAGIAN BAWAH (Fixed di bawah layar) ==================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // BUTTON MASUK
                  ElevatedButton(
                    onPressed: _isFormValid
                        ? () async {
                            final user = await DBHelper.loginUser(
                              usernameOrEmail: _nameController.text,
                              password: _passwordController.text,
                            );

                            if(user != null){
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  HomePage(
                                  
                                  username: user['username'],
                                  jobTitle: user['pekerjaan'],
                                  userId: user['id'],    
                                ),
                              ),
                            );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Username atau Password tidak valid"))
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

                  // LUPA KATA SANDI
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
