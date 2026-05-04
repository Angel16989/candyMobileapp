import 'package:candy_mobile_app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders CandyLand shell', (WidgetTester tester) async {
    await tester.pumpWidget(const CandyShopApp());

    expect(find.text('CandyLand'), findsWidgets);
    expect(find.text('Sweet Categories'), findsOneWidget);
  });
}
