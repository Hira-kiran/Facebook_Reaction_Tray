import 'package:animated_facebook_reaction/emoji_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final List<Emoji> emojies = [
    Emoji(path: "assests/angry.json", scale: 0.85),
    Emoji(path: "assests/laugh.json", scale: 0.7),
    Emoji(path: "assests/em1.json", scale: 0.7),
    Emoji(path: "assests/em2.json", scale: 0.7),
    Emoji(path: "assests/em3.json", scale: 0.7),
    Emoji(path: "assests/em4.json", scale: 0.7),
    Emoji(path: "assests/heart.json", scale: 0.7),
  ];

  int currentHoverImoji = 100;
  double currentHoverPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Facebook Reaction"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              //  height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 213, 213),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < emojies.length; i++)
                    Transform.scale(
                      scale:
                          emojies[i].scale + (currentHoverImoji == 1 ? 0.7 : 0),
                      child: Lottie.asset(emojies[i].path,
                          controller:
                              currentHoverImoji == i ? _controller : null,
                          animate: false,
                          height: 50,
                          fit: BoxFit.cover),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
                 onLongPress: () => _controller.repeat(),
              onLongPressEnd: (_) {
                 setState(() {
                  currentHoverImoji = 100;
                });
                _controller.stop();
                _controller.reset();
               
              },
           
              onLongPressDown: (details) {
                setState(() {
                  currentHoverImoji = 2;
                  currentHoverPosition = details.localPosition.dx;
                });
              },
              onLongPressMoveUpdate: (details) {
                final dragDifference =
                    details.localPosition.dx - currentHoverPosition;
                if (dragDifference.abs() > 40) {
                  dragDifference > 0 ? nextEmoji() : previousEmoji();
                }
              },
              child: Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 213, 213),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: Text(
                  "Like",
                  style: TextStyle(color: Colors.blue),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nextEmoji() {
    if (currentHoverImoji < emojies.length - 1) {
      setState(() {
        currentHoverImoji++;
      });
    }
  }

  void previousEmoji() {
    if (currentHoverImoji > 0) {
      setState(() {
        currentHoverImoji--;
      });
    }
  }
}
