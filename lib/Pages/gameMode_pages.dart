import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/Custom/custom_Colors.dart';
import 'package:tic_tac_toe_flutter/Custom/elements_Custom.dart';
import 'package:tic_tac_toe_flutter/Pages/game_pages.dart';

class SelectGameMode extends StatelessWidget with elements_Customs {
  const SelectGameMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textCustom('Game Mode', 40, Colors.white),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
                color: MyColors.fondoContainer,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  elevatedButton(context, '/HomePages', false,Icons.people),
                  const SizedBox(height: 16),
                  elevatedButton(context, '/HomePages', true,Icons.phone_android),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  ElevatedButton elevatedButton(
      BuildContext context, String page, bool mode,IconData icon) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Game_pages(mode)));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3A4E71),
          minimumSize: const Size(300, 80),
          maximumSize: const Size(300, 80),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.people,
            color: Colors.amber,
            size: 64,
          ),
          const SizedBox(width: 10),
          textCustom('VS', 24, Colors.white),
          const SizedBox(width: 10),
          Icon(
            icon,
            color: Colors.green,
            size: 64,
          ),
        ],
      ),
    );
  }
}
