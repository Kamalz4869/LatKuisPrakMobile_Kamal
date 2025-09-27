import 'package:flutter/material.dart';
import 'package:olah_data/data/game_store_data.dart';
import 'package:olah_data/screen/login_page.dart';
import 'package:olah_data/screen/detail_game.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Selamat Datang $username", style: TextStyle(fontSize: 25)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1, // supaya muat gambar+teks
                  ),
                  itemBuilder: (context, index) {
                    return _gameStore(context, index);
                  },
                  itemCount: gameList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
      (route) => false,
    );
  }
}

Widget _gameStore(BuildContext context, int index) {
  final game = gameList[index];
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailGamePage(game: game)),
      );
    },
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(child: Image.network(game.imageUrls[0], fit: BoxFit.fill)),
          SizedBox(height: 8),
          Text(
            game.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            game.about,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    ),
  );
}
