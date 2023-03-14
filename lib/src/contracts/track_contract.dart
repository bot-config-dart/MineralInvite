abstract class TrackContract {
  String get title;
  String get artist;
  int get duration;
  int get startTime;
  int get endTime;

  // add likes, comments number

  Future<void> add();
  Future<void> play();
}