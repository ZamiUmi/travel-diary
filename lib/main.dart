
import 'package:flutter/material.dart';

void main() {
  runApp(const TravelDiaryApp());
}

const green = Color(0xFF496B58);
const background = Color(0xFFF8F7F2);

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Diary',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
      ),
      home: const HomeScreen(),
    );
  }
}


class Place {
  final String name;
  final String country;
  final String description;
  final IconData icon;
  final String imageUrl;
  final String category;
  final String bestTime;
  final String funFact;
  final String budget;

  const Place({
    required this.name,
    required this.country,
    required this.description,
    required this.icon,
    required this.imageUrl,
    required this.category,
    required this.bestTime,
    required this.funFact,
    required this.budget,
  });
}


const places = [
  Place(
    name: 'Kolsai Lakes',
    country: 'Kazakhstan',
    description:
        'Beautiful mountain lakes surrounded by forests and the Tien Shan mountains.',
    icon: Icons.water,
    imageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=900',
    category: 'Nature',
    bestTime: 'May – September',
    funFact: 'The Kolsai Lakes are known as the pearls of the Northern Tien Shan.',
    budget: '10,000–25,000 KZT'
  ),
  Place(
    name: 'Santorini',
    country: 'Greece',
    description:
        'White houses, blue domes and wonderful views of the sea.',
    icon: Icons.wb_sunny_outlined,
    imageUrl:
        'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=900',
    category: 'Sea',
    bestTime: 'April – October',
    funFact: 'Santorini is famous for its white houses and blue-domed churches.',
    budget: '€80–180 per day',
  ),
  Place(
    name: 'Swiss Alps',
    country: 'Switzerland',
    description:
        'Majestic mountains, green valleys and peaceful alpine villages.',
    icon: Icons.landscape,
    imageUrl:
        'https://images.unsplash.com/photo-1531366936337-7c912a4589a7?w=900',
    category: 'Mountains',
    bestTime: 'June – September',
    funFact: 'The Swiss Alps offer spectacular mountain views and hiking trails.',
    budget: 'CHF 100–200 per day',
  ),
  
  Place(
    name: 'Mount Fuji',
    country: 'Japan',
    description:
        'An iconic mountain with beautiful views, peaceful lakes and traditional Japanese culture.',
    icon: Icons.landscape,
    imageUrl:
        'https://images.unsplash.com/photo-1570459027562-4a916cc6113f?w=900',
    category: 'Mountains',
    bestTime: 'July – early September for climbing',
    funFact: 'Mount Fuji is Japan’s highest mountain.',
    budget: '¥8,000–20,000 per day',
  ),
  Place(
    name: 'Maldives',
    country: 'Maldives',
    description:
        'Tropical islands with turquoise water, white sandy beaches and colorful coral reefs.',
    icon: Icons.beach_access,
    imageUrl:
        'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?w=900',
    category: 'Sea',
    bestTime: 'November – April',
    funFact: 'The Maldives is made up of hundreds of islands surrounded by coral reefs.',
    budget: '100–300 per day',
  ),
  Place(
    name: 'Charyn Canyon',
    country: 'Kazakhstan',
    description:
        'A spectacular red-rock canyon with dramatic cliffs and unique desert landscapes.',
    icon: Icons.terrain,
    imageUrl:
        'https://images.unsplash.com/photo-1472396961693-142e6e269027?w=900',
    category: 'Nature',
    bestTime: 'April – June and September – October',
    funFact: 'Charyn Canyon is famous for its Valley of Castles rock formations.',
    budget: '5,000–15,000 KZT',
  ),

];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final Set<String> favorites = {};

  void toggleFavorite(String name) {
    setState(() {
      if (favorites.contains(name)) {
        favorites.remove(name);
      } else {
        favorites.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DiscoverPage(
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      FavoritesPage(
        favorites: favorites,
        onFavorite: toggleFavorite,
      ),
      const AboutPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Diary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: background,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }
}


class DiscoverPage extends StatefulWidget {
  final Set<String> favorites;
  final ValueChanged<String> onFavorite;

  const DiscoverPage({
    super.key,
    required this.favorites,
    required this.onFavorite,
  });

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'All places';

  final List<String> categories = [
    'All places',
    'Mountains',
    'Sea',
    'Nature',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = selectedCategory == 'All places'
        ? places
        : places
            .where((place) => place.category == selectedCategory)
            .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Discover the world',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263D32),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Find beautiful places for your next trip.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFDCE7DC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.landscape, size: 38, color: green),
              SizedBox(height: 12),
              Text(
                'Your next adventure',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263D32),
                ),
              ),
              Text('Explore places worth remembering'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 24),
        const Text(
          'Popular destinations',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        if (filteredPlaces.isEmpty)
          const Text('No places found.'),

        for (final place in filteredPlaces)
          PlaceCard(
            place: place,
            isFavorite: widget.favorites.contains(place.name),
            onFavorite: () => widget.onFavorite(place.name),
          ),
      ],
    );
  }
}


class PlaceCard extends StatelessWidget {
  final Place place;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const PlaceCard({
    super.key,
    required this.place,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE8E9E1)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailsPage(place: place),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  place.imageUrl,
                  width: 76,
                  height: 76,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 76,
                      height: 76,
                      color: const Color(0xFFE5EEE5),
                      child: Icon(place.icon, size: 30, color: green),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      place.country,
                      style: const TextStyle(color: green, fontSize: 13),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      place.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DetailsPage extends StatelessWidget {
  final Place place;

  const DetailsPage({super.key, required this.place});

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE7DC).withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: green, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: const Color(0xFFF8F7F2),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              place.imageUrl,
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 230,
                  color: const Color(0xFFDCE7DC),
                  child: Icon(place.icon, size: 90, color: green),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          Text(
            place.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.location_on, color: green, size: 20),
              const SizedBox(width: 5),
              Text(
                place.country,
                style: const TextStyle(fontSize: 16, color: green),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            place.description,
            style: const TextStyle(fontSize: 16, height: 1.6),
          ),

          const SizedBox(height: 28),

          const Text(
            'Travel Information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          infoCard(
            icon: Icons.calendar_month,
            title: 'Best Time to Visit',
            value: place.bestTime,
          ),

          infoCard(
            icon: Icons.lightbulb_outline,
            title: 'Did You Know?',
            value: place.funFact,
          ),

          infoCard(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Estimated Budget',
            value: place.budget,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.flight_takeoff, color: Colors.white, size: 30),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Your next adventure starts here. Add this destination to your travel wish list!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


class FavoritesPage extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onFavorite;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favoritePlaces = places
        .where((place) => favorites.contains(place.name))
        .toList();

    if (favoritePlaces.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_border, size: 60, color: green),
              SizedBox(height: 16),
              Text(
                'No favorites yet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Tap the heart on a place you like.'),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Your favorite places',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        for (final place in favoritePlaces)
          PlaceCard(
            place: place,
            isFavorite: true,
            onFavorite: () => onFavorite(place.name),
          ),
      ],
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.travel_explore, size: 72, color: green),
            SizedBox(height: 20),
            Text(
              'About Travel Diary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Discover beautiful destinations, explore new places '
              'and collect your favorite travel ideas in one app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
