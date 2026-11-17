import 'package:flutter/material.dart';

import '../models/place.dart';
import '../theme/app_theme.dart';

/// A saved place on the map: a small icon badge with its name underneath.
/// The place's arrive/leave radius is drawn separately by the map as a circle.
class PlaceMarker extends StatelessWidget {
  const PlaceMarker({super.key, required this.place});

  /// Width of the marker, wide enough for a short name under the badge.
  static const double width = 96;

  /// Height of the badge plus one line of label.
  static const double height = 54;

  final Place place;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Semantics(
        label: place.name,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.purple,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: const [
                  BoxShadow(color: Color(0x33000000), blurRadius: 3),
                ],
              ),
              child: Icon(place.icon, color: Colors.white, size: 16),
            ),
            const SizedBox(height: 2),
            Text(
              place.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.purple,
                shadows: [
                  Shadow(color: Colors.white, blurRadius: 3),
                  Shadow(color: Colors.white, blurRadius: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
