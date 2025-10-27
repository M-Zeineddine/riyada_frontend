import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/home/application/home_provider.dart';
import 'package:riyada_frontend/app/features/user/application/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(userProvider);
    final nearbyCourts = ref.watch(nearbyCourtsProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loggedUser == null ? "Please Login" : loggedUser.name),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add_alert),
      //       tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(
      //             content: Text('This is a snackbar'),
      //             behavior: SnackBarBehavior.floating,
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
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
              height: 240,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/illustrations/home_hero.jpeg',
                    fit: BoxFit.cover,
                  ),

                  // Opacity layer
                  Container(
                    color: Colors.black.withOpacity(
                      0.45,
                    ), // adjust opacity here
                  ),

                  Positioned(
                    top: 40,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 4, 10, 4),
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            Text('${loggedUser?.location}'),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Text or content on top
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text(
                      'Find & Book',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: InkWell(
            //     onTap: () => {print("Tapped Booking")},
            //     child: Image.asset('assets/illustrations/booking_banner.png'),
            //   ),
            // ),
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
