class Boss {
  final String name;
  final String bio;
  final String sector;
  final String image;
  bool isFavorite;

  Boss({
    required this.name,
    required this.bio,
    required this.sector,
    required this.image,
    this.isFavorite = false,
  });

  // Pour la sérialisation
  Map<String, dynamic> toJson() => {
    'name': name,
    'bio': bio,
    'sector': sector,
    'image': image,
    'isFavorite': isFavorite,
  };

  // Pour la désérialisation
  factory Boss.fromJson(Map<String, dynamic> json) => Boss(
    name: json['name'],
    bio: json['bio'],
    sector: json['sector'],
    image: json['image'],
    isFavorite: json['isFavorite'] ?? false,
  );
}

List<Boss> sampleBosses = [
  Boss(
    name: "Whitney Wolfe Herd",
    bio: "Fondatrice de Bumble, elle a révolutionné les applications de rencontre en mettant les femmes aux commandes. Son approche innovante a transformé l'industrie des rencontres en ligne.",
    sector: "Tech",
    image: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800&h=800&fit=crop",
  ),
  Boss(
    name: "Sara Blakely",
    bio: "Fondatrice de Spanx, elle a bâti un empire de la mode féminine sans aucun financement externe. Son histoire inspire les entrepreneurs du monde entier.",
    sector: "Mode",
    image: "https://images.unsplash.com/photo-1589483232748-515c025575d5?w=800&h=800&fit=crop",
  ),
  Boss(
    name: "Oprah Winfrey",
    bio: "Icône des médias et philanthrope, elle a construit un empire médiatique tout en ayant un impact positif sur la société. Son influence s'étend bien au-delà de la télévision.",
    sector: "Médias",
    image: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=800&h=800&fit=crop",
  ),
  Boss(
    name: "Arianna Huffington",
    bio: "Co-fondatrice du Huffington Post et CEO de Thrive Global, elle redéfinit le bien-être au travail et la réussite professionnelle.",
    sector: "Médias",
    image: "https://images.unsplash.com/photo-1557862921-37829c790f19?w=800&h=800&fit=crop",
  ),
];