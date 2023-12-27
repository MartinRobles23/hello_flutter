import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hello_flutter/ui/providers/theme_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => {
                    setState(() {
                      _counter = 0;
                    })
                  },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                // ref.read(darkThemeProvider.notifier).update((state) => !state);
                ref.read(themeNotifierProvider.notifier).toggleDarkMode();
              },
              icon: Icon(isDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined)),
          const ShowBottomSheet()
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: Wrap(alignment: WrapAlignment.center, children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Column(children: [
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 16,
            ),
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            )
          ]),
        ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ShowBottomSheet extends ConsumerWidget {
  const ShowBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    //final List<Color> colors = AppTheme().getColorList();

    final List<Color> colors = ref.watch(colorListProvider);
    final int selectedIndex = ref.watch(themeNotifierProvider).selectedColor;

    return Center(
      child: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      const Text('Theme BottomSheet'),
                      Expanded(
                        child: ListView.builder(
                          itemCount: colors.length,
                          itemBuilder: (context, index) {
                            final color = colors[index];
                            return RadioListTile(
                              title: Text("This color",
                                  style: TextStyle(color: color)),
                              subtitle: Text("${color.value}"),
                              activeColor: color,
                              value: index,
                              groupValue: selectedIndex,
                              onChanged: (value) {
                                ref
                                    .read(themeNotifierProvider.notifier)
                                    .changeColorIndex(value!);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
