// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:amg_downloader/widgets/custom_btn.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _UrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isExpanded = false;
  String? thumbnailUrl;
  String? vidTitle;

  Future<void> downloadVideo(String videoUrl) async {
    // Get Permissions
    if (await Permission.storage.request().isGranted) {
      if (kDebugMode) print("Permission Granted!");

      var yt = YoutubeExplode();
      var videoId = VideoId(videoUrl);

      // Get video details
      var video = await yt.videos.get(videoId);

      // Get video's stream
      var manifest = await yt.videos.streamsClient.getManifest(videoId);

      if (manifest.muxed.isNotEmpty) {
        var streamInfo = manifest.muxed.withHighestBitrate();

        // Get save path
        var filePath = '/storage/emulated/0/Movies/${video.title}.mp4';

        // Download and save the video
        var dio = Dio();
        await dio.downloadUri(streamInfo.url, filePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            if (kDebugMode) {
              print(
                  'Progress: ${(received / total * 100).toStringAsFixed(0)}%');
            }
          }
        });
        if (kDebugMode) print('Video Downloaded and saved to $filePath');

        yt.close();
      } else {
        if (kDebugMode) print('No muxed streams available');
      }
    }
  }

  fetchVideoInfo(String videoLink) async {
    var yt = YoutubeExplode();
    var videoId = VideoId(videoLink);
    var video = await yt.videos.get(videoId);
    String url = video.thumbnails.highResUrl;
    String videoTitle = video.title;
    setState(() {
      thumbnailUrl = url;
      vidTitle = videoTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // URL TextField
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (val) {
                  if (val!.isEmpty) return "Please enter a YT URL";
                  return null;
                },
                controller: _UrlController,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Helvetica",
                ),
                decoration: const InputDecoration(
                    label: Text("Enter YT URL"),
                    contentPadding: EdgeInsets.all(15.0),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Helvetica",
                        color: Colors.yellow),
                    focusColor: Colors.yellow,
                    prefixIcon: Icon(
                      Icons.link,
                      color: Colors.yellow,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.yellow))),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),

            // Buttons
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Past
              CustomBtn(
                  btnColor: Colors.lightBlue,
                  btnTxt: "Past",
                  btnAction: () async {
                    final data = await Clipboard.getData('text/plain');
                    if (data != null) {
                      setState(() {
                        _UrlController.text = data.text ?? '';
                      });
                    }
                  }),

              // Download
              CustomBtn(
                btnColor: Colors.green,
                btnTxt: "Download",
                btnAction: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: const Text(
                            "Download Completed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 90),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 4),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.done,
                              color: Colors.green,
                              size: 80.0,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text(
                                "done",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        );
                      });
                  // if (_formKey.currentState!.validate()) {
                  //   downloadVideo(_UrlController.text);
                  // }
                },
              )
            ]),
            const SizedBox(
              height: 60.0,
            ),
            SizedBox(
                child: ExpansionPanelList(
              expandIconColor: Colors.yellow,
              elevation: 1,
              expandedHeaderPadding: const EdgeInsets.all(8.0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {});
                if (_UrlController.text.isNotEmpty) {
                  setState(() {
                    fetchVideoInfo(_UrlController.text);
                  });
                }
                if (_isExpanded == false) {
                  _isExpanded = true;
                  setState(() {
                    isExpanded = !_isExpanded;
                  });
                } else {
                  _isExpanded = false;
                  setState(() {
                    isExpanded = !_isExpanded;
                  });
                }
              },
              children: [
                ExpansionPanel(
                    backgroundColor: Colors.black,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return const ListTile(
                        title: Text(
                          "Video Details",
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        thumbnailUrl == null
                            ? const Text(
                                "No Data Found !",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18.0),
                              )
                            : Column(
                                children: [
                                  Image.network(thumbnailUrl!),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "Title: $vidTitle",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow),
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                    isExpanded: _isExpanded),
              ],
            )),
          ],
        ),
      )),
    );
  }
}
