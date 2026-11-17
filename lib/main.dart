import 'dart:async';
import 'package:flutter/material.dart';
import 'gallery.dart';
import 'album.dart';

void main() {
  runApp(const MyApp());
}

// APP THEME
class AppColors {
  static const primary = Color(0xFF16834A);
  static const darkGreen = Color(0xFF075B35);
  static const lightGreen = Color(0xFFE8F5EC);
  static const background = Color(0xFFF6F8F7);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riphah Flutter App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.darkGreen,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// --------------------------------------------------
// 1. SPLASH SCREEN
// --------------------------------------------------

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkGreen,
              AppColors.primary,
              Color(0xFF48B477),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 75,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Riphah International',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Islamabad Campus',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 35),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// 2. MAIN PAGE
// --------------------------------------------------

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void openSimplePage(String title) {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimplePage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        openDrawer: openDrawer,
        onNavigateToList: () => changePage(1),
        onNavigateToAbout: () => changePage(2),
      ),
      ListScreen(openDrawer: openDrawer),
      AboutScreen(openDrawer: openDrawer),
      GalleryPage(openDrawer: openDrawer),
      AlbumPage(openDrawer: openDrawer),
    ];

    return Scaffold(
      key: scaffoldKey,

      // DRAWER
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.darkGreen,
                    AppColors.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                accountName: Text(
                  'Obaid',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text('obaidwajid035@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 38,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            drawerItem(Icons.home_rounded, 'Home Screen', 0),
            drawerItem(Icons.list_alt_rounded, 'List Screen', 1),
            drawerItem(Icons.info_outline_rounded, 'About Screen', 2),

            const Divider(indent: 16, endIndent: 16),

            drawerItem(Icons.photo_library_rounded, 'Photos Gallery', 3),
            drawerItem(Icons.photo_album_rounded, 'My Albums', 4),

            const Divider(indent: 16, endIndent: 16),

            ListTile(
              leading: const Icon(Icons.cake_outlined),
              title: const Text('Birthdays'),
              onTap: () => openSimplePage('Birthdays'),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Reminders'),
              onTap: () => openSimplePage('Reminders'),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => openSimplePage('Settings'),
            ),
          ],
        ),
      ),

      // KEEP SCREENS ALIVE
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: NavigationBar(
        height: 68,
        backgroundColor: Colors.white,
        selectedIndex: selectedIndex < 3 ? selectedIndex : 0,
        indicatorColor: AppColors.lightGreen,
        onDestinationSelected: changePage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt_rounded),
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, int index) {
    return ListTile(
      selected: selectedIndex == index,
      selectedTileColor: AppColors.lightGreen,
      selectedColor: AppColors.primary,
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        changePage(index);
      },
    );
  }
}

// --------------------------------------------------
// COMMON APP BAR
// --------------------------------------------------

AppBar customAppBar(String title, VoidCallback openDrawer) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: IconButton(
      onPressed: openDrawer,
      icon: const Icon(Icons.menu_rounded),
    ),
  );
}

// --------------------------------------------------
// COMMON IMAGE WIDGET
// --------------------------------------------------

Widget networkImage(
  String url, {
  double? height,
  double? width,
  BoxFit fit = BoxFit.cover,
}) {
  return Image.network(
    url,
    height: height,
    width: width,
    fit: fit,
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;

      return Container(
        height: height,
        width: width,
        color: AppColors.lightGreen,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        height: height,
        width: width,
        color: AppColors.lightGreen,
        alignment: Alignment.center,
        child: const Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.primary,
          size: 40,
        ),
      );
    },
  );
}

// --------------------------------------------------
// 3. HOME SCREEN
// --------------------------------------------------

class HomeScreen extends StatelessWidget {
  final VoidCallback openDrawer;
  final VoidCallback onNavigateToList;
  final VoidCallback onNavigateToAbout;

  const HomeScreen({
    super.key,
    required this.openDrawer,
    required this.onNavigateToList,
    required this.onNavigateToAbout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Home Screen', openDrawer),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WELCOME SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.darkGreen,
                    AppColors.primary,
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 55,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to My App!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Riphah International University',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Islamabad Campus',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Quick Overview',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),

            const SizedBox(height: 14),

            // ALARM CARD
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: const ListTile(
                contentPadding: EdgeInsets.all(15),
                leading: CircleAvatar(
                  radius: 27,
                  backgroundColor: AppColors.lightGreen,
                  child: Icon(
                    Icons.alarm_rounded,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                title: Text(
                  'Alarm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                subtitle: Text("Alarm at 10 o'clock"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Explore Your App',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),

            const SizedBox(height: 14),

            // QUICK NAVIGATION CARDS
            Row(
              children: [
                Expanded(
                  child: quickCard(
                    icon: Icons.list_alt_rounded,
                    title: '10 Cities',
                    subtitle: 'View List',
                    onTap: onNavigateToList,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: quickCard(
                    icon: Icons.grid_view_rounded,
                    title: '6 Photos',
                    subtitle: 'About Grid',
                    onTap: onNavigateToAbout,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Center(
              child: Text(
                'Made with Flutter ❤️',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quickCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 23,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 38,
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// 4. LIST SCREEN - 10 CITIES
// --------------------------------------------------

class ListScreen extends StatelessWidget {
  final VoidCallback openDrawer;

  const ListScreen({
    super.key,
    required this.openDrawer,
  });

  static const List<Map<String, String>> items = [
    {
      'title': 'Islamabad',
      'subtitle': 'Capital City of Pakistan',
      'image': 'https://picsum.photos/id/1015/600/600',
      'rating': '4.9',
    },
    {
      'title': 'Lahore',
      'subtitle': 'Cultural Heart of Pakistan',
      'image': 'https://picsum.photos/id/1016/600/600',
      'rating': '4.8',
    },
    {
      'title': 'Karachi',
      'subtitle': 'City of Lights & Sea Port',
      'image': 'https://picsum.photos/id/1018/600/600',
      'rating': '4.7',
    },
    {
      'title': 'Peshawar',
      'subtitle': 'City of Flowers & History',
      'image': 'https://picsum.photos/id/1020/600/600',
      'rating': '4.6',
    },
    {
      'title': 'Quetta',
      'subtitle': 'Fruit Garden of Pakistan',
      'image': 'https://picsum.photos/id/1024/600/600',
      'rating': '4.5',
    },
    {
      'title': 'Multan',
      'subtitle': 'City of Saints & Sufis',
      'image': 'https://picsum.photos/id/1025/600/600',
      'rating': '4.7',
    },
    {
      'title': 'Faisalabad',
      'subtitle': 'Manchester of Pakistan',
      'image': 'https://picsum.photos/id/1035/600/600',
      'rating': '4.5',
    },
    {
      'title': 'Sialkot',
      'subtitle': 'Sports Goods Capital',
      'image': 'https://picsum.photos/id/1039/600/600',
      'rating': '4.8',
    },
    {
      'title': 'Murree',
      'subtitle': 'Queen of Hills Resort',
      'image': 'https://picsum.photos/id/1040/600/600',
      'rating': '4.9',
    },
    {
      'title': 'Hunza Valley',
      'subtitle': 'Beautiful Mountain Valley',
      'image': 'https://picsum.photos/id/1043/600/600',
      'rating': '5.0',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: openDrawer,
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Explore Cities',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkGreen,
                      AppColors.primary,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_city_rounded,
                    size: 85,
                    color: Colors.white30,
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(14),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];

                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 17),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ItemDetailPage(item: item),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              networkImage(
                                item['image']!,
                                height: 185,
                                width: double.infinity,
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 17,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item['rating']!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkGreen,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item['subtitle']!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// CITY DETAIL PAGE
// --------------------------------------------------

class ItemDetailPage extends StatelessWidget {
  final Map<String, String> item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: networkImage(
                item['image']!,
                height: 240,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              item['title']!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item['subtitle']!,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Rating: ${item['rating']} / 5.0',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// 5. ABOUT SCREEN - 6 GRID ITEMS
// --------------------------------------------------

class AboutScreen extends StatelessWidget {
  final VoidCallback openDrawer;

  const AboutScreen({
    super.key,
    required this.openDrawer,
  });

  static const List<Map<String, String>> gridItems = [
    {
      'title': 'Mountain River Valley',
      'image': 'https://picsum.photos/id/1015/500/500',
    },
    {
      'title': 'Rocky Canyon Cliffs',
      'image': 'https://picsum.photos/id/1016/500/500',
    },
    {
      'title': 'Green Forest Hills',
      'image': 'https://picsum.photos/id/1018/500/500',
    },
    {
      'title': 'Waterfall & Stream',
      'image': 'https://picsum.photos/id/1039/500/500',
    },
    {
      'title': 'Ocean Jellyfish',
      'image': 'https://picsum.photos/id/1069/500/500',
    },
    {
      'title': 'Wild Animals & Nature',
      'image': 'https://picsum.photos/id/1084/500/500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('About Screen', openDrawer),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // UNIVERSITY CARD
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 32,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Riphah International University',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Islamabad Campus • Faculty of Computing',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  'Assignment: Flutter Animation, Navigation & Scrollable Lists.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Campus Highlights',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),

          const SizedBox(height: 15),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridItems.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final item = gridItems[index];

              return Card(
                color: Colors.white,
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: networkImage(item['image']!),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 12,
                      ),
                      child: Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// 6. BIRTHDAYS / REMINDERS / SETTINGS
// --------------------------------------------------

class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;

    switch (title) {
      case 'Birthdays':
        icon = Icons.cake_rounded;
        break;
      case 'Reminders':
        icon = Icons.notifications_active_rounded;
        break;
      default:
        icon = Icons.settings_rounded;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(30),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.lightGreen,
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$title Page',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
