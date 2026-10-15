
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_diary/main.dart';

void main() {
  testWidgets('Travel Diary app opens', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelDiaryApp());

    expect(find.text('Travel Diary'), findsOneWidget);
    expect(find.text('Discover the world'), findsOneWidget);
    expect(find.text('Popular destinations'), findsOneWidget);
  });
}
