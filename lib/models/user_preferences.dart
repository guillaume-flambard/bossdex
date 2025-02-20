class UserPreferences {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final Set<String> favoritesSectors;
  final String? userName;

  UserPreferences({
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.favoritesSectors = const {},
    this.userName,
  });

  UserPreferences copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    Set<String>? favoritesSectors,
    String? userName,
  }) {
    return UserPreferences(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      favoritesSectors: favoritesSectors ?? this.favoritesSectors,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toJson() => {
    'isDarkMode': isDarkMode,
    'notificationsEnabled': notificationsEnabled,
    'favoritesSectors': favoritesSectors.toList(),
    'userName': userName,
  };

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      isDarkMode: json['isDarkMode'] ?? false,
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      favoritesSectors: Set<String>.from(json['favoritesSectors'] ?? []),
      userName: json['userName'],
    );
  }
} 