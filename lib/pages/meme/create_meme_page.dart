import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memenote/api/meme_service.dart';
import 'package:memenote/pages/main_layout.dart';
import 'package:memenote/widgets/custom_dropdown.dart';

class CreateMemePage extends StatefulWidget {
  const CreateMemePage({super.key});

  @override
  State<CreateMemePage> createState() => _CreateMemePageState();
}

class _CreateMemePageState extends State<CreateMemePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  final _userIdController = TextEditingController();
  final _statusController = TextEditingController();
  XFile? _selectedImage;

  bool _loading = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  void _createMeme() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final result = await MemeService.createMeme(
        _titleController.text,
        _descriptionController.text,
        _statusController.text,
        _userIdController.text,
        _tagsController.text,
        _categoryController.text,
        _selectedImage,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result), behavior: SnackBarBehavior.floating),
      );

      setState(() => _loading = false);
      // Navigator.pushNamed(context, '/memes');
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<String> activeStatuses = ["Active", "Inactive"];
    return MainLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Create Meme",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Title required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                  isDense: true, // reduces overall height
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                child: CustomDropdown(
                  values: activeStatuses,
                  color: Colors.grey.shade900,
                  bgColor: Colors.grey,
                  textStyle: TextStyle(color:Colors.grey.shade800, fontSize: 17),
                  onSelected: (value) {
                    _statusController.text = value;
                  },
                ),
              ),

              const SizedBox(height: 10),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: "Category ID",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: "Tags",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _userIdController,
                decoration: const InputDecoration(
                  labelText: "User ID",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text("Pick Image"),
              ),
              const SizedBox(height: 10),
              _selectedImage != null
                  ? Image.file(File(_selectedImage!.path), height: 100)
                  : const Text("No image selected"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _createMeme,
                child:
                    _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Submit Meme"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
