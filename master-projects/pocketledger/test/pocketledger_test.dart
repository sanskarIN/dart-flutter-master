import 'package:dfm_pocketledger/app.dart';
import 'package:dfm_pocketledger/ledger_book.dart';
import 'package:dfm_pocketledger/ledger_controller.dart';
import 'package:dfm_pocketledger/ledger_entry.dart';
import 'package:dfm_pocketledger/ledger_store.dart';
import 'package:dfm_pocketledger/money_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('money parser accepts rupees with up to two decimal places', () {
    expect(parseRupeesToPaise('120'), 12000);
    expect(parseRupeesToPaise('120.5'), 12050);
    expect(parseRupeesToPaise('1,200.05'), 120005);
    expect(parseRupeesToPaise('0'), isNull);
    expect(parseRupeesToPaise('12.345'), isNull);
  });

  test('ledger book calculates income, expenses, balance, and categories', () {
    final entries = [
      LedgerEntry(
        id: '1',
        title: 'Allowance',
        amountPaise: 50000,
        type: EntryType.income,
        category: 'Income',
        occurredAt: DateTime.utc(2026, 8, 1),
      ),
      LedgerEntry(
        id: '2',
        title: 'Books',
        amountPaise: 12500,
        type: EntryType.expense,
        category: 'Learning',
        occurredAt: DateTime.utc(2026, 8, 2),
      ),
    ];

    final book = LedgerBook(entries);
    expect(book.incomePaise, 50000);
    expect(book.expensePaise, 12500);
    expect(book.balancePaise, 37500);
    expect(book.expenseByCategory(), {'Learning': 12500});
    expect(book.entriesForMonth(2026, 8), hasLength(2));
  });

  test('controller persists added and removed entries', () async {
    final store = InMemoryLedgerStore();
    var id = 0;
    final controller = LedgerController(
      store: store,
      idFactory: () => 'e-${id++}',
      clock: () => DateTime.utc(2026, 8, 19),
    );

    await controller.load();
    await controller.addEntry(
      title: 'Course',
      amountPaise: 19900,
      type: EntryType.expense,
      category: 'Learning',
    );
    expect((await store.readAll()).single.title, 'Course');

    await controller.removeEntry('e-0');
    expect(await store.readAll(), isEmpty);
  });

  testWidgets('ledger UI displays an added entry', (tester) async {
    var id = 0;
    final controller = LedgerController(
      store: InMemoryLedgerStore(),
      idFactory: () => 'e-${id++}',
      clock: () => DateTime.utc(2026, 8, 19),
    );

    await tester.pumpWidget(PocketLedgerApp(controller: controller));
    await tester.pump();

    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'Notebook');
    await tester.enterText(fields.at(1), '75.50');
    await tester.enterText(fields.at(2), 'Learning');
    await tester.tap(find.text('Add entry'));
    await tester.pump();

    expect(find.text('Notebook'), findsOneWidget);
    expect(find.text('-₹75.50'), findsOneWidget);
  });
}
