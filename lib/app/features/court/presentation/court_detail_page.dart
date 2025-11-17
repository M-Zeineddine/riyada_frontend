import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/court/application/court_by_id_provider.dart';
import 'package:riyada_frontend/app/shared/widgets/image_carousel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CourtDetailPage extends ConsumerStatefulWidget {
  const CourtDetailPage({super.key, required this.id, this.courtExtra});
  final String id;
  final CourtModel? courtExtra;

  @override
  ConsumerState<CourtDetailPage> createState() => _CourtDetailPageState();
}

class _CourtDetailPageState extends ConsumerState<CourtDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final court = widget.courtExtra ?? ref.watch(courtByIdProvider(widget.id));

    if (court == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Court')),
        body: const Center(child: Text('Court not found')),
      );
    }

    // Build a small list of images; replace with your real gallery list if you have it
    final images = <String>[
      court.imageUrl,
      court.imageUrl.replaceFirst('/seed/', '/seed/1-'),
      court.imageUrl.replaceFirst('/seed/', '/seed/2-'),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 260,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Carousel background
                  ImageCarousel(
                    images: images,
                    height: 260,
                    borderRadius: BorderRadius.zero,
                    showDots: true,
                  ),

                  // Gradient for readability
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.40),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Back button + sport pill, inside SafeArea so they are below status bar
                  SafeArea(
                    child: Stack(
                      children: [
                        // back button – top-left
                        Positioned(
                          left: 8,
                          top: 2,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => context.pop(),
                          ),
                        ),

                        // sport pill – top-right
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              court.sport,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: cs.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          court.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '\$${court.pricePerHour}/hour',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location + distance
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          court.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      if (court.distanceKm != null) ...[
                        const SizedBox(width: 12),
                        const Icon(Icons.route, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${court.distanceKm} km away',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _Pill(text: 'Synthetic Grass'),
                      _Pill(text: 'Indoor/Outdoor'),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Divider(color: Colors.black12.withOpacity(0.08)),

                  // About
                  const SizedBox(height: 16),
                  Text(
                    'About',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Top-rated ${'' + court.sport.toLowerCase()} court with great lighting and a well-maintained surface. '
                    'Easily accessible and perfect for matches or practice sessions.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Divider(color: Colors.black12.withOpacity(0.08)),

                  if (court.amenities != null &&
                      court.amenities!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Amenities',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: court.amenities!
                          .map((a) => _AmenityChip(label: a))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  Divider(color: Colors.black12.withOpacity(0.08)),

                  if (court.lat != null && court.lng != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Location',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              court.lat!,
                              court.lng!,
                            ), // ✅ new names
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'com.riyada_frontend.app', // any package name
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(court.lat!, court.lng!),
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.bottomCenter,
                                  child: const Icon(
                                    Icons.location_pin,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),

      // Book button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () => context.pushNamed(
                'courtBooking',
                pathParameters: {'id': court.id},
                extra: court,
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: cs.onSurface,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  const _AmenityChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.primary.withOpacity(0.25)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.primary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
