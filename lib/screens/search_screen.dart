import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/boss.dart';
import 'boss_detail_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  Set<String> selectedSectors = {};
  bool onlyFavorites = false;
  RangeValues experienceRange = const RangeValues(0, 30);

  List<Boss> get filteredBosses => sampleBosses.where((boss) {
    final matchesQuery = boss.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                        boss.bio.toLowerCase().contains(searchQuery.toLowerCase());
    final matchesSectors = selectedSectors.isEmpty || selectedSectors.contains(boss.sector);
    final matchesFavorites = !onlyFavorites || boss.isFavorite;
    
    return matchesQuery && matchesSectors && matchesFavorites;
  }).toList();

  @override
  Widget build(BuildContext context) {
    final sectors = sampleBosses.map((e) => e.sector).toSet().toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Recherche avancée',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Rechercher un boss...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => searchQuery = ''),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtres',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      selected: onlyFavorites,
                      label: const Text('Favoris'),
                      onSelected: (value) => setState(() => onlyFavorites = value),
                      avatar: const Icon(Icons.favorite),
                    ),
                    ...sectors.map((sector) => FilterChip(
                      selected: selectedSectors.contains(sector),
                      label: Text(sector),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedSectors.add(sector);
                          } else {
                            selectedSectors.remove(sector);
                          }
                        });
                      },
                    )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimationLimiter(
              child: filteredBosses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun résultat trouvé',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredBosses.length,
                      itemBuilder: (context, index) {
                        final boss = filteredBosses[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Card(
                                margin: const EdgeInsets.only(bottom: 16),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BossDetailScreen(boss: boss),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(boss.image),
                                  ),
                                  title: Text(
                                    boss.name,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    boss.sector,
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
} 