import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(),
  output: ConsoleOutput(),
);

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // ignore: avoid_print
    event.lines.forEach(print);
  }
}
