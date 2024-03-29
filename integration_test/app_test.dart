import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_espresso/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (widgetTester) async {
      await widgetTester.pumpWidget(MainApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (var icon in iconKeys) {
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
        await widgetTester.tap(find.byKey(ValueKey(icon)));
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });
  });
}
