import 'package:flutter_test/flutter_test.dart';

import 'package:familly/app/app.dart';

void main() {
  testWidgets('홈 화면이 렌더링된다', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('가족안심'), findsOneWidget);
    expect(find.text('오늘 안심 체크'), findsOneWidget);
    expect(find.text('오늘도 괜찮아요'), findsOneWidget);
  });
}
