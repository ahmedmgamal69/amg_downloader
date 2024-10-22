import 'package:amg_downloader/screens/app.dart';
import 'package:amg_downloader/screens/downloaded.dart';
import 'package:amg_downloader/screens/home.dart';
import 'package:amg_downloader/screens/splash.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> routesAPI = [
  GetPage(name: "/", page: () => const SplashScreen()),
  GetPage(name: "/app", page: () => const AppPage()),
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/downloaded", page: () => const DownloadedPage()),
];
