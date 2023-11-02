import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(colors: false), // Colored logger not supported on iOS
);
