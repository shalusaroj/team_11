import 'package:get/get.dart';

import '../data/dummy_data/tournament_data.dart';
import '../data/model/response/match_model.dart';
import '../data/model/response/player_model.dart';
import '../data/model/response/team_model.dart';
import '../data/model/response/tournament_model.dart';

class TournamentController extends GetxController implements GetxService {
  TournamentController();

  bool isLoading = false;

  TournamentModel getTournament({required int tournamentId}) {
    return tournamentListData
        .firstWhere((tournament) => tournament.id == tournamentId);
  }

  List<TournamentModel> getTournamentList() {
    return tournamentListData;
  }

  List<MatchModel> getMatchAllList() {
    return matchListData..sort((a, b) => a.date!.compareTo(b.date!));
  }

  List<MatchModel> getMatchList({required int tournamentId}) {
    return matchListData
        .where((element) => element.tournamentId == tournamentId)
        .toList();
  }

  List<PlayerModel> getPlayerList({required int teamId}) {
    return playerListData.where((element) => element.teamId == teamId).toList();
  }

  TeamModel getTeam({required int teamId}) {
    return teamListData.firstWhere((team) => team.id == teamId);
  }
}
