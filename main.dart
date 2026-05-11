import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasvuruFormu(),
    );
  }
}

class BasvuruFormu extends StatefulWidget {
  const BasvuruFormu({super.key});

  @override
  State<BasvuruFormu> createState() => _BasvuruFormuState();
}

class _BasvuruFormuState extends State<BasvuruFormu> {
  final _formKey = GlobalKey<FormState>();

  bool robotDegilim = false;

  final Color anaRenk = const Color(0xFF00A8C5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF7FB),
      appBar: AppBar(
        title: const Text("İŞ BASVURU FORMU"),
        centerTitle: true,
        backgroundColor: anaRenk,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Color(0xFF00A8C5),
                  child: Icon(
                    Icons.work,
                    color: Colors.white,
                    size: 38,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Personel Bilgi Formu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Lütfen bilgilerinizi eksiksiz doldurun!!",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 25),

                buildTextField("Adınız", Icons.person),

                const SizedBox(height: 15),

                buildTextField("Soyadınız", Icons.badge),

                const SizedBox(height: 15),

                buildTextField("Telefon", Icons.phone),

                const SizedBox(height: 15),

                buildTextField("E-Posta", Icons.email),

                const SizedBox(height: 15),

                TextFormField(
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mesaj alanı zorunludur";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Mesajınız",
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Icon(
                        Icons.message,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: anaRenk,
                      width: 2,
                    ),
                  ),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload_file),
                    label: const Text(
                      "CV Yükle",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Checkbox(
                      value: robotDegilim,
                      activeColor: anaRenk,
                      onChanged: (value) {
                        setState(() {
                          robotDegilim = value!;
                        });
                      },
                    ),
                    const Text(
                      "Ben robot değilim",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: anaRenk,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!robotDegilim) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Robot doğrulamasını yapmadınız ",
                                ),
                              ),
                            );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Başvuru başarıyla gönderildi   ",
                            ),
                            ),
                          );
                        }
                    },
                    child: const Text(
                      "BAŞVURUYU GÖNDER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                       ),
                     ),
                ),
                ],
            ),
             ),
        ),
         ),
       );
  }

  Widget buildTextField(String hint, IconData icon) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hint alanı zorunludur";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.grey.shade700,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
