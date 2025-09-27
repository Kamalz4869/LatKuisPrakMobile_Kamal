// file: lib/screen/detail_game.dart
import 'package:flutter/material.dart';
import 'package:olah_data/screen/game_store_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailGamePage extends StatelessWidget {
  final GameStore game;
  const DetailGamePage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(game.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner utama
            Image.network(
              game.imageUrls[0],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(height: 16),

            Text(
              game.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            Text("Release Date: ${game.releaseDate}"),
            SizedBox(height: 8),

            Text("Price: ${game.price}"),
            SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: game.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            SizedBox(height: 16),

            Text("About", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(game.about),

            SizedBox(height: 16),
            Text(
              "Reviews: ${game.reviewAverage} "
              "(${game.reviewCount} votes)",
            ),

            SizedBox(height: 16),
            Text("More Images", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: game.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(game.imageUrls[index]),
                  );
                },
              ),
            ),

            SizedBox(height: 24),

            // Tombol download sekarang
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () async {
                  final Uri url = Uri.parse(game.linkStore);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Tidak bisa membuka link")),
                    );
                  }
                },
                icon: Icon(Icons.download),
                label: Text("Download Sekarang"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
