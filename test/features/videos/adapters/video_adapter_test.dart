import 'package:flutter_test/flutter_test.dart';
import 'package:lojong_test_app/features/videos/adapters/video_adapter.dart';
import 'package:lojong_test_app/features/videos/models/video.dart';

void main() {
  group('Video Adapter |', () {
    test('should return a Video when converting one item of api reponse body', () {
      final video = VideoAdapter.fromMap(_mockedVideo);

      expect(video, isA<Video>());
    });
    test('should return a Video List when converting the entire api reponse body', () {
      final videos = VideoAdapter.fromList(_mockedVideos);

      expect(videos, isA<List<Video>>());
    });
  });
}

final _mockedVideo = {
  'id': 12,
  'name': 'Introdução ao Lojong',
  'description': 'Saiba como o Lojong pode te ajudar a iniciar o treino da mente.',
  'file': null,
  'url': 'https://vimeo.com/223279488',
  'url2': 'https://youtu.be/7p9pihdUmbw',
  'aws_url': 'https://1366057841.rsc.cdn77.org/pt/videos/6introlojong.mp4',
  'image': 'https://applojong.com/files/yatxhjt9zaxka1gdntqw/introthumb.jpg',
  'image_url': 'https://1776471859.rsc.cdn77.org/images/videos/introducao.jpg',
  'premium': 0,
  'order': 1
};

final _mockedVideos = [
  {
    'id': 12,
    'name': 'Introdução ao Lojong',
    'description': 'Saiba como o Lojong pode te ajudar a iniciar o treino da mente.',
    'file': null,
    'url': 'https://vimeo.com/223279488',
    'url2': 'https://youtu.be/7p9pihdUmbw',
    'aws_url': 'https://1366057841.rsc.cdn77.org/pt/videos/6introlojong.mp4',
    'image': 'https://applojong.com/files/yatxhjt9zaxka1gdntqw/introthumb.jpg',
    'image_url': 'https://1776471859.rsc.cdn77.org/images/videos/introducao.jpg',
    'premium': 0,
    'order': 1
  },
  {
    'id': 4,
    'name': 'Felicidade Genuína',
    'description': 'O que é felicidade genuína e como podemos cultivá-la?',
    'file': 'https://applojong.com/files/8ahygea0tzv1f2vh8gvo/fg.png',
    'url': 'https://vimeo.com/221875345',
    'url2': 'https://youtu.be/tSZA49-TBSg',
    'aws_url': 'https://1366057841.rsc.cdn77.org/pt/videos/1felicidadegenuina.mp4',
    'image': 'https://applojong.com/files/8ahygea0tzv1f2vh8gvo/fg.png',
    'image_url': 'https://1776471859.rsc.cdn77.org/images/videos/felicidadegenuina.jpg',
    'premium': 0,
    'order': 2
  },
  {
    'id': 3,
    'name': 'Ciência e Meditação',
    'description': 'Veja o que as pesquisas científicas descobriram sobre os efeitos da meditação na mente.',
    'file': null,
    'url': 'https://vimeo.com/221875689',
    'url2': 'https://youtu.be/uYj2K_XrJRQ',
    'aws_url': 'https://1366057841.rsc.cdn77.org/pt/videos/2cienciaemeditacao.mp4',
    'image': 'https://applojong.com/files/fwmx8rgr44yg1cpkw5ev/cem.png',
    'image_url': 'https://1776471859.rsc.cdn77.org/images/videos/videosection-ciencia-e-meditacao-3.jpg',
    'premium': 0,
    'order': 3
  },
];
