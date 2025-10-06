class Doctor {
  final String name;
  final String specialty;
  final double avgRating;
  final int reviewsCount;

  Doctor({
    required this.name,
    required this.specialty,
    required this.avgRating,
    required this.reviewsCount,
  });

  // Iniciais do nome, pra avatar
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}