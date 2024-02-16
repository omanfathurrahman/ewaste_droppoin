import 'package:ewaste_droppoin/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late User? user;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(String email, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    user = res.user;
    // ignore: use_build_context_synchronously
    context.go('/sampahDibuang');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    _login(email, password);
                    if (user != null) {
                      context.go('/sampahDibuang');
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? '),
                    TextButton(
                      onPressed: () => context.go('/signUp'),
                      child: const Text('Daftar'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
