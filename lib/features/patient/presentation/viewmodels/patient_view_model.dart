import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientViewModel extends StateNotifier<int> {
  PatientViewModel() : super(0);
}

final patientViewModelProvider = StateNotifierProvider<PatientViewModel, int>(
  (ref) => PatientViewModel(),
);
