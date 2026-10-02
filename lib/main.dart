import 'package:flutter/material.dart';

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileFormPage(),
    );
  }
}

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();

  String? _submittedName;
  String? _submittedAge;
  String? _submittedGender;
  String? _submittedAddress;
  String? _submittedContact;
  String? _submittedEmail;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedName = _nameController.text;
        _submittedAge = _ageController.text;
        _submittedGender = _genderController.text;
        _submittedAddress = _addressController.text;
        _submittedContact = _contactController.text;
        _submittedEmail = _emailController.text;
      });
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _ageController.clear();
    _genderController.clear();
    _addressController.clear();
    _contactController.clear();
    _emailController.clear();
    setState(() {
      _submittedName = null;
      _submittedAge = null;
      _submittedGender = null;
      _submittedAddress = null;
      _submittedContact = null;
      _submittedEmail = null;
    });
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Information Form')),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) => _requiredValidator(value, 'Full Name'),
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) => _requiredValidator(value, 'Age'),
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) => _requiredValidator(value, 'Gender'),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) => _requiredValidator(value, 'Address'),
                ),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => _requiredValidator(value, 'Contact Number'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Submit'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _resetForm,
                        child: const Text('Clear / Reset'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_submittedName != null) ...[
            const SizedBox(height: 20),
            const Text('Submitted Information:'),
            Text('Full Name: $_submittedName'),
            Text('Age: $_submittedAge'),
            Text('Gender: $_submittedGender'),
            Text('Address: $_submittedAddress'),
            Text('Contact Number: $_submittedContact'),
            Text('Email: $_submittedEmail'),
          ],
        ],
      ),
    );
  }
}
