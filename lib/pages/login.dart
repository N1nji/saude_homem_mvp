import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/auth_service.dart';

// Função para exibir mensagens personalizadas (sucesso/erro)
void showCustomMessage(BuildContext context, String message, {bool success = true}) {
  final color = success ? Colors.green : Colors.redAccent;
  final overlay = OverlayEntry(
    builder: (_) => Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10)],
            ),
            child: Row(
              children: [
                Icon(success ? Icons.check_circle : Icons.error, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(overlay);
  Future.delayed(const Duration(seconds: 3)).then((_) => overlay.remove());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  late AnimationController _animCtrl;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final ok = await AuthService.login(_userCtrl.text.trim(), _passCtrl.text.trim());
    setState(() => _loading = false);

    if (ok) {
      showCustomMessage(context, 'Login realizado com sucesso!');
      await Future.delayed(const Duration(milliseconds: 800));
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showCustomMessage(context, 'Falha no login. Verifique seus dados.', success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fundo com imagem e overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.55)),

          // Conteúdo
          SafeArea(
            child: FadeTransition(
              opacity: _fadeIn,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),

                    // Lottie animado no topo
                    SizedBox(
                      height: size.height * 0.25,
                      child: Lottie.asset('assets/doctor.json', fit: BoxFit.contain),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'Bem-vindo de volta!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Entre com suas credenciais para continuar',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),

                    const SizedBox(height: 30),

                    // Formulário de login
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildInputField(
                            controller: _userCtrl,
                            label: 'Usuário ou email',
                            icon: Icons.person,
                            validator: (v) => v == null || v.isEmpty ? 'Informe usuário ou e-mail' : null,
                          ),
                          const SizedBox(height: 14),
                          _buildInputField(
                            controller: _passCtrl,
                            label: 'Senha',
                            icon: Icons.lock,
                            obscure: true,
                            validator: (v) => v == null || v.length < 6 ? 'Mínimo 6 caracteres' : null,
                          ),
                          const SizedBox(height: 24),

                          // Botão animado com gradiente
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: _loading
                                ? const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                                  )
                                : GestureDetector(
                                    onTap: _onSubmit,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF4FC3F7), Color(0xFF1976D2)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueAccent.withOpacity(0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Entrar',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),

                          const SizedBox(height: 20),

                          // Link para criar conta
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        textInputAction: obscure ? TextInputAction.done : TextInputAction.next,
      ),
    );
  }
}
