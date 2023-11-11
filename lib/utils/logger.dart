import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    colors: false,
    errorMethodCount: 8,
  ), // Colored logger not supported on iOS
);
