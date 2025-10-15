import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:tasktune/env/env.dart';
import 'package:tasktune/screens/dashboard_page.dart';
import 'package:tasktune/screens/analyze_page.dart';
import 'package:tasktune/screens/settings_page.dart';
import 'package:tasktune/screens/stats_page.dart';

void main() {
  OpenAI.apiKey = Env.apiKey;
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskTune',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: Scaffold(
        body: Row(
          children: [
            // --- 사이드바 ---
            SizedBox(
              width: 220,
              child: Column(
                children: [
                  // 앱 로고
                  Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Row(
                      children: [
                        Icon(Icons.apps),
                        SizedBox(width: 6),
                        Text('TaskTune'),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  // 메뉴
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            MenuItem(
                              icon: Icons.dashboard_rounded,
                              label: '대시보드',
                              selected: selected == 0,
                              onTap: () => setState(() => selected = 0),
                            ),
                            MenuItem(
                              icon: Icons.checklist_rounded,
                              label: '할 일 분석',
                              selected: selected == 1,
                              onTap: () => setState(() => selected = 1),
                            ),
                            MenuItem(
                              icon: Icons.bar_chart_rounded,
                              label: '통계',
                              selected: selected == 2,
                              onTap: () => setState(() => selected = 2),
                            ),
                          ],
                        ),
                        // 설정
                        Column(
                          children: [
                            MenuItem(
                              icon: Icons.settings_rounded,
                              label: '설정',
                              selected: selected == 3,
                              onTap: () => setState(() => selected = 3),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // --- 구분선 ---
            Container(
              width: 1,
              color: Colors.grey,
            ),
            // --- 메인 화면 ---
            Expanded(
              child: IndexedStack(
                index: selected,
                children: [
                  const DashboardPage(),
                  const AnalyzePage(),
                  const StatsPage(),
                  const SettingsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------- 메뉴 아이템 -------
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.grey.shade200 : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Center(
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(icon),
                const SizedBox(
                  width: 20,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
