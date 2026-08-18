import 'package:dfm_part_014/part_014.dart';
import 'package:dfm_part_014/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('name and email validators reject invalid input', () {
    expect(validateName(''), isNotNull);
    expect(validateName('A'), isNotNull);
    expect(validateName('Ada'), isNull);

    expect(validateEmail(''), isNotNull);
    expect(validateEmail('not-an-email'), isNotNull);
    expect(validateEmail('reader@example.com'), isNull);
  });

  testWidgets('invalid form does not call the submitter', (tester) async {
    var calls = 0;

    await tester.pumpWidget(
      FormsMasteryApp(
        submitter: ({required name, required email}) async {
          calls++;
        },
      ),
    );

    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pump();

    expect(calls, 0);
    expect(find.text('Enter your name.'), findsOneWidget);
    expect(find.text('Enter your email address.'), findsOneWidget);
  });

  testWidgets('valid normalized values are submitted once', (tester) async {
    String? submittedName;
    String? submittedEmail;

    await tester.pumpWidget(
      FormsMasteryApp(
        submitter: ({required name, required email}) async {
          submittedName = name;
          submittedEmail = email;
        },
      ),
    );

    await tester.enterText(find.byKey(const ValueKey('name-field')), '  Ada Lovelace  ');
    await tester.enterText(find.byKey(const ValueKey('email-field')), '  ada@example.com  ');
    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pumpAndSettle();

    expect(submittedName, 'Ada Lovelace');
    expect(submittedEmail, 'ada@example.com');
    expect(find.text('Profile submitted successfully.'), findsOneWidget);
  });

  testWidgets('submission failures produce a user-facing status', (tester) async {
    await tester.pumpWidget(
      FormsMasteryApp(
        submitter: ({required name, required email}) async {
          throw StateError('simulated failure');
        },
      ),
    );

    await tester.enterText(find.byKey(const ValueKey('name-field')), 'Grace Hopper');
    await tester.enterText(find.byKey(const ValueKey('email-field')), 'grace@example.com');
    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pumpAndSettle();

    expect(find.text('Submission failed. Please try again.'), findsOneWidget);
  });
}
