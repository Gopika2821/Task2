import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<FormData>(
        create: (BuildContext context) => FormData(),
        builder: (BuildContext context, Widget? child) {
          return const MultiStepRegistrationForm();
        },
      ),
    );
  }
}

/// A data model for the registration form, managing all form fields and state.
class FormData extends ChangeNotifier {
  // Text Controllers for text input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController batchController = TextEditingController();

  // Selected values for dropdowns and radio buttons
  String? _selectedDegree;
  String? _selectedYear;
  String? _selectedDepartment;
  String? _selectedGender;

  // File paths (simulated as Strings for demonstration)
  String? _profileFile;
  String? _idFile;
  String? _resumeFile;
  String? _aadhaarFile;

  // Data sources for dropdowns and radio buttons
  static const List<String> _degrees = ["B.E", "B.Tech", "MCA"];
  static const List<String> _yearsOfPassout = ["2022", "2023", "2024"];
  static const List<String> _departments = ["CSE", "ECE", "EEE"];
  static const List<String> _genders = ["Male", "Female"];

  // Getters for accessing form data
  String? get selectedDegree => _selectedDegree;
  String? get selectedYear => _selectedYear;
  String? get selectedDepartment => _selectedDepartment;
  String? get selectedGender => _selectedGender;
  String? get profileFile => _profileFile;
  String? get idFile => _idFile;
  String? get resumeFile => _resumeFile;
  String? get aadhaarFile => _aadhaarFile;

  List<String> get degrees => _degrees;
  List<String> get yearsOfPassout => _yearsOfPassout;
  List<String> get departments => _departments;
  List<String> get genders => _genders;

  // Setters for updating form data and notifying listeners
  set selectedDegree(String? value) {
    if (_selectedDegree != value) {
      _selectedDegree = value;
      notifyListeners();
    }
  }

  set selectedYear(String? value) {
    if (_selectedYear != value) {
      _selectedYear = value;
      notifyListeners();
    }
  }

  set selectedDepartment(String? value) {
    if (_selectedDepartment != value) {
      _selectedDepartment = value;
      notifyListeners();
    }
  }

  set selectedGender(String? value) {
    if (_selectedGender != value) {
      _selectedGender = value;
      notifyListeners();
    }
  }

  void setProfileFile(String filename) {
    if (_profileFile != filename) {
      _profileFile = filename;
      notifyListeners();
    }
  }

  void setIdFile(String filename) {
    if (_idFile != filename) {
      _idFile = filename;
      notifyListeners();
    }
  }

  void setResumeFile(String filename) {
    if (_resumeFile != filename) {
      _resumeFile = filename;
      notifyListeners();
    }
  }

  void setAadhaarFile(String filename) {
    if (_aadhaarFile != filename) {
      _aadhaarFile = filename;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    collegeController.dispose();
    contactController.dispose();
    regNoController.dispose();
    batchController.dispose();
    super.dispose();
  }
}

class MultiStepRegistrationForm extends StatefulWidget {
  const MultiStepRegistrationForm({super.key});

  @override
  State<MultiStepRegistrationForm> createState() =>
      _MultiStepRegistrationFormState();
}

class _MultiStepRegistrationFormState extends State<MultiStepRegistrationForm> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  final GlobalKey<FormState> _formKeyPage1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPage3 = GlobalKey<FormState>();

  // Dummy file picker logic (for DartPad/demonstration)
  void _pickFile(Function(String) onPicked) {
    // In a real application, this would open a file picker dialog.
    // For this example, we simply simulate a file being selected.
    onPicked("file_selected_${DateTime.now().millisecondsSinceEpoch}.pdf");
  }

  void _nextPage() {
    bool? isValid = false;
    switch (_currentStep) {
      case 0:
        isValid = _formKeyPage1.currentState?.validate();
        break;
      case 1:
        isValid = _formKeyPage2.currentState?.validate();
        break;
      case 2:
        isValid = _formKeyPage3.currentState?.validate();
        break;
    }

    if (isValid == true && _currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _prevPage() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _submitForm() {
    final bool? isValid = _formKeyPage3.currentState?.validate();
    if (isValid == true) {
      // Access the form data from the provider
      final FormData formData = Provider.of<FormData>(context, listen: false);

      showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text("Registration Successful"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Name: ${formData.nameController.text}"),
                  Text("Email: ${formData.emailController.text}"),
                  Text("Degree: ${formData.selectedDegree ?? 'N/A'}"),
                  Text("Passout Year: ${formData.selectedYear ?? 'N/A'}"),
                  Text("College: ${formData.collegeController.text}"),
                  Text("Contact: ${formData.contactController.text}"),
                  Text("Department: ${formData.selectedDepartment ?? 'N/A'}"),
                  Text("Gender: ${formData.selectedGender ?? 'N/A'}"),
                  Text("Batch: ${formData.batchController.text}"),
                  Text("Register Number: ${formData.regNoController.text}"),
                  Text("Profile File: ${formData.profileFile ?? 'N/A'}"),
                  Text("ID Image File: ${formData.idFile ?? 'N/A'}"),
                  Text("Resume File: ${formData.resumeFile ?? 'N/A'}"),
                  Text("Aadhaar File: ${formData.aadhaarFile ?? 'N/A'}"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration Form"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            children: <Widget>[
              _PersonalDetailsPage(
                formKey: _formKeyPage1,
                onNext: _nextPage,
              ),
              _AcademicAndIDPage(
                formKey: _formKeyPage2,
                onNext: _nextPage,
                onPrevious: _prevPage,
                pickFile: _pickFile,
              ),
              _DocumentUploadPage(
                formKey: _formKeyPage3,
                onPrevious: _prevPage,
                onSubmit: _submitForm,
                pickFile: _pickFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A generic text form field widget.
class _CustomTextFormField extends StatelessWidget {
  const _CustomTextFormField({
    required this.labelText,
    required this.controller,
    this.keyboardType,
    this.validator,
    super.key,
  });

  final String labelText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        validator: validator,
      ),
    );
  }
}

/// A generic dropdown form field widget.
class _CustomDropdownFormField<T> extends StatelessWidget {
  const _CustomDropdownFormField({
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    super.key,
  });

  final String labelText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: items.map<DropdownMenuItem<T>>((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

/// A widget for displaying a file upload prompt and button.
class _FileUploadBox extends StatelessWidget {
  const _FileUploadBox({
    required this.title,
    required this.fileName,
    required this.onUploadPressed,
    super.key,
  });

  final String title;
  final String? fileName;
  final VoidCallback onUploadPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: onUploadPressed,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  fileName ?? "No file chosen",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A widget for selecting gender using radio buttons.
class _GenderRadioButtons extends StatelessWidget {
  const _GenderRadioButtons({
    required this.selectedGender,
    required this.onChanged,
    required this.genderOptions,
    required this.validator,
    super.key,
  });

  final String? selectedGender;
  final ValueChanged<String?> onChanged;
  final List<String> genderOptions;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Gender:", style: Theme.of(context).textTheme.titleSmall),
            ),
            Row(
              children: genderOptions.map<Widget>((String gender) {
                return Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Radio<String>(
                        value: gender,
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          onChanged(value);
                          state.didChange(value);
                        },
                      ),
                      Flexible(child: Text(gender)),
                    ],
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// The first page of the multi-step registration form.
class _PersonalDetailsPage extends StatelessWidget {
  const _PersonalDetailsPage({
    required this.formKey,
    required this.onNext,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final FormData formData = Provider.of<FormData>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _CustomTextFormField(
              labelText: "Candidate Name",
              controller: formData.nameController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
            _CustomTextFormField(
              labelText: "Email",
              controller: formData.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),
            _CustomDropdownFormField<String>(
              labelText: "Degree",
              items: formData.degrees,
              value: formData.selectedDegree,
              onChanged: (String? v) => formData.selectedDegree = v,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select a degree";
                }
                return null;
              },
            ),
            _CustomDropdownFormField<String>(
              labelText: "Year of Passout",
              items: formData.yearsOfPassout,
              value: formData.selectedYear,
              onChanged: (String? v) => formData.selectedYear = v,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select a year";
                }
                return null;
              },
            ),
            _CustomTextFormField(
              labelText: "College",
              controller: formData.collegeController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your college name";
                }
                return null;
              },
            ),
            _CustomTextFormField(
              labelText: "Contact",
              controller: formData.contactController,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your contact number";
                }
                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return "Please enter a 10-digit number";
                }
                return null;
              },
            ),
            _CustomDropdownFormField<String>(
              labelText: "Department",
              items: formData.departments,
              value: formData.selectedDepartment,
              onChanged: (String? v) => formData.selectedDepartment = v,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select a department";
                }
                return null;
              },
            ),
            _GenderRadioButtons(
              selectedGender: formData.selectedGender,
              onChanged: (String? v) => formData.selectedGender = v,
              genderOptions: formData.genders,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select your gender";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}

/// The second page of the multi-step registration form.
class _AcademicAndIDPage extends StatelessWidget {
  const _AcademicAndIDPage({
    required this.formKey,
    required this.onNext,
    required this.onPrevious,
    required this.pickFile,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Function(Function(String)) pickFile;

  @override
  Widget build(BuildContext context) {
    final FormData formData = Provider.of<FormData>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _CustomTextFormField(
              labelText: "Batch",
              controller: formData.batchController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your batch";
                }
                return null;
              },
            ),
            _CustomTextFormField(
              labelText: "Register Number",
              controller: formData.regNoController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your register number";
                }
                return null;
              },
            ),
            _FileUploadBox(
              title: "Upload Profile Image",
              fileName: formData.profileFile,
              onUploadPressed: () => pickFile((String f) => formData.setProfileFile(f)),
            ),
            _FileUploadBox(
              title: "Upload ID Image",
              fileName: formData.idFile,
              onUploadPressed: () => pickFile((String f) => formData.setIdFile(f)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrevious,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Previous"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Next"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The third and final page of the multi-step registration form.
class _DocumentUploadPage extends StatelessWidget {
  const _DocumentUploadPage({
    required this.formKey,
    required this.onPrevious,
    required this.onSubmit,
    required this.pickFile,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  final Function(Function(String)) pickFile;

  @override
  Widget build(BuildContext context) {
    final FormData formData = Provider.of<FormData>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _FileUploadBox(
              title: "Upload Resume",
              fileName: formData.resumeFile,
              onUploadPressed: () => pickFile((String f) => formData.setResumeFile(f)),
            ),
            _FileUploadBox(
              title: "Upload Aadhaar Card",
              fileName: formData.aadhaarFile,
              onUploadPressed: () => pickFile((String f) => formData.setAadhaarFile(f)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrevious,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Previous"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
