import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewModel extends StateNotifier<int> {
  ProfileViewModel() : super(0);
}

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, int>(
  (ref) => ProfileViewModel(),
);
