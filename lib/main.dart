import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sowmya/model/TitleSwitchModel.dart';
import 'package:sowmya/provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(providerNotifier);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Demo"),
          bottom: const TabBar(
            tabs: [
              Text("Hall"),
              Text("Dinning"),
              Text("Bathroom"),
              Text("Bedroom"),
            ],
            isScrollable: true,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (model.selectedList.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select tile"),
                ),
              );
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SecondScreen(
                  list: model.selectedList,
                ),
              ),
            );
          },
          child: const Text("Next"),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.4,
                children: List.generate(
                  model.hallList.length,
                  (index) => CustomeTile(
                    switchCallBack: (v) {
                      model.switchNotifier(v, index);
                    },
                    onSelectedCallBack: () {
                      if (model.selectedList.contains(model.hallList[index])) {
                        model.removeTile(model.hallList[index]);
                        
                      } else {
                        model.addSingleTile(model.hallList[index]);
                      }
                    },
                    isSelected:
                        model.selectedList.contains(model.hallList[index]),
                    titleSwitch: model.hallList[index],
                  ),
                ).toList(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text("Dinning"),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text("Bathroom"),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text("Bedroom"),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomeTile extends StatelessWidget {
  final Function(bool) switchCallBack;
  final VoidCallback onSelectedCallBack;
  final TitleSwitch titleSwitch;
  final bool isSelected;
  const CustomeTile({
    Key? key,
    required this.switchCallBack,
    required this.isSelected,
    required this.onSelectedCallBack,
    required this.titleSwitch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return InkWell(
      onTap: () {
        onSelectedCallBack();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleSwitch.title,
                      style: style.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      titleSwitch.subTitle,
                      style: style.subtitle1!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                isSelected
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      )
                    : const SizedBox()
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OFF",
                    style: style.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Switch(
                    value: titleSwitch.status,
                    onChanged: (v) {
                      switchCallBack(v);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends ConsumerWidget {
  final List<TitleSwitch> list;
  const SecondScreen({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.4,
          children: list
              .map(
                (e) => CustomeTile(
                    switchCallBack: (v) {},
                    isSelected: true,
                    onSelectedCallBack: () {},
                    titleSwitch: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
