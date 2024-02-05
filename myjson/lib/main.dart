import 'package:http/http.dart' as http;
import 'package:myjson/network_manager.dart';
import 'album.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> album;
  @override
  void initState() {
    super.initState();
    album = NetworkManager().fetchAlbum();
  }

  Widget build(BuildContext context) {
    return MaterialApp(home: MyPost());
  }
}

class MyGet extends StatelessWidget {
  const MyGet({
    super.key,
    required this.album,
  });

  final Future<Album> album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: FutureBuilder(
        future: album,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data!.title ?? ''));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  late Future<Album> album;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    album = NetworkManager().fetchAlbum();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Post"),
          actions: const [],
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter Title'),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    album = NetworkManager().createAlbum(_controller.text);
                  });
                },
                child: const Text('Create Data'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      album = NetworkManager().updateAlbum(1, _controller.text);
                    });
                  },
                  child: const Text('Update Data')),
              const SizedBox(
                width: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    album = NetworkManager().deleteAlbum(1);
                  });
                },
                child: const Text('Delete Data'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FutureBuilder(
              future: album,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(child: Text(snapshot.data?.title ?? 'deleted'));
                } else if (snapshot.hasError) {
                  return Text('cek ${snapshot.error}');
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ]));
  }
}
