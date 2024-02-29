import 'package:decoar/localization/app_localizations.dart';
import 'package:decoar/localization/localization_provider.dart';
import 'package:decoar/theme/app_theme.dart';
import 'package:decoar/widgets/input_decoration_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  int _selectedOptionId = 1;
  final Map<String, int> _optionIds = {
    'Request Pricing': 1,
    'New Project': 2,
    'New Meeting': 3,
  };
  final Map<int, String> _options = {
    1: 'طلب السعر',
    2: 'مشروع جديد',
    3: 'اجتماع جديد',
  };
  final Map<int, List<PlatformFile>> _selectedFiles = {
    1: [],
    2: [],
    3: [],
  };
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final languageProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          localizations!.translate('createorder'),
          style: TextStyle(
              fontSize: 18,
              color: whiteColor,
              fontFamily: languageProvider.locale.languageCode == 'en'
                  ? 'Tajawal'
                  : 'Cairo'),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: whiteColor, size: 18),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localizations.translate('selectrequest'),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      _options.keys.map((id) => _optionContainer(id)).toList(),
                ),
                const SizedBox(height: 20),
                _customForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionContainer(int id) {
    bool isSelected = _selectedOptionId == id;
    String optionText = _options[id] ?? '';

    return Expanded(
        child: GestureDetector(
      onTap: () => setState(() => _selectedOptionId = id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: whitegreyColor,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          optionText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? whiteColor : blackColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }

  Widget _customForm() {
    switch (_selectedOptionId) {
      case 1:
        return _requestPricingForm();
      case 2:
        return _newProjectForm();
      case 3:
        return _newMeetingForm();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _formField(
      {required String label,
      TextInputType? keyboardType,
      int? maxLines,
      List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: inputDecoration(
          hintText: label,
        ),
        maxLines: maxLines ?? 1,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _submitButton(String buttonText) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _pickFiles(int optionId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _selectedFiles[optionId] = result.files;
      });
    }
  }

  Widget _fileUploadButton(int option) {
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _pickFiles(option);
              if (_formKey.currentState!.validate()) {}
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: greenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
            ),
            child: Text(
              localizations!.translate('uploadfiles'),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ..._selectedFiles[option]!.map((file) => Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Text(
                file.name,
                style: const TextStyle(fontSize: 16, color: blackColor),
              ),
            )),
      ],
    );
  }

  Widget _requestPricingForm() {
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        _formField(label: localizations!.translate('nameproject')),
        _formField(
            label: localizations.translate('desc'),
            keyboardType: TextInputType.multiline,
            maxLines: 3),
        _formField(label: localizations.translate('time')),
        _formField(
            label: localizations.translate('price'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
        _formField(
            label: localizations.translate('quantity'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
        _fileUploadButton(1),
        _submitButton(localizations.translate('send')),
      ],
    );
  }

  Widget _newProjectForm() {
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        _formField(label: localizations!.translate('nameproject')),
        _formField(
            label: localizations.translate('desc'),
            keyboardType: TextInputType.multiline,
            maxLines: 3),
        _formField(
            label: localizations.translate('quantity'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
        _fileUploadButton(2),
        _submitButton(localizations.translate('send')),
      ],
    );
  }

  Widget _newMeetingForm() {
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        _formField(label: localizations!.translate('titlemeeting')),
        _formField(
            label: localizations.translate('descmeeting'),
            keyboardType: TextInputType.multiline,
            maxLines: 3),
        _formField(
            label: localizations.translate('email'),
            keyboardType: TextInputType.emailAddress),
        _formField(
            label: localizations.translate('mobile'),
            keyboardType: TextInputType.phone),
        _fileUploadButton(3),
        _submitButton(localizations.translate('send')),
      ],
    );
  }
}
