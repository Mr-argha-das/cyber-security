import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchoolRegisterPage extends StatefulWidget {
  const SchoolRegisterPage({super.key});

  @override
  State<SchoolRegisterPage> createState() => _SchoolRegisterPageState();
}

class _SchoolRegisterPageState extends State<SchoolRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _schoolNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _principalNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _numberOfStudentsController = TextEditingController();

  Uint8List? _pickedImage;
  String? _fileName;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _pickedImage = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left Side: Form
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 60,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register School 🏫",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "Fill the details below to register your school.",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 30),

                          // School Name
                          buildField(
                            "School Name *",
                            _schoolNameController,
                            required: true,
                          ),

                          // Email & Phone Row
                          Row(
                            children: [
                              Expanded(
                                child: buildField(
                                  "Email *",
                                  _emailController,
                                  inputType: TextInputType.emailAddress,
                                  required: true,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: buildField(
                                  "Phone *",
                                  _phoneController,
                                  inputType: TextInputType.phone,
                                  required: true,
                                ),
                              ),
                            ],
                          ),

                          buildField(
                            "Principal Name *",
                            _principalNameController,
                            required: true,
                          ),
                          buildField("Address", _addressController),
                          buildField("City", _cityController),
                          buildField("State", _stateController),
                          buildField("Country", _countryController),
                          buildField("Pincode", _pincodeController),
                          buildField(
                            "Number of Students",
                            _numberOfStudentsController,
                            inputType: TextInputType.number,
                          ),

                          // Image Upload
                          SizedBox(height: 20),
                          Text(
                            "Upload School Image *",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: Icon(Icons.upload_file),
                            label: Text(_fileName ?? 'Choose File'),
                          ),
                          if (_pickedImage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Image.memory(_pickedImage!, height: 100),
                            ),

                          SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    _pickedImage != null) {
                                  // Submit logic here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Submitted Successfully!"),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please fill all required fields & upload image",
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Register School",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Right Side: Art / Banner
              if (constraints.maxWidth > 900)
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: NetworkImage("assets/images/LoginArt.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    TextInputType inputType = TextInputType.text,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        validator: required
            ? (value) =>
                (value == null || value.isEmpty) ? '$label is required' : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
