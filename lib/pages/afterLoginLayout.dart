import 'package:ewaste_droppoin/pages/profile/profile.dart';

import 'buang/sampah_dibuang.dart';
import 'package:flutter/material.dart';

import 'donasi/sampah_didonasikan.dart';

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
          const Text('Profile'),
        ][currentPageIndex],
      ),
      body: [
        const SampahDibuangPage(),
        const SampahDidonasikanPage(),
        Profile(),
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
          NavigationDestination(
            icon: Icon(Icons.wifi_1_bar),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
