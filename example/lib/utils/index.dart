import 'package:flutter/material.dart';
import 'package:get/get.dart';

void backToHome(BuildContext context) {
  Get.offAllNamed('/'); // 回到根路由并清除所有路由
}
