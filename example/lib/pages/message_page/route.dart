import 'package:get/get.dart';
import 'index.dart';
import 'message_basic.dart';
import 'message_round.dart';
import 'message_size.dart';
import 'message_duration.dart';
import 'message_icon.dart';
import 'message_showClose.dart';
import 'message_api.dart';

abstract class MessageRoutes {
  static const message = '/message';
  static const messageBasic = '/message/basic';
  static const messageRound = '/message/round';
  static const messageSize = '/message/size';
  static const messageDuration = '/message/duration';
  static const messageIcon = '/message/icon';
  static const messageShowClose = '/message/showClose';
  static const messageApi = '/message/api';
}

final messageRoutesPages = [
  GetPage(
    name: MessageRoutes.message,
    page: () => const MessagePreview(),
  ),
  GetPage(
    name: MessageRoutes.messageBasic,
    page: () => const MessageBasicView(),
  ),
  GetPage(
    name: MessageRoutes.messageRound,
    page: () => const MessageRoundView(),
  ),
  GetPage(
    name: MessageRoutes.messageSize,
    page: () => const MessageSizeView(),
  ),
  GetPage(
    name: MessageRoutes.messageDuration,
    page: () => const MessageDurationView(),
  ),
  GetPage(
    name: MessageRoutes.messageIcon,
    page: () => const MessageIconView(),
  ),
  GetPage(
    name: MessageRoutes.messageShowClose,
    page: () => const MessageShowCloseView(),
  ),
  GetPage(
    name: MessageRoutes.messageApi,
    page: () => const MessageApiView(),
  ),
];
