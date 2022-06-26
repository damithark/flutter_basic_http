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
  var userList = [];
  bool isButtonVisible = true;

  Future getData() async {
    final url = Uri.parse('https://reqres.in/api/users?page=2');
    final response = await get(url);
    final userData = jsonDecode(response.body);
    setState(() {
      userList = userData['data'];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Elite Panel',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: isButtonVisible
            ? buildInitialView(context)
            : buildUserList(context),
      ),
    );
  }

  Widget buildUserList(BuildContext context) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blue.shade50,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
    );
  }

  Widget buildInitialView(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          isButtonVisible = false;
          Future.delayed(
              const Duration(
                seconds: 2,
              ), () {
            getData();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade400,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            'Get User List',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// 