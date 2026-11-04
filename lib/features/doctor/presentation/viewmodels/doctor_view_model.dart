import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorViewModel extends StateNotifier<int> {
  DoctorViewModel() : super(0);
}

final doctorViewModelProvider = StateNotifierProvider<DoctorViewModel, int>(
  (ref) => DoctorViewModel(),
);
