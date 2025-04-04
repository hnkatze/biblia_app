import 'package:logger/logger.dart';

Logger get logger => Log.instance;

class Log extends Logger {
  Log() : super(printer: PrettyPrinter(methodCount: 0));

  static final Log instance = Log();
}