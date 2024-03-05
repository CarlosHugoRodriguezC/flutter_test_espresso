import 'package:flutter/material.dart';
import 'package:flutter_test_espresso/infrastructure/models/favorites.dart';
import 'package:flutter_test_espresso/presentation/screens/favorites/favorites_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton.icon(
            onPressed: () => context.go(FavoritesScreen.routeName),
            icon: const Icon(Icons.favorite_outline),
            label: const Text('Favorites'),
          ),
        ],
      ),
      body: ListView.builder(itemBuilder: (context, index) => ItemTile(index)),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile(this.itemNo, {super.key});

  final int itemNo;

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[itemNo % Colors.primaries.length],
        ),
        title: Text(
          'Item $itemNo',
          key: Key('home_text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: favoritesList.items.contains(itemNo)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_outline),
          onPressed: () {
            favoritesList.items.contains(itemNo)
                ? favoritesList.remove(itemNo)
                : favoritesList.add(itemNo);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  favoritesList.items.contains(itemNo)
                      ? 'Added to favorites.'
                      : 'Removed from favorites.',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
