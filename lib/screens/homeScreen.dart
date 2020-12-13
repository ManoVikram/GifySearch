import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/gifAPI.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final gif = Provider.of<Gify>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Theme(
        data: ThemeData.dark(),
        child: Column(
          children: [
            Text(
              "GET GIFY",
              textAlign: TextAlign.center,
              textScaleFactor: 4,
              style: TextStyle(
                color: Colors.white,
                height: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Search GIF",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      print(_isLoading);
                      await gif.fetchGifs(_textController.text);
                      setState(() {
                        _isLoading = false;
                      });
                      print(_isLoading);
                    },
                    child: Text(
                      "Get It",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 7,
                    color: Colors.cyanAccent,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Builder(
                builder: (contxt) {
                  if (_isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (_textController.text.isEmpty) {
                    return Center(
                      child: Text(
                        "Search to get GIFs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: context.isMobile ? 2 : 3,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (contxt, index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 7,
                        // margin: EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                gif.gifs[index].url,
                                fit: BoxFit.cover,
                                color: Colors.white.withOpacity(0.8),
                                colorBlendMode: BlendMode.darken,
                              ),
                              BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              Image.network(
                                gif.gifs[index].url,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      ),
                      itemCount: gif.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
