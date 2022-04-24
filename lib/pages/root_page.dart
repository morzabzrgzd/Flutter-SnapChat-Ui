import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:snapchat_app/data/bottom_data.dart';
import 'package:snapchat_app/pages/camera_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

int selectedIndex = 0;

List children = [
  Container(color: Colors.green),
  Container(color: Colors.blue),
  const CameraPage(),
  Container(color: Colors.pink),
  Container(color: Colors.yellow),
];

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            bottomData.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    bottomData[index]['icon'],
                    size: 20,
                    color: selectedIndex == index
                        ? bottomData[index]['color']
                        : Colors.white,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(top: 5),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? bottomData[index]['color']
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: children[selectedIndex],
    );
  }
}
