import 'package:flutter/material.dart';
import '../widgets/tutorial_card.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> tutorialData = [
    {
      "title": "Opa! Meu nome é N1nji, sou um dos dev do app 😎",
      "icon": Icons.person,
      "colors": [Colors.blue, Colors.lightBlueAccent],
    },
    {
      "title": "Este app ainda está em desenvolvimento, okay? 🛠️",
      "icon": Icons.build,
      "colors": [Colors.lightBlueAccent, Colors.blueAccent],
    },
    {
      "title":
          "Aqui você comentara anonimamente sobre saúde masculina e ira ver o que outros estão falando 💬",
      "icon": Icons.chat_bubble_outline,
      "colors": [Colors.blueAccent, Colors.cyan],
    },
    {
      "title": "Contate profissionais de saúde e marque consultas facilmente 📅",
      "icon": Icons.calendar_today,
      "colors": [Colors.cyan, Colors.tealAccent],
    },
    {
      "title": "Uma curiosidade: Sabia que 1 em 3 homens não faz exame anual? 🤯",
      "icon": Icons.lightbulb_outline,
      "colors": [Colors.tealAccent, Colors.greenAccent],
    },
    {
      "title": "Prontos, vamos começar? 👊",
      "icon": Icons.rocket_launch,
      "colors": [Colors.greenAccent, Colors.blueAccent],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: tutorialData.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final data = tutorialData[index];
              return TutorialCard(
                title: data['title'],
                icon: data['icon'],
                colors: data['colors'],
                showButton: index == tutorialData.length - 1,
                onPressed: () =>
                  Navigator.pushReplacementNamed(
                    context, '/home'),
                  );
                },
              ),
          


          // 🔵 Indicadores de progresso (bolinhas)
          Positioned(
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tutorialData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 10,
                  width: _currentPage == index ? 25 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
