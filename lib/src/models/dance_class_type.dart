enum DanceClassType {
  hiphop,
  popping,
  locking,
  house,
  female,
}

extension DanceClassTypeX on DanceClassType {
  String getTitle() {
    switch (this) {
      case DanceClassType.hiphop:
        return 'HipHop';
      case DanceClassType.popping:
        return 'Popping';
      case DanceClassType.locking:
        return 'Locking';
      case DanceClassType.house:
        return 'House';
      case DanceClassType.female:
        return 'Female';
    }
  }

  String getDescription() {
    switch (this) {
      case DanceClassType.hiphop:
        return 'Hier liegt der Fokus auf den Grundschritten von HipHop. Du wirst dabei verschiedene Steps erlernen, um sie zukünftig selbstständig anwenden zu können.';
      case DanceClassType.popping:
        return 'Beim Popping ist das An- und Entspannen der Muskeln im Fokus. Jeder Muskel in deinem Körper wird hier zum Schwitzen gebracht.';
      case DanceClassType.locking:
        return '';
      case DanceClassType.house:
        return 'House ist eine spezielle Richtung, die vor allem ihren Fokus auf die Beine (Footwork) legt.';
      case DanceClassType.female:
        return '';
    }
  }
}
