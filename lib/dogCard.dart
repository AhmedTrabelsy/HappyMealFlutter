// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:restaurent_app/dog.dart';

class DogCard extends StatelessWidget {
  final Dog dog;
  const DogCard({required this.dog, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      elevation: 5,
      child: Row(children: [
        Expanded(
          flex: 5,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(dog.image),
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(dog.name, style: Theme.of(context).textTheme.titleLarge),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    color: (dog.gender == 'Male'
                        ? const Color.fromARGB(50, 52, 188, 252)
                        : const Color.fromARGB(50, 252, 52, 52)),
                    child: Text(
                      dog.gender,
                      style: TextStyle(
                        fontSize: 13,
                        color: (dog.gender == "Male"
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Text(
                  "${dog.age} | ${dog.spec}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                      size: 16,
                    ),
                    Text(
                      dog.location,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.black54,
                      size: 16,
                    ),
                    Text(
                      "12 min ago",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ]),
            ]),
          ),
        ),
      ]),
    );
  }

  // dogClicked(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => const DogDetailsPage(),
  //   ));
  // }

  // dogTapped(BuildContext context) {
  //   print("cliced");
  // }
}
