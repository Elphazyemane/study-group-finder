import 'package:flutter_test/flutter_test.dart';
import 'package:study_group_finder/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const StudyGroupApp());
  });
}