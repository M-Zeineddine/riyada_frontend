import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/home/application/home_provider.dart';
import 'package:riyada_frontend/app/features/user/application/user_provider.dart';
import 'dart:ui';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(userProvider);
    final nearbyCourts = ref.watch(nearbyCourtsProvider);

    // Theming variables
    // final theme = Theme.of(context);
    // final cs = theme.colorScheme;
    // final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(loggedUser == null ? "Please Login" : loggedUser.name),
            // Container(
            //   margin: const EdgeInsets.only(top: 16),
            //   padding: const EdgeInsets.symmetric(vertical: 12),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 16),
            //         child: Text(
            //           'Nearby Courts',
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 160,
            //         child: ListView.builder(
            //           scrollDirection: Axis.horizontal,
            //           padding: const EdgeInsets.only(left: 16, top: 12),
            //           itemCount: nearbyCourts.length,
            //           itemBuilder: (context, index) => Padding(
            //             padding: const EdgeInsets.only(right: 12),
            //             child: CourtBox(
            //               court: nearbyCourts[index],
            //               onTap: () {
            //                 context.push('/court/${nearbyCourts[index].id}');
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 360,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/illustrations/home_hero2.png',
                    fit: BoxFit.cover,
                  ),

                  // Opacity layer
                  Container(color: Colors.black.withOpacity(0.6)),

                  Positioned(
                    top: 40,
                    left: 15,
                    child: GlassContainer(
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
                  ),

                  // Text or content on top
                  Positioned(
                    left: 20,
                    bottom: 20,
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
                                  print("Route to courts");
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
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CourtBox extends StatelessWidget {
  final CourtModel court;
  final VoidCallback? onTap;

  const CourtBox({super.key, required this.court, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        width: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(court.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(court.name),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final String mainText;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final double? iconSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.mainText,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor?.withOpacity(0.15),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: iconSize),
                    const SizedBox(width: 2),
                  ],

                  Text(
                    mainText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
