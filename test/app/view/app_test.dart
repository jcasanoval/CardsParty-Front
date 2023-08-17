import 'package:flutter_test/flutter_test.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
