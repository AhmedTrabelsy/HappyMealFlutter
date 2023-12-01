import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_app/Data/FakeDogDatabase.dart';
import 'package:restaurent_app/DogDetailsPage.dart';
import 'package:restaurent_app/dog.dart';
import 'package:restaurent_app/dogCard.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

void main() {
  runApp(const PuppyPalace());
}

class PuppyPalace extends StatelessWidget {
  const PuppyPalace({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PuppyPalace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(98, 67, 20, 1),
          onError: const Color.fromARGB(150, 252, 52, 52),
          onPrimary: const Color.fromARGB(150, 52, 188, 252),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black54,
            ),
            titleMedium: TextStyle(fontSize: 13, color: Colors.black54),
            labelSmall: TextStyle(
              fontSize: 13,
              backgroundColor: Color.fromARGB(150, 52, 188, 252),
            ),
            labelMedium: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black54)),
      ),
      home: const MyHomePage(title: 'Puppy Palace'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 1;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const OwnersWidget(),
      DogList(
        dogList: dogList,
        scrollController: _scrollController,
      ),
      const NotificationsWidget(),
    ];
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black87),
      ),
      drawer: const Drawer(),
      body: children[currentPageIndex],
      bottomNavigationBar: ScrollToHide(
        scrollController: _scrollController,
        height: 75,
        child: CurvedNavigationBar(
          index: currentPageIndex,
          backgroundColor: Colors.transparent,
          // animationDuration: const Duration(milliseconds: 400),
          color: Theme.of(context).colorScheme.inversePrimary,
          items: const [
            Icon(Icons.person),
            Icon(Icons.pets),
            Icon(Icons.notifications),
          ],
          onTap: (index) {
            setState(() {
              if (currentPageIndex != index) {
                currentPageIndex = index;
                HapticFeedback.lightImpact();
              }
            });
          },
        ),
      ),
    );
  }
}

class DogList extends StatelessWidget {
  final List<Dog> dogList;
  final ScrollController scrollController;
  const DogList(
      {super.key, required this.dogList, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    const transitionType = ContainerTransitionType.fade;

    return ListView.builder(
      itemCount: dogList.length,
      controller: scrollController,
      itemBuilder: ((context, index) => OpenContainer(
            transitionType: transitionType,
            // transitionDuration: const Duration(seconds: 3),
            closedBuilder: (context, VoidCallback openContainer) =>
                DogCard(dog: dogList[index]),
            openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) =>
                DogDetailsPage(dog: dogList[index]),
          )),
    );
  }
}

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Notifications widget"),
      ),
    );
  }
}

class OwnersWidget extends StatelessWidget {
  const OwnersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Owners widget"),
      ),
    );
  }
}
