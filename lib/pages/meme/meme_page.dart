import 'package:flutter/material.dart';
import 'package:memenote/api/meme_service.dart';
import 'package:memenote/pages/main_layout.dart';

class MemePage extends StatefulWidget {
  const MemePage({super.key});

  @override
  State<MemePage> createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  bool _loading = true;
  List<dynamic> _memes = [];

  @override
  void initState() {
    super.initState();
    _fetchMemes();
  }

  void _fetchMemes() async {
    setState(() => _loading = true);

    final response = await MemeService.getAllMemes();

    if (response is String) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response)));
    } else if (response is Map<String, dynamic> &&
        response.containsKey('memes')) {
      setState(() {
        _memes = response['memes'];
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load memes')));
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;

    return MainLayout(
      child: Container(
        width: deviceWidth,
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Memes",
                  style: TextStyle(
                    color: Colors.blueAccent.shade400,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-meme');
                  },
                  child: Text(
                    "Create Meme",
                    style: TextStyle(
                      color: Colors.blueAccent.shade400,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            _loading
                ? const Center(child: CircularProgressIndicator())
                : _memes.isEmpty
                ? const Center(child: Text("No memes found"))
                : Expanded(
                  // Wrap the ListView inside Expanded
                  child: ListView.builder(
                    itemCount: _memes.length,
                    itemBuilder: (context, index) {
                      final meme = _memes[index];
                      final imageList = meme['image'] as List<dynamic>?;
                      final imageUrl =
                          imageList != null && imageList.isNotEmpty
                              ? 'http://10.0.2.2:8000/${imageList.first}'
                              : 'http://10.0.2.2:8000/Images/Memes/default-meme-image.png';

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                meme['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(meme['description'] ?? ''),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                children:
                                    (meme['tags'] as String)
                                        .split(',')
                                        .map(
                                          (tag) => Chip(
                                            label: Text(tag.trim()),
                                            backgroundColor: Colors.grey[200],
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
