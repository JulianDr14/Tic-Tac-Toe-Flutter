import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_flutter/Custom/custom_Colors.dart';

mixin elements_Customs {
  Widget boton(VoidCallback onPressed, int indice, List listButtons) {
    return GestureDetector(
      onTap: listButtons[indice].estado ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: listButtons[indice].estado
              ? MyColors.buttonTicTac
              : listButtons[indice].label == ''
                  ? Colors.red
                  : listButtons[indice].label == 'X'
                      ? Colors.amber
                      : listButtons[indice].label == 'O'
                          ? Colors.green
                          : MyColors.buttonTicTac,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: listButtons[indice].ganador ? 7 : 0.0,
            color: listButtons[indice].ganador
                ? Colors.lightBlue
                : MyColors.fondoContainer,
          ),
        ),
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            listButtons[indice].label,
            style: GoogleFonts.lato(fontSize: 50, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  AnimatedContainer container(int puntajeJugador, String text, Color color, Border border) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: MyColors.fondoContainer,
          borderRadius: BorderRadius.circular(20),
          border: border
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            textCustom(puntajeJugador.toString(), 50, Colors.white),
            const SizedBox(width: 100),
            textCustom(text, 100, color),
          ],
        ),
      ),
    );
  }


  Text textCustom(String texto, double size, Color colorText) {
    return Text(
      texto,
      style: GoogleFonts.lato(
          fontSize: size, fontWeight: FontWeight.w700, color: colorText),
    );
  }
}
