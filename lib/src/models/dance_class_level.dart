enum DanceClassLevel {
  beginner,
  starter,
  intermediate,
  masterclass,
}

extension DanceClassLevelX on DanceClassLevel {
  String getTitle() {
    switch (this) {
      case DanceClassLevel.starter:
        return 'Starter';
      case DanceClassLevel.beginner:
        return 'Beginner';
      case DanceClassLevel.intermediate:
        return 'Intermediate';
      case DanceClassLevel.masterclass:
        return 'MasterClass';
    }
  }
}
