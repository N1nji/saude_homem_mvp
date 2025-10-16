import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _userCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _birthCtrl.dispose();
    super.dispose();
  }

  Future<void> _showDialog(String title, String message, {bool success = true}) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(success ? Icons.check_circle : Icons.error,
                color: success ? Colors.green : Colors.red),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 1)); // simulação
    setState(() => _loading = false);

    await _showDialog(
      'Cadastro concluído!',
      'Conta criada com sucesso 🎉 Faça login para continuar.',
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/doctor.json',
                    width: 180,
                    height: 180,
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  'Criar conta',
                  style: textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Preencha seus dados para continuar',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: _userCtrl,
                  label: 'Usuário',
                  icon: Icons.person,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe um usuário' : null,
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _emailCtrl,
                  label: 'Email',
                  icon: Icons.email,
                  validator: (v) => v == null || !v.contains('@')
                      ? 'Informe um e-mail válido'
                      : null,
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _passCtrl,
                  label: 'Senha',
                  icon: Icons.lock,
                  obscure: true,
                  validator: (v) => v == null || v.length < 6
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 16),

                _buildTextField(
                  controller: _birthCtrl,
                  label: 'Data de nascimento',
                  icon: Icons.cake,
                  readOnly: true,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      _birthCtrl.text =
                          '${picked.day}/${picked.month}/${picked.year}';
                    }
                  },
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Informe sua data de nascimento' : null,
                ),

                const SizedBox(height: 32),

                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _loading
                        ? const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.blueAccent,
                            ),
                          )
                        : GestureDetector(
                            onTap: _onSubmit,
                            child: Container(
                              key: const ValueKey('registerButton'),
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4facfe),
                                    Color(0xFF00f2fe),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.3),
                                    offset: const Offset(0, 4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Cadastrar',
                                style: textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 18),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: const Text('Já tem conta? Entrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Campo customizado com sombra e ícone
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscure = false,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
