import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateTimeProvider = Provider<DateTime Function()>((ref) {
  return DateTime.now;
});
