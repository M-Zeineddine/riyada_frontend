import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/court/presentation/widgets/court_card.dart';

class NearbyCourtCard extends StatelessWidget {
  const NearbyCourtCard({
    super.key,
    required this.court,
    this.onTap,
    this.onBook,
  });
  final CourtModel court;
  final VoidCallback? onTap;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    return CourtCard(
      court: court,
      onTap: onTap,
      onPrimaryAction: onBook,
      primaryActionLabel: 'Book Now',
      cardHeight: 290,
      imageHeight: 200,
    );
  }
}
