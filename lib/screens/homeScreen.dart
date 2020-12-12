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
                    onPressed: () {
                      setState(() {});
                      gif.fetchGifs(_textController.text);
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
            if (_textController.text.isEmpty)
              Text(
                "Search to get GIFs",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (_textController.text.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.isMobile ? 2 : 3,
                  ),
                  itemBuilder: (contxt, index) =>
                      Image.network(gif.gifs[index].url),
                  itemCount: gif.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
