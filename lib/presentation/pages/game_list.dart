import 'package:flutter/material.dart';

class GameListPage extends StatelessWidget {
  const GameListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Game List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: Text('Create Game'))
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.blue,
                        child: const Center(child: Text('Game 1', style: TextStyle(color: Colors.white, fontSize: 24))),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.green,
                        child: const Center(child: Text('Game 2', style: TextStyle(color: Colors.white, fontSize: 24))),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.red,
                        child: const Center(child: Text('Game 3', style: TextStyle(color: Colors.white, fontSize: 24))),
                      ),
                    ],
                  )
                ,
            ),
          ],
        ),
      ),
    );
  }
}