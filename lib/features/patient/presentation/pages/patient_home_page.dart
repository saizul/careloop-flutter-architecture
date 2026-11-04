import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({super.key});

  int _selectedIndex(String location) {
    if (location.startsWith(AppRoutes.reminder)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.history)) {
      return 2;
    }
    if (location.startsWith(AppRoutes.profile)) {
      return 3;
    }
    return 0;
  }

  void _onTapNav(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.patient);
        break;
      case 1:
        context.go(AppRoutes.reminder);
        break;
      case 2:
        context.go(AppRoutes.history);
        break;
      case 3:
        context.go(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _selectedIndex(location);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFFE2E8F0),
                      child: Icon(Icons.person, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            'Amin',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Notifications',
                      onPressed: () => context.push(AppRoutes.notifications),
                      icon: const Icon(Icons.notifications_none_rounded),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                delegate: SliverChildListDelegate(
                  [
                    _DashboardCard(
                      title: 'Medicine Reminder',
                      subtitle: '2 doses due today',
                      icon: Icons.medication_outlined,
                      color: const Color(0xFF0EA5E9),
                      onTap: () => context.go(AppRoutes.reminder),
                    ),
                    _DashboardCard(
                      title: 'Upcoming Appointment',
                      subtitle: 'Dr. Hasan, 4:30 PM',
                      icon: Icons.calendar_month_outlined,
                      color: const Color(0xFF16A34A),
                      onTap: () {},
                    ),
                    _DashboardCard(
                      title: 'Health Summary',
                      subtitle: 'Vitals stable this week',
                      icon: Icons.favorite_outline,
                      color: const Color(0xFFF97316),
                      onTap: () => context.go(AppRoutes.history),
                    ),
                    _DashboardCard(
                      title: 'Follow-up Status',
                      subtitle: 'Next follow-up in 3 days',
                      icon: Icons.check_circle_outline,
                      color: const Color(0xFF6366F1),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onTapNav(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm_outlined),
            selectedIcon: Icon(Icons.alarm),
            label: 'Reminder',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color),
              ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
