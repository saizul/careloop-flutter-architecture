import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderViewModel extends StateNotifier<int> {
  ReminderViewModel() : super(0);
}

final reminderViewModelProvider = StateNotifierProvider<ReminderViewModel, int>(
  (ref) => ReminderViewModel(),
);
