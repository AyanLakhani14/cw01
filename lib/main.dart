import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('This is an Alert Dialog from Tab 1.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),

      bottomNavigationBar: const BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Bottom App Bar',
            textAlign: TextAlign.center,
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: ✅ Text + Alert Dialog
          Container(
            color: Colors.blueAccent.withOpacity(0.12),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tab 1: Text + Alert Dialog',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _showAlert(context),
                    child: const Text('Show Alert'),
                  ),
                ],
              ),
            ),
          ),

          // TAB 2 placeholder
          Container(
            color: Colors.greenAccent.withOpacity(0.12),
            child: const Center(child: Text('Tab 2 (placeholder)')),
          ),

          // TAB 3 placeholder
          Container(
            color: Colors.orangeAccent.withOpacity(0.12),
            child: const Center(child: Text('Tab 3 (placeholder)')),
          ),

          // TAB 4 placeholder
          Container(
            color: Colors.purpleAccent.withOpacity(0.12),
            child: const Center(child: Text('Tab 4 (placeholder)')),
          ),
        ],
      ),
    );
  }
}
