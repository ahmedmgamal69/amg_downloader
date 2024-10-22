// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String imgSrc;
  final String vidTitle;
  const CustomListTile(
      {super.key, required this.imgSrc, required this.vidTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imgSrc),
      trailing: const Icon(Icons.more_vert, color: Colors.white),
      title: Text(
        vidTitle,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      subtitle: const Row(
        children: [
          Text(
            "Completed",
            style: TextStyle(fontSize: 12, color: Colors.green),
          ),
          Icon(
            Icons.done,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
