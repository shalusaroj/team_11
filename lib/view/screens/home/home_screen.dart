import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:team11/utill/app_constants.dart';
import 'package:team11/view/screens/home/widget/match_card.dart';

import '../../../model/match_model.dart';
import '../drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<MatchModel> listCurrentSports = [];
  List<MatchModel> listCurrentTabSports = [];
  List<TabData> tabDataList = [];
  late TabController _tabController;

  // Create a map to store the fetched upcoming matches for each tab
  Map<int, List<MatchModel>> tabUpcomingMatches = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    fetchTabDataAndInitializeController();
    fetchUpcomingMatches(1);
  }

  Future<void> refreshData() async {
    await updateTabData();
  }

  Future<void> fetchTabDataAndInitializeController() async {
    await updateTabData();
    setState(() {
      _tabController = TabController(
        length: tabDataList.length,
        vsync: this,
      );

      _tabController.addListener(() {
        // Pass the tab ID to fetchUpcomingMatches when a tab is clicked
        fetchUpcomingMatches(tabDataList[_tabController.index].id);
      });
    });
  }

  Future<void> updateTabData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('auth_token');
    final apiUrl = AppConstants.allSports;

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];

        setState(() {
          tabDataList = data
              .map((item) => TabData.fromJson(item))
              .toList();
          _tabController = TabController(
            length: tabDataList.length,
            vsync: this,
          );
        });

        // Log the successful API request for tab data
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error in updateTabData: $e');
    }
  }

  Future<void> fetchUpcomingMatches(int sportId) async {
    final apiUrl = 'https://aio.thebyteiq.com/server/api/mobile/v1/upcoming-match-list';

    // Replace with your actual token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('auth_token');

    final requestData = {
      'sportsId': sportId,
    };

    try {
      // Clear the list before fetching data for the new tab
      setState(() {
        listCurrentTabSports.clear();
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> matchData = responseData['data'];

        // Parse the match data and update listCurrentTabSports
        List<MatchModel> matches = matchData
            .map((matchJson) => MatchModel.fromJson(matchJson))
            .toList();

        setState(() {
          listCurrentTabSports = matches;
        });

        // Handle the API response data here
        print('Upcoming Matches API Response:');
        print('Response status code: ${response.statusCode}');
        print('Response body: $responseData');
      } else {
        // Handle API request failure
        print('Upcoming Matches API Request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any errors
      print('Error in fetchUpcomingMatches: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabDataList.length,
      child: Scaffold(
        drawer: const DrawerScreen(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("All Matches"),
          actions: [
            IconButton(
              onPressed: () {
                //Get.to(() => const NotificationScreen());
                refreshData();
              },
              icon: Icon(Icons.notifications),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Make the tabs scrollable horizontally
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    tabs: tabDataList.map((tabData) {
                      return Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(int.parse(tabData.avatar), fontFamily: 'MaterialIcons'),
                              size: 24,
                            ),
                            SizedBox(height: 4),
                            Text(
                              tabData.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    indicatorColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            for (int index = 0; index < tabDataList.length; index++)
              Builder(
                builder: (BuildContext context) {
                  // ListView.builder is placed here to reflect changes based on the selected tab
                  return ListView.builder(
                    itemCount: listCurrentTabSports.length,
                    itemBuilder: (context, index) {
                      MatchModel model = listCurrentTabSports[index];
                      return MatchCard(matchModel: model);
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TabData {
  final int id;
  final String name;
  final String avatar;

  TabData(this.id, this.name, this.avatar);

  factory TabData.fromJson(Map<String, dynamic> json) {
    return TabData(
      json['id'] as int,
      json['name'] as String,
      json['avatar'] as String,
    );
  }
}
