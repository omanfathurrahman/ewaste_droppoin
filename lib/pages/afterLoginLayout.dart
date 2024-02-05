import 'sampah_dibuang/sampah_dibuang.dart';
import 'package:flutter/material.dart';

import 'sampah_didonasikan/sampah_didonasikan.dart';

class AfterLoginLayout extends StatefulWidget {
  const AfterLoginLayout({super.key});

  @override
  State<AfterLoginLayout> createState() => _AfterLoginLayoutState();
}

class _AfterLoginLayoutState extends State<AfterLoginLayout> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        title: [
          const Text('Sampah Dibuang'),
          const Text('Sampah Didonasikan'),
        ][currentPageIndex],
      ),
      body: [
        const SampahDibuangPage(),
        const SampahDidonasikanPage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wifi_1_bar),
            label: 'Dibuang',
          ),
          NavigationDestination(
            icon: Icon(Icons.wifi_1_bar),
            label: 'Didonasikan',
          ),
        ],
      ),
    );
  }
}
