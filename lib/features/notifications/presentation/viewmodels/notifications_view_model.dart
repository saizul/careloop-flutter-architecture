import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsViewModel extends StateNotifier<int> {
  NotificationsViewModel() : super(0);
}

final notificationsViewModelProvider =
    StateNotifierProvider<NotificationsViewModel, int>(
  (ref) => NotificationsViewModel(),
);
