// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class InitVideoCallView extends StatefulWidget {
  const InitVideoCallView({super.key});

  @override
  _InitVideoCallViewState createState() => _InitVideoCallViewState();
}

class _InitVideoCallViewState extends State<InitVideoCallView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => Get.offNamed(PageRoutes.videoCallScreen));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class NotificationRoute extends StatefulWidget {
  const NotificationRoute({super.key, this.route});

  final String? route;
  @override
  _NotificationRouteState createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => Get.offNamed(widget.route!));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
