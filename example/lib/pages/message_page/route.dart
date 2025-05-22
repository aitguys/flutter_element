import 'package:get/get.dart';
import 'index.dart';
import 'message_basic.dart';
import 'message_round.dart';
import 'message_size.dart';

abstract class MessageRoutes {
  static const message = '/message';
  static const messageBasic = '/message/basic';
  static const messageRound = '/message/round';
  static const messageSize = '/message/size';
}

final messageRoutesPages = [
  GetPage(
    name: MessageRoutes.message,
    page: () => const MessagePreview(),
  ),
  GetPage(
    name: MessageRoutes.messageBasic,
    page: () => const MessageBasicPreview(),
  ),
  GetPage(
    name: MessageRoutes.messageRound,
    page: () => const MessageRoundPreview(),
  ),
  GetPage(
    name: MessageRoutes.messageSize,
    page: () => const MessageSizePreview(),
  ),
];
