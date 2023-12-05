import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_app/Models/meal.dart';
import 'package:restaurent_app/Services/AuthService.dart';

class MealDetailsPage extends StatelessWidget {
  final Meal meal;
  MealDetailsPage({super.key, required this.meal});

  final User? user = AuthService().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(
              flex: 100,
              child: Stack(fit: StackFit.expand, children: [
                Image.network(
                  meal.image,
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
                          Text(meal.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 30)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              color: const Color.fromARGB(50, 52, 188, 252),
                              child: Text(
                                meal.tags?.first ?? 'Meal',
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                        "${meal.price} DT",
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
                                meal.country,
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
                                "12 Minutes",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Text("Instructions",
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
                              meal.instructions ?? "",
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
                            "Main Ingredients",
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
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    meal.ingredient1 ?? "None",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    meal.measure1 ?? "None",
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
                                    meal.ingredient2 ?? "None",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    meal.measure2 ?? "None",
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
                                    meal.ingredient3 ?? "None",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    meal.measure3 ?? "None",
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
