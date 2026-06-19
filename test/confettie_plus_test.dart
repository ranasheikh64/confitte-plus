import 'package:flutter_test/flutter_test.dart';
import 'package:confettie_plus/confettie_plus.dart';

void main() {
  test('ConfettieController initial state is not playing', () {
    final controller = ConfettieController();
    expect(controller.isPlaying, false);
    controller.dispose();
  });

  test('ConfettieController play sets isPlaying to true', () {
    final controller = ConfettieController();
    controller.play();
    expect(controller.isPlaying, true);
    controller.dispose();
  });

  test('ConfettieController stop sets isPlaying to false', () {
    final controller = ConfettieController();
    controller.play();
    controller.stop();
    expect(controller.isPlaying, false);
    controller.dispose();
  });

  test('ConfettieController notifies listeners on play', () {
    final controller = ConfettieController();
    var notified = false;
    controller.addListener(() => notified = true);
    controller.play();
    expect(notified, true);
    controller.dispose();
  });

  test('StarShape is a ConfettieShape', () {
    const shape = StarShape();
    expect(shape, isA<ConfettieShape>());
  });

  test('HeartShape is a ConfettieShape', () {
    const shape = HeartShape();
    expect(shape, isA<ConfettieShape>());
  });
}
