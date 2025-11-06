import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({
    super.key,
    required this.court,
    this.onTap,
    this.onPrimaryAction,
    this.primaryActionLabel,
    this.cardHeight = 200,
    this.imageHeight = 100,
  });

  final CourtModel court;
  final VoidCallback? onTap;
  final VoidCallback? onPrimaryAction;
  final String? primaryActionLabel;

  final double cardHeight;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        height: cardHeight,
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 14 / 7,
                child: Image.network(
                  court.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: Colors.black12),
                ),
              ),

              // the rest expands to fill remaining space
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          court.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // location + distance
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            court.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.route, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            court.distanceKm != null
                                ? '${court.distanceKm} km away'
                                : 'N/A',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // price + action
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${court.pricePerHour}/hour',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: cs.primary,
                              ),
                            ),
                            if (onPrimaryAction != null &&
                                primaryActionLabel != null)
                              FilledButton(
                                onPressed: onPrimaryAction,
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  primaryActionLabel!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
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
            ],
          ),
        ),
      ),
    );
  }
}
