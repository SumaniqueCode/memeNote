import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class MemeService {
static Future<String> createMeme(
  String title,
  String description,
  String status,
  String userId,
  String tags,
  String categoryId,
  XFile? imageFile,
) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/create-meme');
  try {
    final request = http.MultipartRequest('POST', url);

    // Text fields
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['status'] = status;
    request.fields['user_id'] = userId;
    request.fields['tags'] = tags;
    request.fields['category_id'] = categoryId;

    // Image file if exists
    if (imageFile != null) {
      final mimeType = lookupMimeType(imageFile.path);
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path, contentType: MediaType.parse(mimeType!)),
      );
    }

    // Send request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return 'Meme created successfully!';
    } else {
      return data['error'] ?? 'Failed to create meme';
    }
  } catch (e) {
    return 'Error: $e';
  }
}

static Future<String> editMeme(
  String id,
  String title,
  String description,
  String status,
  String userId,
  String tags,
  String categoryId,
  XFile? imageFile,
) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/create-meme');
  try {
    final request = http.MultipartRequest('POST', url);

    // Text fields
    request.fields['id']= id;
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['status'] = status;
    request.fields['user_id'] = userId;
    request.fields['tags'] = tags;
    request.fields['category_id'] = categoryId;

    // Image file if exists
    if (imageFile != null) {
      final mimeType = lookupMimeType(imageFile.path);
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path, contentType: MediaType.parse(mimeType!)),
      );
    }

    // Send request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return 'Meme Edited successfully!';
    } else {
      return data['error'] ?? 'Failed to create meme';
    }
  } catch (e) {
    return 'Error: $e';
  }
}


  static Future<dynamic> getAllMemes() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/get-all-memes');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Error fetching memes';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
