import 'package:amg_downloader/widgets/custom_listTile.dart';
import 'package:flutter/material.dart';

class DownloadedPage extends StatefulWidget {
  const DownloadedPage({super.key});

  @override
  State<DownloadedPage> createState() => _DownloadedPageState();
}

class _DownloadedPageState extends State<DownloadedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Downloaded Files',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: const [
          CustomListTile(
              imgSrc:
                  "https://cdn.pixabay.com/photo/2019/04/07/23/11/link-building-4111001_1280.jpg",
              vidTitle: "How to create a full career"),
          CustomListTile(
              imgSrc:
                  "https://cdn.pixabay.com/photo/2016/11/29/12/13/fence-1869401_1280.jpg",
              vidTitle: "Perfect Workout in your home - 5 MINUTES"),
          CustomListTile(
              imgSrc:
                  "https://cdn.pixabay.com/photo/2023/02/15/10/19/backlinks-7791387_1280.jpg",
              vidTitle: "33 Strategies of War - Robert Greene"),
        ],
      ),
    );
  }
}
