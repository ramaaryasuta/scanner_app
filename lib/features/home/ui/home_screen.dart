import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../provider/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(tabIndexProvider);

    const pages = [
      Center(child: Text('Generate')),
      Center(child: Text('Scan')),
    ];

    return Scaffold(
      body: pages[activeIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: activeIndex,
        onDestinationSelected: (value) =>
            ref.read(tabIndexProvider.notifier).setActiveIndex(value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.qr_code_2_rounded),
            label: 'Generate',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Scan',
          ),
        ],
      ),
    );
  }
}
