import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/glass_container.dart';
import 'package:riyada_frontend/app/features/user/data/user_model.dart';

class HeroBanner extends ConsumerWidget {
  final UserModel loggedUser;
  const HeroBanner({super.key, required this.loggedUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/illustrations/home_hero2.png', fit: BoxFit.cover),

          Container(color: Colors.black.withOpacity(0.6)),

          Positioned(
            top: 40,
            left: 15,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlassContainer(
                  mainText: loggedUser.location,
                  icon: Icons.location_on_outlined,
                  backgroundColor: Colors.white,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  iconSize: 20,
                  height: 32,
                ),
                GlassContainer(
                  mainText: '1150 points',
                  backgroundColor: Colors.white,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  iconSize: 20,
                  height: 32,
                ),
              ],
            ),
          ),

          Positioned(
            left: 15,
            bottom: 15,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    'Book and Play Sports Near You',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Discover and book premium sports courts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    // fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: GlassContainer(
                        mainText: 'Browse Courts',
                        backgroundColor: Colors.white,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        fontSize: 20,
                        height: 48,
                        onTap: () {
                          ref.read(courtsFilterProvider.notifier).reset();
                          ref
                              .read(courtsFilterProvider.notifier)
                              .setSort('nearby');
                          context.goNamed('courts');
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: GlassContainer(
                        mainText: 'View Tournaments',
                        backgroundColor: Colors.white,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        fontSize: 20,
                        height: 48,
                        onTap: () {
                          print("Route to tournaments");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
