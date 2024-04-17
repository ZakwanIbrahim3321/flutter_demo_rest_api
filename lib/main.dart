import 'dart:convert';

import 'package:demo_rest_api_flutter/core/model/api_model/posts_model.dart';
import 'package:demo_rest_api_flutter/core/services/post_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo REST api',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<PostsModel> posts = [];

  Future<void> callApi() async {
    setState(() {
      posts.clear;
      isLoading = true;
    });
    await PostService().postsApiResponse().then((value) {
      setState(() {
        isLoading = false;
      });
      final List<dynamic> jsonResponse = json.decode(value.body.toString());
      setState(() {
        posts = jsonResponse.map((item) => PostsModel.fromJson(item)).toList();
      });

      debugPrint(posts.toString());
    }).catchError((e, stackTrace) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            InkWell(
              onTap: () {
                callApi();
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    'Call API',
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: posts.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 10, top: index == 0? 10 : 0),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 3,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: ListTile(
                        title: Text(posts[index].title),
                        subtitle: Text(posts[index].body),
                      ),
                    ),
                  );
                }));
  }
}
