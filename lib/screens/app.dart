// ignore_for_file: non_constant_identifier_names

import 'package:amg_downloader/screens/downloaded.dart';
import 'package:amg_downloader/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text.rich(TextSpan(children: [
          TextSpan(
              text: "AMG ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: "Video ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: "Downloader",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ])),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            DownloadedPage(),
          ],
        ),
      ),
      bottomNavigationBar: WaterDropNavBar(
          backgroundColor: Colors.black,
          bottomPadding: 12,
          waterDropColor: Colors.yellow,
          inactiveIconColor: Colors.yellow,
          iconSize: 28,
          barItems: [
            BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home_outlined),
            BarItem(
                filledIcon: Icons.file_download_done,
                outlinedIcon: Icons.file_download_done_outlined),
          ],
          selectedIndex: selectedIndex,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
            _pageController.jumpToPage(selectedIndex);
          }),
    );
  }
}
