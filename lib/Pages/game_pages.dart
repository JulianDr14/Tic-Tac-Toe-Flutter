import 'package:flutter/material.dart';
import '../Custom/custom_Colors.dart';
import '../Logic/IA_Minimax.dart';
import '../Custom/elements_Custom.dart';

class Game_pages extends StatefulWidget {
  final bool modoActivoCpu;
  const Game_pages(this.modoActivoCpu, {super.key});

  @override
  State<Game_pages> createState() => _Game_pagesState();
}

class _Game_pagesState extends State<Game_pages>  with ia_Minimax, elements_Customs{
  bool humano = true;
  bool hayGANADOR = false;
  bool empate = false;
  String ganadorXoO = '';
  int puntajeJugador1 = 0;
  int puntajeJugador2 = 0;
  int movimiento = 0;
  List<structuraBoton> listButtons = List.generate(
      9, (index) => structuraBoton(label: '', estado: true, ganador: false));
  bool visibleBotonReiniciar = false;

  @override
  Widget build(BuildContext context) {
    var borderX = Border.all(
      width: humano ? 7 : 7,
      color: getColorX()
    );

    var borderO = Border.all(
        width: humano ? 7 : 7,
        color: getColorO()
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 40,)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                container(puntajeJugador1, 'X', Colors.amber, borderX),
                const SizedBox(width: 30),
                container(puntajeJugador2, 'O', Colors.green, borderO)
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.fondoContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boton(() {
                            ControlMovimientos(0);
                          }, 0, listButtons),
                          const SizedBox(height: 16),
                          boton(() {
                            ControlMovimientos(1);
                          }, 1, listButtons),
                          const SizedBox(height: 16),
                          boton(() {
                            ControlMovimientos(2);
                          }, 2, listButtons),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boton(() {
                            ControlMovimientos(3);
                          }, 3, listButtons),
                          const SizedBox(height: 16),
                          boton(() {
                            ControlMovimientos(4);
                          }, 4, listButtons),
                          const SizedBox(height: 16),
                          boton(() {
                            ControlMovimientos(5);
                          }, 5, listButtons),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boton(() {
                            ControlMovimientos(6);
                          }, 6, listButtons),
                          const SizedBox(height: 16),
                          boton(() {
                            ControlMovimientos(7);
                          }, 7, listButtons),
                          const SizedBox(height: 16),
                          boton(() {
                            ControlMovimientos(8);
                          }, 8, listButtons),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            AnimatedOpacity(
              opacity: visibleBotonReiniciar ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: ElevatedButton(
                onPressed: visibleBotonReiniciar
                    ? () {
                  for (var boton in listButtons) {
                    boton.estado = true;
                    boton.ganador = false;
                    boton.label = '';
                  }
                  setState(() {
                    humano = true;
                    movimiento = 0;
                    hayGANADOR = false;
                    ganadorXoO = '';
                    empate = false;

                  });

                  visibleBotonReiniciar = !visibleBotonReiniciar;
                }
                    : null,
                onLongPress: visibleBotonReiniciar
                    ? () {
                  for (var boton in listButtons) {
                    boton.estado = true;
                    boton.ganador = false;
                    boton.label = '';
                  }
                  setState(() {
                    humano = true;
                    puntajeJugador1 = 0;
                    puntajeJugador2 = 0;
                    movimiento = 0;
                    hayGANADOR = false;
                    ganadorXoO = '';
                    empate = false;

                    visibleBotonReiniciar = !visibleBotonReiniciar;
                  });
                }
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.moradoBoton,
                    minimumSize: const Size(50, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: textCustom('Reiniciar', 20, Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColorX(){
    if(!hayGANADOR){
      if(humano){
        return Colors.amber;
      }
    }else{
      if(hayGANADOR && ganadorXoO == 'X' && !empate){
        return Colors.white;
      }
      return MyColors.fondoContainer;
    }

    return MyColors.fondoContainer;
  }

  Color getColorO(){
    if(!hayGANADOR){
      if(!humano){
        return Colors.green;
      }
    }else{
      if(hayGANADOR && ganadorXoO == 'O' && !empate){
        return Colors.white;
      }
      return MyColors.fondoContainer;
    }

    return MyColors.fondoContainer;
  }

  void ComprobarGanador() {
    bool hayGanador = false;
    for (List<int> ganador in cambinacionesGanadoras) {
      String primero = listButtons[ganador[0]].label;

      if (primero != '' &&
          primero == listButtons[ganador[1]].label &&
          primero == listButtons[ganador[2]].label) {
        listButtons[ganador[0]].ganador = true;
        listButtons[ganador[1]].ganador = true;
        listButtons[ganador[2]].ganador = true;
        for (var boton in listButtons) {
          boton.estado = false;
        }
        hayGanador = !hayGanador;
        hayGANADOR = true;
        ganadorXoO = listButtons[ganador[1]].label;
        humano ? puntajeJugador2++ : puntajeJugador1++;
        visibleBotonReiniciar = !visibleBotonReiniciar;
        break;
      }
    }

    if (movimiento >= 9 && !hayGanador) {
      visibleBotonReiniciar = !visibleBotonReiniciar;
      for (var boton in listButtons) {
        boton.ganador = true;
      }
      hayGANADOR = true;
      empate = true;
    }
  }

  void ControlMovimientos(int indice) {
    setState(() {
      ControlBoton(indice);
      widget.modoActivoCpu? ControlBotonIA() : null;
    });
  }

  void ControlBoton(int indice) {
    listButtons[indice].label = humano ? 'X' : 'O';
    listButtons[indice].estado = false;
    humano = !humano;
    movimiento++;
    movimiento >= 5 ? ComprobarGanador() : null;
  }

  void ControlBotonIA() {
    int bestVal = -1000;
    int bestMove = -1;
    int alpha = -1000;
    int beta = 1000;

    for (int i = 0; i < listButtons.length; i++) {
      if (listButtons[i].label == '') {
        listButtons[i].label = 'O';
        int moveVal = minimax(listButtons, 0, alpha, beta, false);
        listButtons[i].label = '';

        if (moveVal > bestVal) {
          bestMove = i;
          bestVal = moveVal;
        }
      }
    }

    if (bestMove != -1) {
      ControlBoton(bestMove);
    }
  }
}

class structuraBoton {
  String label;
  bool estado;
  bool ganador;

  structuraBoton(
      {required this.label, required this.estado, required this.ganador});
}