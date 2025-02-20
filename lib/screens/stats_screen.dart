import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/boss.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats();
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Statistiques',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]!
                          : Theme.of(context).colorScheme.primary,
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800]!
                          : Theme.of(context).colorScheme.secondary,
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[700]!
                          : Theme.of(context).colorScheme.tertiary,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: CustomPaint(
                          painter: GridPainter(),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            '${stats.totalBosses}',
                            style: GoogleFonts.poppins(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Boss au total',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTitle('Répartition par secteur'),
                const SizedBox(height: 16),
                _buildSectorStats(stats.sectorStats, context),
                const SizedBox(height: 32),
                _buildSectionTitle('Faits intéressants'),
                const SizedBox(height: 16),
                _buildFactsGrid(stats, context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSectorStats(Map<String, int> sectorStats, BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: sectorStats.entries.map((entry) {
            final percentage = (entry.value / sampleBosses.length * 100).round();
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$percentage%',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: entry.value / sampleBosses.length,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${entry.value} boss',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFactsGrid(StatsData stats, BuildContext context) {
    final facts = [
      {
        'title': 'Secteurs',
        'value': stats.sectorStats.length.toString(),
        'icon': Icons.category,
      },
      {
        'title': 'Boss',
        'value': stats.totalBosses.toString(),
        'icon': Icons.people,
      },
      {
        'title': 'Secteur principal',
        'value': stats.mainSector,
        'icon': Icons.star,
      },
      {
        'title': 'Favoris',
        'value': stats.favoritesCount.toString(),
        'icon': Icons.favorite,
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: facts.map((fact) => _buildFactCard(fact, context)).toList(),
    );
  }

  Widget _buildFactCard(Map<String, dynamic> fact, BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              fact['icon'] as IconData,
              size: 32,
              color: Colors.blue[700],
            ),
            const SizedBox(height: 8),
            Text(
              fact['value'],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              fact['title'],
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  StatsData _calculateStats() {
    final sectorStats = <String, int>{};
    int favoritesCount = 0;
    
    for (var boss in sampleBosses) {
      sectorStats[boss.sector] = (sectorStats[boss.sector] ?? 0) + 1;
      if (boss.isFavorite) favoritesCount++;
    }

    String mainSector = sectorStats.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    return StatsData(
      sectorStats: sectorStats,
      totalBosses: sampleBosses.length,
      mainSector: mainSector,
      favoritesCount: favoritesCount,
    );
  }
}

class StatsData {
  final Map<String, int> sectorStats;
  final int totalBosses;
  final String mainSector;
  final int favoritesCount;

  StatsData({
    required this.sectorStats,
    required this.totalBosses,
    required this.mainSector,
    required this.favoritesCount,
  });
}

// Ajoutez cette classe pour le motif de fond
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    const spacing = 20.0;
    
    for (var i = 0; i < size.width.toInt(); i += spacing.toInt()) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }
    
    for (var i = 0; i < size.height.toInt(); i += spacing.toInt()) {
      canvas.drawLine(
        Offset(0, i.toDouble()),
        Offset(size.width, i.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 