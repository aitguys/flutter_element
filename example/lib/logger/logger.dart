import 'package:logger/logger.dart';

class Loglevel {
  // 私有构造函数
  Loglevel._internal();

  // 单例实例
  static final Loglevel _instance = Loglevel._internal();

  // 工具类的工厂构造函数
  factory Loglevel() {
    return _instance;
  }

  // Logger 实例
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // 打印方法调用栈的深度
      errorMethodCount: 8, // 错误时打印的堆栈深度
      lineLength: 120, // 每行的长度
      colors: true, // 是否使用颜色
      printEmojis: true, // 是否打印表情
    ),
  );

  // 日志级别方法
  static void t(Object message) => _logger.t(message.toString());
  static void d(Object message) => _logger.d(message.toString());
  static void i(Object message) => _logger.i(message.toString());
  static void w(Object message) => _logger.w(message.toString());
  static void e(Object message) => _logger.e(message.toString());
  static void f(Object message) => _logger.f(message.toString());
}
