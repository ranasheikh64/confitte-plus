import 'package:flutter/material.dart';

/// Controls playback of the [ConfettieWidget] animation.
///
/// ```dart
/// final controller = ConfettieController(duration: Duration(seconds: 5));
///
/// // Play confetti
/// controller.play();
///
/// // Stop manually
/// controller.stop();
///
/// // Always dispose in your StatefulWidget
/// controller.dispose();
/// ```
class ConfettieController extends ChangeNotifier {
  bool _isPlaying = false;

  /// How long the confetti animation runs before stopping automatically.
  Duration duration;

  ConfettieController({this.duration = const Duration(seconds: 4)});

  /// Whether confetti is currently animating.
  bool get isPlaying => _isPlaying;

  /// Start the confetti animation.
  void play() {
    if (_isPlaying) stop(); // restart if already playing
    _isPlaying = true;
    notifyListeners();
  }

  /// Stop the confetti animation immediately.
  void stop() {
    _isPlaying = false;
    notifyListeners();
  }

}
