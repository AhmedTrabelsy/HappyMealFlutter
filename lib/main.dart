import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_app/MealDetailsPage.dart';
import 'package:restaurent_app/Services/MealService.dart';
import 'package:restaurent_app/meal.dart';
import 'package:restaurent_app/mealCard.dart';
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
      title: 'Happy Meals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 39, 20, 98),
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
      home: const MyHomePage(title: 'Happy Meals'),
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

  late Future<List<Meal>> futureMeals;

  @override
  void initState() {
    super.initState();
    futureMeals = ApiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const OwnersWidget(),
      FutureBuilder(
        future: futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Meal> mealList = (snapshot.data as List<Meal>).map((data) {
              return Meal(
                id: data.id,
                name: data.name,
                image: data.image,
              );
            }).toList();

            return Center(
              child: MealList(
                mealList: mealList,
                scrollController: _scrollController,
              ),
            );
          }
        },
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

class MealList extends StatelessWidget {
  final List<Meal> mealList;
  final ScrollController scrollController;
  const MealList(
      {super.key, required this.mealList, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    const transitionType = ContainerTransitionType.fade;

    return ListView.builder(
      itemCount: mealList.length,
      controller: scrollController,
      itemBuilder: ((context, index) => OpenContainer(
            transitionType: transitionType,
            // transitionDuration: const Duration(seconds: 3),
            closedBuilder: (context, VoidCallback openContainer) =>
                MealCard(meal: mealList[index]),
            openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) =>
                MealDetailsPage(meal: mealList[index]),
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
        child: Text("Categories widget"),
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
        child: Text("Orders widget"),
      ),
    );
  }
}
