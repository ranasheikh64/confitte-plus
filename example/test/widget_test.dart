import 'package:flutter_test/flutter_test.dart';
import 'package:confettie_plus_example/main.dart';

void main() {
  testWidgets('Showcase app renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ConfettiePlusExampleApp());
    await tester.pump();
    expect(find.text('Confettie Plus'), findsOneWidget);
  });
}
