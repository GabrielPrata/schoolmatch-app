import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  late AudioPlayer _player;
  String? _currentUrl; // Variável privada para armazenar a URL atual

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal() {
    _player = AudioPlayer();
  }

  Future<void> togglePlayPause(String url) async {
    if (_player.playing && _currentUrl == url) {
      await _player.pause();
    } else {
      if (_currentUrl == url &&
          _player.processingState == ProcessingState.ready) {
        await _player.play();
      } else {
        await play(url);
      }
    }
  }

  Future<void> stopMusic() async {
    if (_player.playing) {
      await _player.pause();
    }
  }

  bool isPlaying(String url) {
    return _player.playing && _currentUrl == url;
  }

  Future<void> play(String url) async {
    try {
      await _player.stop(); // Parar qualquer áudio tocando atualmente.
      _currentUrl = url; // Atualiza a URL atual
      await _player.setUrl(url); // Carregar a nova URL.
      await _player.play(); // Iniciar a reprodução.
    } catch (e) {
      throw Exception("Erro ao reproduzir áudio: $e");
    }
  }

  void dispose() {
    _player.dispose();
  }

  String? get currentUrl => _currentUrl; // Getter público para a URL atual
}
