import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/boss.dart';
import '../services/favorites_service.dart';
import 'package:share_plus/share_plus.dart';

class BossDetailScreen extends StatefulWidget {
  final Boss boss;

  const BossDetailScreen({
    super.key,
    required this.boss,
  });

  @override
  State<BossDetailScreen> createState() => _BossDetailScreenState();
}

class _BossDetailScreenState extends State<BossDetailScreen> {
  late Boss boss;

  @override
  void initState() {
    super.initState();
    boss = widget.boss;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: () {
                  Share.share(
                    'Découvrez ${boss.name}, ${boss.sector}\n\n${boss.bio}',
                    subject: 'Profil de ${boss.name}',
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Hero(
                tag: 'boss_name_${boss.name}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    boss.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'boss_image_${boss.name}',
                    child: Image.network(
                      boss.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      boss.sector,
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Biographie',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    boss.bio,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.6,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await FavoritesService.toggleFavorite(boss);
          setState(() {});
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                boss.isFavorite ? 'Ajouté aux favoris' : 'Retiré des favoris',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              duration: const Duration(seconds: 1),
            ),
          );
        },
        label: Text(
          boss.isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        icon: Icon(
          boss.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: boss.isFavorite ? Colors.red : Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
} 