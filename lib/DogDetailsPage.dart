import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_app/dog.dart';

class DogDetailsPage extends StatelessWidget {
  final Dog dog;
  const DogDetailsPage({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(
              flex: 100,
              child: Stack(fit: StackFit.expand, children: [
                Image.asset(
                  dog.image,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  child: GestureDetector(
                    onTapUp: (details) {
                      Navigator.of(context).pop();
                      HapticFeedback.heavyImpact();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 35,
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 100,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dog.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 30)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Text("About me",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontSize: 20))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              dog.about,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Text(
                            "Quick Info",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "${dog.age} yrs",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    "Age",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    dog.color,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    "Color",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "${dog.weight} kg",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    "Weight",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ));
  }
}
