class Seance {
  final int reservationId;
  final int places;
  final String film;
  final String affiche;
  final String jourProjection;
  final String heureDebut;
  final String heureFin;
  final int numeroSalle;

  Seance({
    required this.reservationId,
    required this.places,
    required this.film,
    required this.affiche,
    required this.jourProjection,
    required this.heureDebut,
    required this.heureFin,
    required this.numeroSalle,
  });

  factory Seance.fromJson(Map<String, dynamic> json) {
    return Seance(
      reservationId: json['reservation_id'],
      places: json['places'],
      film: json['film'],
      affiche: json['affiche'],
      jourProjection: json['jour_projection'],
      heureDebut: json['heure_debut'],
      heureFin: json['heure_fin'],
      numeroSalle: json['numero_salle'],
    );
  }
} 