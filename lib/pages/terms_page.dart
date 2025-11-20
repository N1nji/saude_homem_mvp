import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _sections = [
    {
      'icon': Icons.privacy_tip_rounded,
      'title': 'Privacidade e Proteção de Dados',
      'content':
          'Seus dados são protegidos conforme a LGPD. Não compartilhamos suas informações sem consentimento. Todas as comunicações são criptografadas.',
    },
    {
      'icon': Icons.health_and_safety_rounded,
      'title': 'Responsabilidade do Usuário',
      'content':
          'O usuário é responsável pelas informações cadastradas e deve utilizar o aplicativo de forma ética e segura, respeitando outros usuários.',
    },
    {
      'icon': Icons.medical_services_rounded,
      'title': 'Profissionais de Saúde',
      'content':
          'Médicos devem inserir um CRM válido. As informações fornecidas serão verificadas com o Conselho Federal de Medicina.',
    },
    {
      'icon': Icons.cookie_rounded,
      'title': 'Cookies e Dados de Uso',
      'content':
          'Utilizamos cookies e dados de navegação para melhorar sua experiência e personalizar o conteúdo mostrado no app.',
    },
    {
      'icon': Icons.email_rounded,
      'title': 'Contato e Suporte',
      'content':
          'Em caso de dúvidas ou solicitações, envie um e-mail para suporte@espacoseguro.com.br. Nossa equipe responderá o quanto antes 💙',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🎬 Fundo animado com Lottie
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Lottie.asset(
                'assets/document.json', // uma animação leve 
                fit: BoxFit.cover,
                repeat: true,
              ),
            ),
          ),

          // Conteúdo principal
          SafeArea(
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80), // espaço pro botão fixo
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blueAccent),
                          onPressed: () => Navigator.pop(context, false),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Termos de Uso',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ..._sections.map((s) => _buildSection(s)).toList(),

                    const SizedBox(height: 20),
                    Text(
                      '© ${DateTime.now().year} Espaço Seguro. Todos os direitos reservados.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔘 Botão fixo "Aceitar e Voltar"
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 8,
              ),
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.check_circle, color: Colors.white),
              label: const Text(
                'Aceitar e Voltar',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: Icon(s['icon'], color: Colors.blueAccent),
          title: Text(
            s['title'],
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                s['content'],
                style: const TextStyle(color: Colors.black54, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
