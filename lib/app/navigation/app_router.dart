import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_route.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.bootstrap.path,
    routes: [
      GoRoute(
        path: AppRoute.bootstrap.path,
        name: AppRoute.bootstrap.name,
        builder: (context, state) => const _ArchitectureReadyPage(),
      ),
      GoRoute(
        path: AppRoute.patientShell.path,
        name: AppRoute.patientShell.name,
        builder: (context, state) => const _ArchitectureReadyPage(),
      ),
      GoRoute(
        path: AppRoute.doctorShell.path,
        name: AppRoute.doctorShell.name,
        builder: (context, state) => const _ArchitectureReadyPage(),
      ),
      GoRoute(
        path: AppRoute.adminShell.path,
        name: AppRoute.adminShell.name,
        builder: (context, state) => const _ArchitectureReadyPage(),
      ),
    ],
  );
});

class _ArchitectureReadyPage extends StatelessWidget {
  const _ArchitectureReadyPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'CareLoop',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
