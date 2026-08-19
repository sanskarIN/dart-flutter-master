import 'package:flutter/material.dart';

import 'ledger_controller.dart';
import 'ledger_entry.dart';
import 'money_parser.dart';

class PocketLedgerApp extends StatelessWidget {
  const PocketLedgerApp({super.key, required this.controller});

  final LedgerController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PocketLedger',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: LedgerHome(controller: controller),
    );
  }
}

class LedgerHome extends StatefulWidget {
  const LedgerHome({super.key, required this.controller});

  final LedgerController controller;

  @override
  State<LedgerHome> createState() => _LedgerHomeState();
}

class _LedgerHomeState extends State<LedgerHome> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _category = TextEditingController();
  EntryType _type = EntryType.expense;

  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PocketLedger')),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final controller = widget.controller;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Balance', style: Theme.of(context).textTheme.labelLarge),
                      Text(
                        formatInr(controller.book.balancePaise),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text('Income: ${formatInr(controller.book.incomePaise)}'),
                      Text('Expenses: ${formatInr(controller.book.expensePaise)}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Entry title'),
              ),
              TextField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Amount in ₹'),
              ),
              TextField(
                controller: _category,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(_type == EntryType.expense ? 'Expense' : 'Income'),
                subtitle: const Text('Switch off for income, on for expense'),
                value: _type == EntryType.expense,
                onChanged: (isExpense) => setState(
                  () => _type = isExpense ? EntryType.expense : EntryType.income,
                ),
              ),
              FilledButton.icon(
                onPressed: _addEntry,
                icon: const Icon(Icons.add),
                label: const Text('Add entry'),
              ),
              if (controller.error case final error?)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ),
              const SizedBox(height: 16),
              Text('Entries', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              if (controller.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (controller.entries.isEmpty)
                const Text('No entries yet.')
              else
                ...controller.entries.reversed.map(
                  (entry) => Card(
                    child: ListTile(
                      title: Text(entry.title),
                      subtitle: Text(entry.category),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(formatInr(entry.signedPaise)),
                          IconButton(
                            tooltip: 'Delete ${entry.title}',
                            onPressed: () => controller.removeEntry(entry.id),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addEntry() async {
    final amountPaise = parseRupeesToPaise(_amount.text);
    await widget.controller.addEntry(
      title: _title.text,
      amountPaise: amountPaise ?? 0,
      type: _type,
      category: _category.text,
    );
    if (widget.controller.error == null) {
      _title.clear();
      _amount.clear();
      _category.clear();
    }
  }
}
