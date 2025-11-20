import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../pages/terms_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _cpfCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _birthCtrl = TextEditingController();
  final _crmCtrl = TextEditingController();

  bool _loading = false;
  bool _isDoctor = false;
  bool _acceptedTerms = false;

  late AnimationController _animCtrl;

  // 🎭 Máscaras
  final _cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final _birthMask = MaskTextInputFormatter(mask: '##/##/####');

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _emailCtrl.dispose();
    _cpfCtrl.dispose();
    _passCtrl.dispose();
    _birthCtrl.dispose();
    _crmCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    // Verificação completa de e-mail + domínio
    final pattern =
        r'^[a-zA-Z0-9._%+-]+@(gmail\.com|outlook\.com|hotmail\.com|yahoo\.com)$';
    return RegExp(pattern).hasMatch(email);
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      _showSnackBar("Você precisa aceitar os Termos de Uso.", success: false);
      return;
    }

    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2)); // simulação
    setState(() => _loading = false);

    _showSnackBar("Conta criada com sucesso 🎉", success: true);

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/tutorial_page');
    }
  }

  void _showSnackBar(String message, {bool success = true}) {
    final color = success ? Colors.green : Colors.redAccent;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color.withOpacity(0.95),
        content: Row(
          children: [
            Icon(success ? Icons.check_circle : Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: FadeTransition(
            opacity: CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset('assets/doctor.json', width: 180, height: 180),
                  ),
                  const SizedBox(height: 12),
                  Text('Criar conta',
                      style: textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Preencha seus dados para continuar',
                      style: textTheme.bodyMedium),
                  const SizedBox(height: 24),

                  _buildTextField(
                    controller: _userCtrl,
                    label: 'Nome completo',
                    icon: Icons.person,
                    validator: (v) => v == null || v.isEmpty ? 'Informe seu nome' : null,
                  ),
                  const SizedBox(height: 14),

                  _buildTextField(
                    controller: _emailCtrl,
                    label: 'E-mail',
                    icon: Icons.email,
                    validator: (v) => v == null || !_isValidEmail(v)
                        ? 'Informe um e-mail válido (@gmail.com, @outlook.com...)'
                        : null,
                  ),
                  const SizedBox(height: 14),

                  _buildTextField(
                    controller: _cpfCtrl,
                    label: 'CPF',
                    icon: Icons.badge,
                    inputFormatters: [_cpfMask],
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final clean = _cpfMask.getUnmaskedText();
                      return clean.length != 11 ? 'CPF inválido' : null;
                    },
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Checkbox(
                        value: _isDoctor,
                        onChanged: (v) => setState(() => _isDoctor = v ?? false),
                        activeColor: Colors.blueAccent,
                      ),
                      const Text('Sou médico (possuo CRM)'),
                    ],
                  ),
                  if (_isDoctor)
                    _buildTextField(
                      controller: _crmCtrl,
                      label: 'CRM',
                      icon: Icons.local_hospital,
                      validator: (v) => _isDoctor && (v == null || v.isEmpty)
                          ? 'Informe o CRM'
                          : null,
                    ),
                  if (_isDoctor) const SizedBox(height: 14),

                  _buildTextField(
                    controller: _passCtrl,
                    label: 'Senha',
                    icon: Icons.lock,
                    obscure: true,
                    validator: (v) => v == null || v.length < 6
                        ? 'Mínimo 6 caracteres'
                        : null,
                  ),
                  const SizedBox(height: 14),

                  _buildTextField(
                    controller: _birthCtrl,
                    label: 'Data de nascimento',
                    icon: Icons.cake,
                    inputFormatters: [_birthMask],
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final clean = _birthMask.getUnmaskedText();
                      if (clean.length != 8) return 'Data inválida';
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Checkbox(
                        value: _acceptedTerms,
                        onChanged: (v) => setState(() => _acceptedTerms = v ?? false),
                        activeColor: Colors.blueAccent,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final accepted = await Navigator.push<bool>
                            (context, 
                            MaterialPageRoute(builder: (_) => const TermsPage()),
                            );
                            if (accepted == true) {
                              setState(() => _acceptedTerms = true);
                            }
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: 'Li e aceito os ',
                              style: TextStyle(color: Colors.black87),
                              children: [
                                TextSpan(
                                  text: 'Termos de Uso',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: _loading
                          ? const CircularProgressIndicator(color: Colors.blueAccent)
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
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text('Já tem conta? Entrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscure = false,
    bool readOnly = false,
    VoidCallback? onTap,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
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
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
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
