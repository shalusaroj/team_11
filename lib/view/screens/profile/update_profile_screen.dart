import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team11/view/screens/auth/widget/input_field.dart';

class UserProfile {
  final String name;
  final String email;
  final String contact;
  final String dob;
  final String gender;
  final String country;
  final String state;
  final String? city;

  UserProfile({
    required this.name,
    required this.email,
    required this.contact,
    required this.dob,
    required this.gender,
    required this.country,
    required this.state,
    this.city,
  });
}

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? selectedGender = "Male";
  String? selectedCountry;
  String? authToken;
  UserProfile? userProfile;
  bool isLoading = true;

  Map<String, IconData> flagIcons = {
    'USA': Icons.flag,
    'Canada': Icons.flag,
    'India': Icons.flag,
    'Nepal': Icons.flag,
  };

  List<Map<String, dynamic>> countries = [
    {'name': 'USA'},
    {'name': 'Canada'},
    {'name': 'India'},
    {'name': 'Nepal'},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final newDate = DateTime(picked.year, picked.month, picked.day);
      final dateFormatter = DateFormat('yyyy-MM-dd');
      final formattedDate = dateFormatter.format(newDate);

      print('Selected Date: $formattedDate'); // Add this line for debugging

      setState(() {
        selectedDate = newDate;
        _dobController.text = formattedDate;
      });

      // Call updateUserProfile to update the date of birth on the server
      updateUserProfile();
    }
  }



  void showGenderPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenderPopup(
          selectedGender: selectedGender,
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedGender = result;
        _genderController.text = result; // Update the text field
      });

      // Call updateUserProfile to update the gender on the server
      updateUserProfile();
    }
  }

  @override
  void initState() {
    super.initState();
    final dateFormatter = DateFormat('yyyy-MM-dd');
    _dobController.text = dateFormatter.format(selectedDate);
    selectedGender = "Male";

    fetchUserProfile();
  }

  void showCountryPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CountryPopup(
          selectedCountry: selectedCountry,
          countries: countries,
          flagIcons: flagIcons,
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedCountry = result['name'];
        _countryController.text = result['name']; // Update the text field
      });

      // Call updateUserProfile to update the country on the server
      updateUserProfile();
    }
  }

  Future<void> fetchUserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    authToken = preferences.getString('auth_token');
    final url = Uri.parse('https://aio.thebyteiq.com/server/api/mobile/v1/get-user-details');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final userData = responseData['data'];
        final countriesData = responseData['countries'];

        setState(() {
          userProfile = UserProfile(
            name: userData['name'] != null ? userData['name'].toString() : 'N/A',
            email: userData['email'] != null ? userData['email'].toString() : 'N/A',
            contact: userData['mobile'] != null ? userData['mobile'].toString() : 'N/A',
            dob: userData['dob'] != null ? userData['dob'].toString() : 'N/A',
            gender: userData['gender'] != null ? userData['gender'].toString() : 'N/A',
            country: countriesData.isNotEmpty ? countriesData[0]['name'] != null ? countriesData[0]['name'].toString() : 'N/A' : 'N/A',
            state: userData['state'] != null ? userData['state'].toString() : 'N/A',
            city: userData['city'] != null ? userData['city'].toString() : 'N/A',
          );

          _nameController.text = userProfile?.name ?? '';
          _emailController.text = userProfile?.email ?? '';
          _mobileController.text = userProfile?.contact ?? '';
          _cityController.text = userProfile?.city ?? '';
          _stateController.text = userProfile?.state ?? '';
          _genderController.text = userProfile?.gender ?? '';
          _countryController.text = userProfile?.country ?? '';

          isLoading = false; // Set loading to false once data is loaded.

          // Print the profile response
          print('Profile Response: $responseData');
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        isLoading = false; // Set loading to false in case of an error.
      }
    } catch (error) {
      print('Error: $error');
      isLoading = false; // Set loading to false in case of an error.
    }
  }

  Future<void> updateUserProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    authToken = preferences.getString('auth_token');
    final apiUrl = Uri.parse('https://aio.thebyteiq.com/server/api/mobile/v1/update-profile');

    try {
      final response = await http.put(
        apiUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
           'dob': _dobController.text,
          'gender': _genderController.text,
          'country': _countryController.text,
          'state': _stateController.text,
          'city': _cityController.text,
        }),
      );

      if (response.statusCode == 200) {
        final updatedUserData = jsonDecode(response.body);

        if (updatedUserData['success'] == true) {
          final userData = updatedUserData['data'];

          setState(() {
            userProfile = UserProfile(
              name: userData['name'] != null ? userData['name'].toString() : 'N/A',
              email: userData['email'] != null ? userData['email'].toString() : 'N/A',
              contact: userData['mobile'] != null ? userData['mobile'].toString() : 'N/A',
              dob: userData['dob'] != null ? userData['dob'].toString() : 'N/A',
              gender: userData['gender'] != null ? userData['gender'].toString() : 'N/A',
              country: countries.isNotEmpty ? countries[0]['name'] != null ? countries[0]['name'].toString() : 'N/A' : 'N/A',
              state: userData['state'] != null ? userData['state'].toString() : 'N/A',
              city: userData['city'] != null ? userData['city'].toString() : 'N/A',
            );

            _nameController.text = userProfile?.name ?? 'N/A';
            _emailController.text = userProfile?.email ?? 'N/A';
            _dobController.text = userProfile?.dob ?? 'N/A';
            _mobileController.text = userProfile?.contact ?? 'N/A';
            _cityController.text = userProfile?.city ?? 'N/A';
            _stateController.text = userProfile?.state ?? 'N/A';
            _genderController.text = userProfile?.gender ?? 'N/A';
            _countryController.text = userProfile?.country ?? 'N/A';

            // Print the update profile response
            print('Update Profile Response: $updatedUserData');
          });
        } else {
          print('Profile update failed: ${updatedUserData['message']}');
        }
      } else {
        print('Profile update failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
            const SizedBox(
              height: 20,
            ),
            InputField(
              title: 'Name',
              icon: Icons.person,
              controller: _nameController,
            ),
            InputField(
              title: 'Email',
              icon: Icons.mail,
              controller: _emailController,
            ),
            InputField(
              title: 'Contact',
              icon: Icons.call,
              controller: _mobileController,
            ),
            InputField(
              title: 'Date Of Birth',
              icon: Icons.calendar_month,
              controller: _dobController, // Verify this line
            ),

            GestureDetector(
              onTap: () {
                showGenderPopup();
              },
              child: AbsorbPointer(
                child: InputField(
                  title: 'Gender',
                  icon: Icons.male,
                  controller: _genderController,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showCountryPopup();
              },
              child: AbsorbPointer(
                child: InputField(
                  title: 'Country',
                  icon: Icons.flag,
                  controller: _countryController,
                ),
              ),
            ),
            InputField(
              title: 'State',
              icon: Icons.map,
              controller: _stateController,
            ),
            InputField(
              title: 'City',
              icon: Icons.maps_home_work,
              controller: _cityController,
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () async {
                    await updateUserProfile();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile updated successfully'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class GenderPopup extends StatelessWidget {
  final String? selectedGender;

  GenderPopup({required this.selectedGender});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AlertDialog(
        title: Text("Select Gender"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text("Male"),
              value: "Male",
              groupValue: selectedGender,
              onChanged: (value) {
                Navigator.pop(context, value);
              },
            ),
            RadioListTile(
              title: Text("Female"),
              value: "Female",
              groupValue: selectedGender,
              onChanged: (value) {
                Navigator.pop(context, value);
              },
            ),
            RadioListTile(
              title: Text("Other"),
              value: "Other",
              groupValue: selectedGender,
              onChanged: (value) {
                Navigator.pop(context, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CountryPopup extends StatelessWidget {
  final String? selectedCountry;
  final List<Map<String, dynamic>> countries;
  final Map<String, IconData> flagIcons;

  CountryPopup({
    required this.selectedCountry,
    required this.countries,
    required this.flagIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: AlertDialog(
        title: Text("Select Country"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: countries.map((country) {
            return ListTile(
              leading: Icon(flagIcons[country['name']]!),
              title: Text(country['name']),
              onTap: () {
                Navigator.pop(context, country);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
















