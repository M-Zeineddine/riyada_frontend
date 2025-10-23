import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 240,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/illustrations/soccer_hero.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Find & Book',
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Browse top-rated venues and discover the ideal location for your game.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _Dot(active: true),
                  SizedBox(width: 8),
                  _Dot(active: false),
                  SizedBox(width: 8),
                  _Dot(active: false),
                ],
              ),

              const SizedBox(height: 28),

              Text(
                'Enter your mobile number to get OTP',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
              ),

              const SizedBox(height: 12),

              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: cs.primary, width: 1.4),
                  ),
                  fillColor: Colors.black.withOpacity(0.02),
                  filled: true,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: () {
                    context.go('/home');
                  },
                  child: const Text(
                    'Get OTP',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.black12)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: TextStyle(color: Colors.black45)),
                  ),
                  Expanded(child: Divider(color: Colors.black12)),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _SocialButton(asset: 'assets/icons/google.png'),
                  SizedBox(width: 16),
                  _SocialButton(asset: 'assets/icons/apple.png'),
                  SizedBox(width: 16),
                  _SocialButton(asset: 'assets/icons/email.png'),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.active});
  final bool active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? cs.primary : Colors.black12,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 56,
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Colors.black.withOpacity(0.08)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Center(
            child: Image.asset(
              asset,
              width: 22,
              height: 22,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
