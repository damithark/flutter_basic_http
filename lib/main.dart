import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData;
  var userList = [];

  Future getData() async {
    final url = Uri.parse('https://reqres.in/api/users?page=2');
    final response = await get(url);
    userData = jsonDecode(response.body);
    setState(() {
      userList = userData['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Community',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userList[index]['avatar']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userList[index]['first_name']}' +
                              ' ' +
                              '${userList[index]['last_name']}',
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                        Text('${userList[index]['email']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 