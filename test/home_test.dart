import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_espresso/presentation/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_espresso/infrastructure/models/favorites.dart';

Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );

void main() {
  group('Home Screen Widget Tests', () {
    // BEGINNING OF NEW CONTENT
    testWidgets('Testing if ListView shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });
    // END OF NEW CONTENT

    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.text('Item 0'), findsOneWidget);

      await tester.fling(
        find.byType(ListView),
        const Offset(0, -200),
        3000,
      );

      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('Testing icon buttons', (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.favorite), findsNothing);

      await widgetTester.tap(find.byIcon(Icons.favorite_outline).first);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Added to favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.favorite).first);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
