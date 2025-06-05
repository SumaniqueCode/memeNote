import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memenote/api/meme_service.dart';
import 'package:memenote/pages/main_layout.dart';
import 'package:memenote/widgets/custom_dropdown.dart';

class EditMemePage extends StatefulWidget {
  const EditMemePage({super.key});

  @override
  State<EditMemePage> createState() => _EditMemePageState();
}

class _EditMemePageState extends State<EditMemePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _statusController;
  late TextEditingController _userIdController;
  late TextEditingController _tagsController;
  late TextEditingController _categoryController;

  XFile? _selectedImage;
  bool _loading = false;

  Map<String, dynamic>? meme;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _statusController = TextEditingController();
    _userIdController = TextEditingController();
    _tagsController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (meme == null) {
      meme = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _titleController.text = meme!['title'] ?? '';
      _descriptionController.text = meme!['description'] ?? '';
      _statusController.text = meme!['status'] ?? '';
      _userIdController.text = meme!['user_id'].toString();
      _tagsController.text = meme!['tags'] ?? '';
      _categoryController.text = meme!['category_id'].toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    _userIdController.dispose();
    _tagsController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = picked);
    }
  }

  void _updateMeme() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final result = await MemeService.editMeme(
        meme!['id'],
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
                "Edit Meme",
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
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                child: CustomDropdown(
                  values: activeStatuses,
                  initialValue: _statusController.text,
                  color: Colors.grey.shade900,
                  bgColor: Colors.grey,
                  textStyle:
                      TextStyle(color: Colors.grey.shade800, fontSize: 17),
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
                  : (meme!['image_url'] != null
                      ? Image.network(meme!['image_url'], height: 100)
                      : const Text("No image selected")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _updateMeme,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Update Meme"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
