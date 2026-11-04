import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/otp_verification_screen.dart';
import '../../features/auth/presentation/pages/registration_screen.dart';
import '../../features/auth/presentation/pages/splash_screen.dart';
import '../../features/doctor/presentation/pages/doctor_home_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/patient/presentation/pages/patient_home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/reminder/presentation/pages/reminder_page.dart';
import 'app_routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.registration,
        name: 'registration',
        builder: (BuildContext context, GoRouterState state) {
          return const RegistrationScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.otp,
        name: 'otp',
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra;
          if (extra is Map<String, dynamic>) {
            return OtpVerificationScreen(
              phoneNumber: extra['phoneNumber'] as String? ?? '',
              fullName: extra['fullName'] as String?,
              age: extra['age'] as int?,
              gender: extra['gender'] as String?,
              userType: extra['userType'] as String?,
            );
          }
          return const OtpVerificationScreen(phoneNumber: '');
        },
      ),
      GoRoute(
        path: AppRoutes.patient,
        name: 'patient',
        builder: (BuildContext context, GoRouterState state) {
          return const PatientHomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.doctor,
        name: 'doctor',
        builder: (BuildContext context, GoRouterState state) {
          return const DoctorHomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.reminder,
        name: 'reminder',
        builder: (BuildContext context, GoRouterState state) {
          return const ReminderPage();
        },
      ),
      GoRoute(
        path: AppRoutes.history,
        name: 'history',
        builder: (BuildContext context, GoRouterState state) {
          return const HistoryPage();
        },
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationsPage();
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
      ),
    ],
  );
});
