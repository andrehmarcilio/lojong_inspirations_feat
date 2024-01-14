import '../models/video.dart';

abstract class VideoAdapter {
  static Video fromMap(dynamic map) => Video(
        id: map['id'],
        name: map['name'],
        imageUrl: map['image_url'],
        description: map['description'],
      );

  static List<Video> fromList(List list) {
    return list.map(VideoAdapter.fromMap).toList();
  }
}
