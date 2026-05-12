import 'package:flutter/material.dart';

void main() {
  runApp(const JobApplicationApp());
}

class JobApplicationApp extends StatelessWidget {
  const JobApplicationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'İş Başvuru Formu',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const JobApplicationPage(),
    );
  }
}

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({super.key});

  @override
  State<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends State<JobApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  bool isRobotChecked = false;
  bool fileUploaded = false;

  String? selectedGender;
  String? selectedExperience;

  final List<String> genders = [
    "Erkek",
    "Kadın",
    "Belirtmek İstemiyorum"
  ];

  final List<String> experiences = [
    "0-1 Yıl",
    "1-3 Yıl",
    "3-5 Yıl",
    "5+ Yıl"
  ];

  Widget buildTextField({
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$label zorunludur";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.indigo),
          labelText: label,
          filled: true,
          fillColor: Colors.indigo.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required IconData icon,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: DropdownButtonFormField<String>(
        value: value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label seçiniz";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.indigo),
          labelText: label,
          filled: true,
          fillColor: Colors.indigo.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!fileUploaded) {
        showMessage("Lütfen CV dosyası yükleyin.");
        return;
      }

      if (!isRobotChecked) {
        showMessage("Lütfen 'Ben robot değilim' kutusunu işaretleyin.");
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Başvuru Başarılı"),
          content: const Text(
            "İş başvurunuz başarıyla gönderildi.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "İş Başvuru Formu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 8,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  const Icon(
                    Icons.work,
                    size: 90,
                    color: Colors.indigo,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "İş Başvuru Formu",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),

                  const SizedBox(height: 35),

                  buildTextField(
                    label: "Ad",
                    icon: Icons.person,
                  ),

                  buildTextField(
                    label: "Soyad",
                    icon: Icons.person_outline,
                  ),

                  buildTextField(
                    label: "TC Kimlik Numarası",
                    icon: Icons.credit_card,
                  ),

                  buildTextField(
                    label: "Doğum Tarihi",
                    icon: Icons.calendar_month,
                  ),

                  buildTextField(
                    label: "E-posta",
                    icon: Icons.email,
                  ),

                  buildTextField(
                    label: "Telefon",
                    icon: Icons.phone,
                  ),

                  buildDropdown(
                    label: "Cinsiyet",
                    icon: Icons.people,
                    items: genders,
                    value: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),

                  buildTextField(
                    label: "Adres",
                    icon: Icons.home,
                    maxLines: 3,
                  ),

                  buildTextField(
                    label: "Şehir",
                    icon: Icons.location_city,
                  ),

                  buildTextField(
                    label: "Üniversite / Okul",
                    icon: Icons.school,
                  ),

                  buildTextField(
                    label: "Bölüm",
                    icon: Icons.menu_book,
                  ),

                  buildTextField(
                    label: "Mezuniyet Yılı",
                    icon: Icons.date_range,
                  ),

                  buildDropdown(
                    label: "Deneyim Süresi",
                    icon: Icons.work_history,
                    items: experiences,
                    value: selectedExperience,
                    onChanged: (value) {
                      setState(() {
                        selectedExperience = value;
                      });
                    },
                  ),

                  buildTextField(
                    label: "Başvurulan Pozisyon",
                    icon: Icons.badge,
                  ),

                  buildTextField(
                    label: "İş Deneyimi",
                    icon: Icons.business_center,
                    maxLines: 4,
                  ),

                  buildTextField(
                    label: "Teknik Yetenekler",
                    icon: Icons.computer,
                    maxLines: 4,
                  ),

                  buildTextField(
                    label: "Yabancı Dil Bilgileri",
                    icon: Icons.language,
                    maxLines: 3,
                  ),

                  buildTextField(
                    label: "Sertifikalar",
                    icon: Icons.workspace_premium,
                    maxLines: 3,
                  ),

                  buildTextField(
                    label: "Referanslar",
                    icon: Icons.people_alt,
                    maxLines: 3,
                  ),

                  buildTextField(
                    label: "Maaş Beklentisi",
                    icon: Icons.attach_money,
                  ),

                  buildTextField(
                    label: "Neden Bu Pozisyona Başvuruyorsunuz?",
                    icon: Icons.question_answer,
                    maxLines: 5,
                  ),

                  buildTextField(
                    label: "Kendinizi Kısaca Tanıtın",
                    icon: Icons.description,
                    maxLines: 5,
                  ),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.indigo,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.upload_file,
                          size: 50,
                          color: Colors.indigo,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          fileUploaded
                              ? "CV Dosyası Yüklendi"
                              : "CV Yükleme Alanı",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              fileUploaded = true;
                            });
                          },
                          icon: const Icon(Icons.attach_file),
                          label: const Text("Dosya Yükle"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: CheckboxListTile(
                      value: isRobotChecked,
                      activeColor: Colors.green,
                      title: const Text(
                        "Ben robot değilim",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      secondary: const Icon(
                        Icons.security,
                        color: Colors.green,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isRobotChecked = value!;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: submitForm,
                      icon: const Icon(Icons.send),
                      label: const Text(
                        "Başvuruyu Gönder",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.indigoAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
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
    );
  }
}