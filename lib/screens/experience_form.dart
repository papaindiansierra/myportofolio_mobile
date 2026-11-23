import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _role = "";
  String _organization = "";
  String _experienceType = "Internship";
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;
  String _description = "";
  String _proofUrl = "";

  String? _startDateError;
  String? _endDateError;

  final List<String> _experienceTypes = [
    'Internship',
    'Organization',
    'Volunteer',
    'Freelance',
    'Full-time',
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return "Pilih tanggal";
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return "$day/$month/$year";
  }

  Future<void> _pickStartDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _startDate ?? now;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(DateTime(now.year + 5)) ? now : initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
        _startDateError = null;
        if (!_isCurrent && _endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDateError = "Tanggal selesai tidak boleh lebih awal dari tanggal mulai!";
        } else {
          _endDateError = null;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = _endDate ?? _startDate ?? now;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(DateTime(now.year + 5)) ? now : initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
        if (_startDate != null && _endDate!.isBefore(_startDate!)) {
          _endDateError = "Tanggal selesai tidak boleh lebih awal dari tanggal mulai!";
        } else {
          _endDateError = null;
        }
      });
    }
  }

  bool _validateDates() {
    bool valid = true;
    setState(() {
      if (_startDate == null) {
        _startDateError = "Tanggal mulai wajib dipilih!";
        valid = false;
      } else {
        _startDateError = null;
      }

      if (!_isCurrent) {
        if (_endDate == null) {
          _endDateError = "Tanggal selesai wajib dipilih jika belum berlangsung!";
          valid = false;
        } else if (_startDate != null && _endDate!.isBefore(_startDate!)) {
          _endDateError = "Tanggal selesai tidak boleh lebih awal dari tanggal mulai!";
          valid = false;
        } else {
          _endDateError = null;
        }
      } else {
        _endDateError = null;
      }
    });
    return valid;
  }

  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final String trimmed = value.trim();
    final Uri? uri = Uri.tryParse(trimmed);
    final bool hasValidScheme =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    final bool hasValidHost = uri != null && uri.host.contains('.');
    if (!hasValidScheme || !hasValidHost) {
      return "Masukkan URL yang valid (diawali http:// atau https://).";
    }
    return null;
  }

  void _handleSave() {
    final bool isFormValid = _formKey.currentState!.validate();
    final bool isDateValid = _validateDates();

    if (!isFormValid || !isDateValid) {
      return;
    }

    final String periodText = _isCurrent
        ? "${_formatDate(_startDate)} - Sekarang"
        : "${_formatDate(_startDate)} - ${_formatDate(_endDate)}";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pengalaman berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Posisi / Peran: ${_role.trim()}'),
                const SizedBox(height: 4),
                Text('Organisasi / Instansi: ${_organization.trim()}'),
                const SizedBox(height: 4),
                Text('Tipe Pengalaman: $_experienceType'),
                const SizedBox(height: 4),
                Text('Periode: $periodText'),
                const SizedBox(height: 4),
                Text(
                  'Deskripsi: ${_description.trim().isEmpty ? "-" : _description.trim()}',
                ),
                const SizedBox(height: 4),
                Text(
                  'Tautan Bukti: ${_proofUrl.trim().isEmpty ? "-" : _proofUrl.trim()}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
                setState(() {
                  _role = "";
                  _organization = "";
                  _experienceType = "Internship";
                  _startDate = null;
                  _endDate = null;
                  _isCurrent = false;
                  _description = "";
                  _proofUrl = "";
                  _startDateError = null;
                  _endDateError = null;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: "Contoh: Software Engineering Intern",
                    labelText: "Posisi / Peran *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _role = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    final String trimmed = value?.trim() ?? "";
                    if (trimmed.isEmpty) {
                      return "Posisi tidak boleh kosong!";
                    }
                    if (trimmed.length < 3) {
                      return "Posisi minimal 3 karakter.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),

                TextFormField(
                  maxLength: 120,
                  decoration: InputDecoration(
                    hintText: "Contoh: PT Teknologi Nusantara",
                    labelText: "Organisasi / Perusahaan *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _organization = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    final String trimmed = value?.trim() ?? "";
                    if (trimmed.isEmpty) {
                      return "Organisasi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),

                DropdownButtonFormField<String>(
                  initialValue: _experienceType,
                  decoration: InputDecoration(
                    labelText: "Tipe Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: _experienceTypes
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _experienceType = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 12.0),

                OutlinedButton.icon(
                  onPressed: _pickStartDate,
                  icon: const Icon(Icons.calendar_today),
                  label: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Tanggal Mulai *: ${_formatDate(_startDate)}"),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 14.0,
                    ),
                  ),
                ),
                if (_startDateError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                    child: Text(
                      _startDateError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                const SizedBox(height: 8.0),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Masih berlangsung hingga sekarang"),
                  value: _isCurrent,
                  onChanged: (bool value) {
                    setState(() {
                      _isCurrent = value;
                      if (_isCurrent) {
                        _endDate = null;
                        _endDateError = null;
                      }
                    });
                  },
                ),

                if (!_isCurrent) ...[
                  const SizedBox(height: 4.0),
                  OutlinedButton.icon(
                    onPressed: _pickEndDate,
                    icon: const Icon(Icons.event_available),
                    label: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Tanggal Selesai *: ${_formatDate(_endDate)}"),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 14.0,
                      ),
                    ),
                  ),
                  if (_endDateError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                      child: Text(
                        _endDateError!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: 12.0),

                TextFormField(
                  maxLines: 4,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: "Ringkasan tanggung jawab atau pencapaian",
                    labelText: "Deskripsi Pengalaman",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? "";
                    });
                  },
                ),
                const SizedBox(height: 12.0),

                TextFormField(
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: "https://...",
                    labelText: "Tautan Bukti / Portofolio (opsional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _proofUrl = value ?? "";
                    });
                  },
                  validator: _validateUrl,
                ),
                const SizedBox(height: 20.0),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  onPressed: _handleSave,
                  child: const Text(
                    "Simpan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}