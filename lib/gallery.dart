import 'package:flutter/material.dart';

const List<String> images = [
  'https://picsum.photos/id/1015/600/600',
  'https://picsum.photos/id/1016/600/600',
  'https://picsum.photos/id/1018/600/600',
  'https://picsum.photos/id/1020/600/600',
  'https://picsum.photos/id/1024/600/600',
  'https://picsum.photos/id/1025/600/600',
  'https://picsum.photos/id/1035/600/600',
  'https://picsum.photos/id/1039/600/600',
  'https://picsum.photos/id/1040/600/600',
  'https://picsum.photos/id/1043/600/600',
  'https://picsum.photos/id/1050/600/600',
  'https://picsum.photos/id/1057/600/600',
  'https://picsum.photos/id/1062/600/600',
  'https://picsum.photos/id/1069/600/600',
  'https://picsum.photos/id/1074/600/600',
  'https://picsum.photos/id/1084/600/600',
];

// GALLERY PAGE
class GalleryPage extends StatelessWidget {
  final VoidCallback openDrawer;

  const GalleryPage({
    super.key,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),

      appBar: AppBar(
        title: const Text(
          'My Photo Gallery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF075B35),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: openDrawer,
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GALLERY HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(15, 12, 15, 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF075B35),
                  Color(0xFF16834A),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.photo_library_rounded,
                  color: Colors.white,
                  size: 38,
                ),
                SizedBox(height: 12),
                Text(
                  'Explore Memories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Enjoy your collection of beautiful photos.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Photos',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF075B35),
                  ),
                ),
                Text(
                  '${images.length} Photos',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // IMAGE GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: images.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
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
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        cacheWidth: 300,
                        cacheHeight: 300,
                        loadingBuilder:
                            (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: const Color(0xFFE8F5EC),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF16834A),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFE8F5EC),
                            child: const Icon(
                              Icons.broken_image_outlined,
                              color: Color(0xFF16834A),
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
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

// IMAGE DETAIL PAGE
class DetailPage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const DetailPage({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    pageController = PageController(
      initialPage: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Photo ${currentIndex + 1} of ${widget.images.length}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${((currentIndex + 1) / widget.images.length * 100).round()}%',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.images.length,

              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },

              itemBuilder: (context, index) {
                return Center(
                  child: Hero(
                    tag: 'image-$index',
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.contain,
                        loadingBuilder:
                            (context, child, progress) {
                          if (progress == null) return child;

                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white,
                            size: 60,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // BOTTOM PHOTO NAVIGATION
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF171717),
              border: Border(
                top: BorderSide(color: Colors.white12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: currentIndex > 0
                      ? () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  disabledColor: Colors.grey,
                ),

                Text(
                  '${currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed:
                      currentIndex < widget.images.length - 1
                          ? () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                  disabledColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
