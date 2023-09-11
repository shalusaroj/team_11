import 'package:get/get.dart';

import '../data/dummy_data/contest_data.dart';
import '../data/model/response/contest_model.dart';
import '../data/model/response/contest_winner_model.dart';
import '../data/model/response/participant_model.dart';
import '../data/model/response/prize_model.dart';

class ContestController extends GetxController implements GetxService {
  ContestController();

  bool isLoading = false;

  List<ContestModel> getContestList({required int matchId}) {
    return contestListData
        .where((element) => element.matchId == matchId)
        .toList();
  }

  List<ContestModel> getContestAllList() {
    return contestListData;
  }

  ContestModel getMatchHighestPrizePool({required int matchId}) {
    return getContestList(matchId: matchId)[0];
  }

  PrizeModel getContestHighestPrize({required int contestId}) {
    return getPrizeList(contestId: contestId)[0];
  }

  List<PrizeModel> getPrizeList({required int contestId}) {
    List<PrizeModel> list = [];

    for (var element in prizeListData) {
      if (element.contestId == contestId) {
        list.add(element);
      }
    }
    return list;
  }

  List<ParticipantModel> getParticipantList({required int contestId}) {
    List<ParticipantModel> list = [];

    for (var element in participantsData) {
      if (element.contestId == contestId) {
        list.add(element);
      }
    }
    return list;
  }

  List<ContestWinnerModel> getContestWinnerList({required int participantId}) {
    List<ContestWinnerModel> list = [];

    for (var element in participantsData) {
      if (element.contestId == participantId) {
        list.add(element as ContestWinnerModel);
      }
    }
    return list;
  }
}
