import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_espresso/infrastructure/models/favorites.dart';
import 'package:flutter_test_espresso/presentation/screens/favorites/favorites_screen.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesScreen(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Screen Widget Tests', () {
    testWidgets('Testing if ListView shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing Remove Button', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byIcon(Icons.close), findsNWidgets(5));

      var totalItems = widgetTester.widgetList(find.byIcon(Icons.close)).length;
      await widgetTester.tap(find.byIcon(Icons.close).first);
      await widgetTester.pumpAndSettle();
      expect(widgetTester.widgetList(find.byIcon(Icons.close)).length,
          lessThan(totalItems));

      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
