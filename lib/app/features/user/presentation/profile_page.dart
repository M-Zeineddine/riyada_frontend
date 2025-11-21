import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:riyada_frontend/app/features/user/application/user_provider.dart';
import 'package:riyada_frontend/app/features/booking/application/booking_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final user = ref.watch(userProvider);
    final upcomingCount = ref.watch(upcomingBookingsProvider).length;
    final pastCount = ref.watch(pastBookingsProvider).length;

    final initials = (user?.name.trim().isNotEmpty == true)
        ? user!.name
              .trim()
              .split(' ')
              .where((p) => p.isNotEmpty)
              .take(2)
              .map((p) => p[0].toUpperCase())
              .join()
        : 'U';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: cs.primary.withOpacity(0.15),
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Guest User',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (user?.location != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  user!.location,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[700],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        if (user?.location == null)
                          Text(
                            'Set your location',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: open edit profile page
                    },
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: 'Edit profile',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------- Stats ----------
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Upcoming',
                      value: '$upcomingCount',
                      icon: Icons.event_available_outlined,
                      color: cs.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      label: 'Past',
                      value: '$pastCount',
                      icon: Icons.history,
                      color: cs.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                'Account',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),

              _ProfileTile(
                icon: Icons.person_outline,
                label: 'Edit Profile',
                onTap: () {
                  // TODO: navigate to edit profile
                },
              ),
              _ProfileTile(
                icon: Icons.notifications_none,
                label: 'Notifications',
                onTap: () {
                  // TODO: navigate to notifications settings
                },
              ),
              _ProfileTile(
                icon: Icons.payment_outlined,
                label: 'Payment Methods',
                onTap: () {
                  // TODO: navigate to payment methods (future)
                },
              ),

              // const SizedBox(height: 20),

              // Text(
              //   'Activity',
              //   style: theme.textTheme.titleSmall?.copyWith(
              //     fontWeight: FontWeight.w700,
              //     color: Colors.grey[800],
              //   ),
              // ),
              // const SizedBox(height: 8),

              // _ProfileTile(
              //   icon: Icons.book_online_outlined,
              //   label: 'My Bookings',
              //   onTap: () {
              //     // Switch to bookings tab
              //     // (with your current shell, you can use context.go('/bookings'))
              //     // or use the shell controller if you expose it.
              //     // For now:
              //     context.go('/bookings');
              //   },
              // ),
              // _ProfileTile(
              //   icon: Icons.favorite_outline,
              //   label: 'Saved Courts',
              //   onTap: () {
              //     // TODO: navigate to favourites (future)
              //   },
              // ),
              const SizedBox(height: 20),

              Text(
                'Help',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),

              _ProfileTile(
                icon: Icons.help_outline,
                label: 'Help & Support',
                onTap: () {
                  // TODO: open support
                },
              ),
              _ProfileTile(
                icon: Icons.description_outlined,
                label: 'Terms & Privacy',
                onTap: () {
                  // TODO: open terms
                },
              ),

              const SizedBox(height: 24),

              // ---------- Logout / Auth ----------
              if (user != null)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: implement sign out in userProvider
                      // ref.read(userProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Log out'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      side: BorderSide(color: Colors.red.withOpacity(0.85)),
                      foregroundColor: Colors.red,
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // TODO: navigate to welcome / login
                      // context.go('/');
                    },
                    child: const Text('Sign in / Create account'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.16),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: cs.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
