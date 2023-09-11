import 'package:get/get.dart';
import 'package:team11/view/base/custom_snackbar.dart';

import '../data/dummy_data/tournament_data.dart';
import '../data/model/response/player_model.dart';

class MyTeamController extends GetxController implements GetxService {
  MyTeamController();

  bool isLoading = false;

  List<PlayerModel> myTeam = [];

  int playerCount = 0;
  int wkCount = 0;
  int batCount = 0;
  int arCount = 0;
  int bowlCount = 0;
  int maxCredits = 100;
  int usedCredits = 0;
  int? captainID;
  int? viceCaptainID;

  void reset() {
    myTeam.clear();
    playerCount = 0;
    wkCount = 0;
    batCount = 0;
    arCount = 0;
    bowlCount = 0;
  }

  int getCreditsLeft() {
    return maxCredits - usedCredits;
  }

  void setCaptain(int playerId) {
    captainID = playerId;
    update();
  }

  void setViceCaptain(int playerId) {
    viceCaptainID = playerId;
    update();
  }

  void calculateCredits() {
    usedCredits = 0;
    for (int i = 0; i < myTeam.length; i++) {
      usedCredits = usedCredits + myTeam[i].credits!;
    }
  }

  void countPlayers() {
    playerCount = myTeam.length;
    wkCount = myTeam
        .where((element) => element.position == Positions.wk.name)
        .toList()
        .length;
    batCount = myTeam
        .where((element) => element.position == Positions.bat.name)
        .toList()
        .length;
    arCount = myTeam
        .where((element) => element.position == Positions.ar.name)
        .toList()
        .length;
    bowlCount = myTeam
        .where((element) => element.position == Positions.bowl.name)
        .toList()
        .length;
  }

  void addPlayer(PlayerModel model) {
    countPlayers();
    calculateCredits();
    if (!myTeam.contains(model)) {
      if (myTeam
              .where((element) => element.teamId == model.teamId)
              .toList()
              .length <
          7) {
        if (playerCount < 11) {
          if (getCreditsLeft() >= model.credits!) {
            if (model.position == Positions.wk.name && wkCount < 2) {
              myTeam.add(model);
            } else if (model.position == Positions.bat.name && batCount < 5) {
              myTeam.add(model);
            } else if (model.position == Positions.ar.name && arCount < 2) {
              myTeam.add(model);
            } else if (model.position == Positions.bowl.name && bowlCount < 5) {
              myTeam.add(model);
            }
            countPlayers();
            calculateCredits();

            update();
          } else {
            showCustomSnackBar('Not Much Credit Left', isError: true);
          }
        } else {
          showCustomSnackBar('Max Player Count Reached!', isError: true);
        }
      } else {
        showCustomSnackBar('Single Team Max Player Count Reached!',
            isError: true);
      }
    } else {
      showCustomSnackBar('Player Already Added', isError: true);
    }
  }

  void removePlayer(PlayerModel model) {
    if (myTeam.contains(model)) {
      myTeam.remove(model);
      countPlayers();
      calculateCredits();
      update();
    }
  }

  bool checkPlayer(PlayerModel model) {
    return myTeam.contains(model);
  }

  List<PlayerModel> getMyTeam() {
    return myTeam;
  }
}
