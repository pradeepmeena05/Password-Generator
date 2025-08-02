import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';

class Passwordcheck extends StatefulWidget {
  const Passwordcheck({super.key});

  @override
  State<Passwordcheck> createState() => _PasswordcheckState();
}

class _PasswordcheckState extends State<Passwordcheck> {
  bool obscureText = true;
  TextEditingController controller = TextEditingController();
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasDigit = false;
  bool hasLength = false;
  bool hasSpecialChar = false;
  HashSet<int> names = HashSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Set Your Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              if (names.length == 5)
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                    maxHeight: 200,
                  ),
                  child: Lottie.network(
                    'https://assets2.lottiefiles.com/packages/lf20_jbrw3hcz.json',
                    fit: BoxFit.contain,
                    repeat: false,
                  ),
                ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: Card(
                  elevation: 7,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              hasLowercase = value.contains(RegExp(r'[a-z]'));
                              hasUppercase = value.contains(RegExp(r'[A-Z]'));
                              hasDigit = value.contains(RegExp(r'[0-9]'));
                              hasLength = value.length >= 8;
                              hasSpecialChar = value.contains(
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

                              if (hasLowercase) names.add(1);
                              else names.remove(1);
                              if (hasUppercase) names.add(2);
                              else names.remove(2);
                              if (hasDigit) names.add(3);
                              else names.remove(3);
                              if (hasLength) names.add(4);
                              else names.remove(4);
                              if (hasSpecialChar) names.add(5);
                              else names.remove(5);
                            });
                          },
                          controller: controller,
                          obscureText: obscureText,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: controller.text));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Password copied to clipboard"),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy, color: Colors.grey),
                                ),
                              ],
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: names.length / 5,
                          minHeight: 5,
                          color: names.length == 5 ? Colors.green : Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildRequirementRow("Lowercase letter", hasLowercase),
                        const Divider(height: 20, thickness: 0.5),
                        _buildRequirementRow("Uppercase letter", hasUppercase),
                        const Divider(height: 20, thickness: 0.5),
                        _buildRequirementRow("Number (0-9)", hasDigit),
                        const Divider(height: 20, thickness: 0.5),
                        _buildRequirementRow("Minimum 8 characters", hasLength),
                        const Divider(height: 20, thickness: 0.5),
                        _buildRequirementRow("Special character", hasSpecialChar),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isFulfilled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          isFulfilled
              ? const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, size: 14, color: Colors.white),
                )
              : const Icon(Icons.circle_outlined, size: 24, color: Colors.grey),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isFulfilled ? Colors.green : Colors.grey,
              fontWeight: isFulfilled ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}