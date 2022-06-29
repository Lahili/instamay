import 'package:flutter/material.dart';
import 'package:instamay/moyang.dart' as style;
import 'package:instamay/home.dart';
import 'package:instamay/shop.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:instamay/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:instamay/StateStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: style.theme,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int tab = 0;
  var data = [];
  var userImage;
  var userContent;

  saveData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('int', 10);

    var map = {'key': 'value'};
    await prefs.setString('test', jsonEncode(map));
    var read = prefs.getString('test') ?? 'null';
    print(jsonDecode(read));
    var read2 = prefs.getInt('int');
    print(read);
    print(read2);
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  addMyData() {
    var myData = {
      'id': data.length,
      'image': userImage,
      'likes': 0,
      'date': '',
      'content': userContent,
      'liked': false,
      'user': 'Anne Joey'
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  addData(a) {
    setState(() {
      data.add(a);
    });
  }

  getData() async {
    var url = Uri.parse('https://codingapple1.github.io/app/data.json');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      //print(decodedResponse);
      setState(() {
        data = decodedResponse;
      });
    } else {
      throw Exception('400');
    }
  }

  getAnotherData(a) async {
    var response2 = await http.get(Uri.parse(a));
    if (response2.statusCode == 200) {
      var decodedResponse2 = jsonDecode(response2.body);
      addData(decodedResponse2);
    } else {
      throw Exception('400');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(
            onPressed: () async {
              print('IconButton got pressed');
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              var image = await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Upload(
                      userImage: userImage,
                      setUserContent: setUserContent,
                      addMyData: addMyData);
                }),
              );
            },
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: [
        Home(data: data, addData: addData, getAnotherData: getAnotherData),
        Shop()
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          print('i = $i');
          setState(() {
            tab = i;
          });
        },
        currentIndex: tab,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: 'shopping')
        ],
      ),
    );
  }
}
