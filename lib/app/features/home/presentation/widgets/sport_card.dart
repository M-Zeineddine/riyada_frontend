import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/features/home/application/home_provider.dart';

class SportCard extends StatelessWidget {
  final Sport sport;
  final VoidCallback? onTap;
  const SportCard({super.key, required this.sport, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          child: SizedBox(
            width: 110,
            child: Card(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(sport.iconAsset, style: TextStyle(fontSize: 22)),
                    SizedBox(height: 10),
                    Text(sport.name),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
