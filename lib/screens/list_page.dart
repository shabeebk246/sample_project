import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_project/commons/color_constants.dart';

import '../main.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List datas = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    if (response.statusCode == 200) {
      setState(() {
        datas = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception("failed to load ");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.Background,
      appBar: AppBar(
        title: Text(
          "Photos List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemBuilder: (context, index) {
                final data = datas[index];
                print(datas[0]['thumbnailUrl']);

                return Card(
                  elevation: 4,
                  margin: EdgeInsetsGeometry.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(width * 0.03),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  width * 0.02,
                                ),
                                child: Image.network(
                                  data['thumbnailUrl'],
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    data['title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.035,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    children: [
                                      Chip(
                                        label: Text(
                                          "Album: ${data['albumId']}",
                                        ),
                                        backgroundColor: Colors.blue.shade50,
                                      ),
                                      SizedBox(width: width * 0.03),
                                      Chip(
                                        label: Text('ID: ${data['id']}'),
                                        backgroundColor: Colors.green.shade50,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            data['url'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: height * 0.01);
              },
              itemCount: 20,
            ),
    );
  }
}
