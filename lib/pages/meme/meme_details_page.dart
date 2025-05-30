import 'package:flutter/material.dart';
import 'package:memenote/pages/main_layout.dart';

class MemeDetailsPage extends StatelessWidget {
  const MemeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final meme = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final imageList = meme['image'] as List<dynamic>?;
    final imageUrl =
        imageList != null && imageList.isNotEmpty
            ? 'http://10.0.2.2:8000/${imageList.first}'
            : 'http://10.0.2.2:8000/Images/Memes/default-meme-image.png';

    return MainLayout(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 16),
            Text(meme['description'] ?? '', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: (meme['tags'] as String).split(',').map((tag) {
                return Chip(label: Text(tag.trim()));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
