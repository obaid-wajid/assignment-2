import 'package:flutter/material.dart';
import 'gallery.dart';

// ALBUM PAGE
class AlbumPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const AlbumPage({
    super.key,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Albums'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: openDrawer,
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(
                Icons.photo_album,
                color: Colors.green,
                size: 45,
              ),

              title: const Text(
                'My Album',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text('${images.length} Photos'),

              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const AlbumPhotosPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ALBUM PHOTOS PAGE
class AlbumPhotosPage extends StatelessWidget {
  const AlbumPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Photos'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: images.length,

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),

        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    images: images,
                    initialIndex: index,
                  ),
                ),
              );
            },

            child: Hero(
              tag: 'image-$index',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  cacheWidth: 300,
                  cacheHeight: 300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
