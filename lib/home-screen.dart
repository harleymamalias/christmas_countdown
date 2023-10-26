import 'dart:ui';

import 'package:flutter/material.dart';
import 'snow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime christmasDate = DateTime(DateTime.now().year, 12, 25);

  Stream<Duration> calculateRemainingTime() async* {
    while (true) {
      yield _timeRemaining();
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Duration _timeRemaining() {
    final now = DateTime.now();
    if (now.isAfter(christmasDate)) {
      christmasDate =
          DateTime(now.year + 1, 12, 25);
    }
    final difference = christmasDate.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        title: const Text(
          'CHRISTMAS COUNTDOWN',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
            color: Colors.white,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "assets/christmas1.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xFF686868).withOpacity(0.1),
                ),
              ),
            ),
          ),
          Snow(),
          StreamBuilder<Duration>(
            stream: calculateRemainingTime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final remainingTime = snapshot.data!;
                String strDigits(int n) => n.toString().padLeft(2, '0');
                final days = strDigits(remainingTime.inDays);
                final hours = strDigits(remainingTime.inHours.remainder(24));
                final minutes =
                    strDigits(remainingTime.inMinutes.remainder(60));
                final seconds =
                    strDigits(remainingTime.inSeconds.remainder(60));
                return Center(
                  child: Container(
                    width: 400,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$days:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            const Text(
                              'DAYS',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Text(
                              '$hours:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            const Text(
                              'HOURS',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Text(
                              '$minutes:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            const Text(
                              'MINUTES',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            Text(
                              seconds,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            const Text(
                              'SECONDS',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                );
              } else {
                return Text('Calculating...');
              }
            },
          ),
        ],
      ),
    );
  }
}
