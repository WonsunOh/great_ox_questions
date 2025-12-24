import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:great_ox_questions/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // 앱이 로드되면 홈 화면의 타이틀이 표시됨
    await tester.pumpAndSettle();
    expect(find.text('O/X 문제 풀이'), findsOneWidget);
  });
}
