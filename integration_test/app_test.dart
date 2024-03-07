import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_espresso/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testing App', () {
    testWidgets('Favorites operations test', (widgetTester) async {
      await widgetTester.pumpWidget(MainApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (var icon in iconKeys) {
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        await widgetTester.tap(find.byKey(ValueKey(icon)));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Added to favorites.'), findsOneWidget);
      }

      await widgetTester.tap(find.text('Favorites'));
      await widgetTester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (var icon in removeIconKeys) {
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        await widgetTester.tap(find.byKey(ValueKey(icon)));
        await widgetTester.pumpAndSettle(const Duration(seconds: 2));
        expect(find.text('Removed from favorites.'), findsOneWidget);
      }

      expect(find.byIcon(Icons.close), findsNothing);
    });
  });
}
