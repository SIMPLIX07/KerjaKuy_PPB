import 'package:flutter/material.dart';
import '../home_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                "Sign up to KerjaKuy",
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

              /// SOCIAL BUTTONS (icon bawaan)
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

              _buildTextLabel("Your name"),
              TextField(
                decoration: InputDecoration(
                  hintText: "Masukkan nama anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              _buildTextLabel("Your email"),
              TextField(
                decoration: InputDecoration(
                  hintText: "Masukkan email anda disini.",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              Divider(),

              _buildTextLabel("Create password"),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Masukkan password anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              _buildTextLabel("Confirm password"),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Konfirmasi password anda disini.",
                  border: InputBorder.none,
                ),
              ),
              Divider(),

              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
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
                child: Text("Sign up"),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 16),
      child: Text(
        text,
        style: TextStyle(color: Color(0xFF28AE9D), fontWeight: FontWeight.w600),
      ),
    );
  }
}
