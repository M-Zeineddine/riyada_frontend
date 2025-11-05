import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/shared/models/sport_model.dart';

class SportCard extends StatelessWidget {
  final Sport sport;
  final VoidCallback? onTap;
  const SportCard({super.key, required this.sport, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(120, 230, 230, 230),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 85,
          // height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(sport.iconAsset, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              Text(sport.name),
            ],
          ),
        ),
      ),
    );
  }
}
