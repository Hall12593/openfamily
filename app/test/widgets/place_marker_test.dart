import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:openfamily/models/place.dart';
import 'package:openfamily/widgets/place_marker.dart';

void main() {
  testWidgets('shows the place icon and name', (WidgetTester tester) async {
    final Place home = Place(
      id: 'p1',
      name: 'Home',
      icon: Place.iconForType('home'),
      address: '',
      position: const LatLng(10.5, -66.9),
      radiusMeters: 150,
      type: 'home',
    );
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: Center(child: PlaceMarker(place: home)))),
    );

    expect(find.text('Home'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
  });
}
