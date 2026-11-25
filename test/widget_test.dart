import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('MyHomePage renders portfolio info smoke test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    // Verify that portfolio identity info is rendered.
    expect(find.text('MyPortfolio'), findsWidgets);
    expect(find.text('2506621812'), findsOneWidget);
    expect(find.text('Muhammad Hafidz Muazzam'), findsOneWidget);
    expect(find.text('PBP C'), findsOneWidget);
  });
}
