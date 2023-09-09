import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team11/view/screens/profile/widget/profile_data_field.dart';
import '../../../utill/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? profileData;
  String? authToken;
  String? userCountry; // Add this variable

  @override
  void initState() {
    super.initState();
    loadTokenAndFetchProfileData();
  }

  Future<void> loadTokenAndFetchProfileData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      authToken = preferences.getString('auth_token');

      if (authToken != null) {
        await fetchProfileData(); // Fetch profile data only if token is available
      } else {
        print('No auth token available. Cannot fetch data.');
      }
    } catch (e) {
      print('Error loading token: $e');
    }
  }

  Future<void> fetchProfileData() async {
    if (authToken == null) {
      // Handle the case when no token is available
      print('No auth token available. Cannot fetch data.');
      return;
    }

    final String apiUrl =
        'https://aio.thebyteiq.com/server/api/mobile/v1/get-user-details';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $authToken', // Include the token in the headers
    };

    try {
      final http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          profileData = responseData['data'];
          userCountry = responseData['countries'][0]['name']; // Extract user's country
        });
        print('Profile data fetched: $profileData');
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load profile data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load profile data');
    }
  }

  String getStringValue(dynamic? value) {
    return value?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Debug print for profileData
    print('profileData: $profileData');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          title: Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Images.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "My Profile"),
              Tab(text: "Career Stats"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  CircleAvatar(
                    radius: 60,
                    child: ClipOval(
                      child: Image.network(
                        "https://play-lh.googleusercontent.com/BMryS7Cn454jIAVrchF9as-7WOG07H97Lugr62ISdJSo7wj1cC-0MTUm3SqSZffc7IQ",
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (profileData != null) ...[
                    ProfileDataField(
                      title: "Name",
                      subTitle: profileData!['name'] != null && profileData!['name'].isNotEmpty
                          ? getStringValue(profileData!['name'])
                          : "N/A",
                    ),
                    ProfileDataField(
                      title: "Email",
                      subTitle: profileData!['email'] != null
                          ? getStringValue(profileData!['email'])
                          : "N/A",
                    ),
                    ProfileDataField(
                      title: "Contact",
                      subTitle: getStringValue(profileData!['mobile']),
                    ),
                    ProfileDataField(
                      title: "Date Of Birth",
                      subTitle: getStringValue(profileData!['dateOfBirth']),
                    ),
                    ProfileDataField(
                      title: "Pincode",
                      subTitle: getStringValue(profileData!['pincode']),
                    ),
                    ProfileDataField(
                      title: "Gender",
                      subTitle: getStringValue(profileData!['gender']),
                    ),
                    ProfileDataField(
                      title: "Country",
                      subTitle: userCountry ?? "N/A", // Display user's country
                    ),
                    ProfileDataField(
                      title: "State",
                      subTitle: getStringValue(profileData!['state']),
                    ),
                    ProfileDataField(
                      title: "City",
                      subTitle: getStringValue(profileData!['city']),
                    ),
                  ],
                  if (profileData == null) ...[
                    CircularProgressIndicator(),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  if (profileData != null) ...[
                    ProfileDataField(
                      title: "Contests",
                      subTitle: getStringValue(profileData!['contests']),
                    ),
                    ProfileDataField(
                      title: "Matches",
                      subTitle: getStringValue(profileData!['matches']),
                    ),
                    ProfileDataField(
                      title: "Series",
                      subTitle: getStringValue(profileData!['series']),
                    ),
                    ProfileDataField(
                      title: "Win Rate",
                      subTitle: getStringValue(profileData!['winRate']) + " %",
                    ),
                    ProfileDataField(
                      title: "Date Of Birth",
                      subTitle: getStringValue(profileData!['dateOfBirth']),
                    ),
                    ProfileDataField(
                      title: "Country",
                      subTitle: userCountry ?? "N/A", // Display user's country
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        "You have been playing Team 11 since : " +
                            getStringValue(profileData!['joinDate']),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                  if (profileData == null) ...[
                    CircularProgressIndicator(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





