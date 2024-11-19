import 'package:flutter/material.dart';
import 'api_services/auth_service.dart';
import 'auth.dart';
import 'footer.dart';
import 'login.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  String _fullName = '';
  String _phoneNumber = '';
  String _email = '';
  String _password = '';
  String _nationalIdNumber = '';

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صالح';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال اسم المستخدم';
    } else if (value.length < 12) {
      return 'يجب أن يكون اسم المستخدم مكونًا من 12 حرفًا على الأقل';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    } else if (!RegExp(r'^\+964[0-9]{10}$').hasMatch(value)) {
      return 'يجب أن يبدأ الرقم بـ +964';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'يجب أن تكون كلمة المرور مكونة من 6 أحرف على الأقل';
    }
    return null;
  }

  String? _validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهوية الوطنية';
    } else if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
      return 'يرجى إدخال رقم هوية مكون من 12 رقماً';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          "التسجيل",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cover.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: size.height * 0.1),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "إنشاء حساب",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    _buildTextField(
                      labelText: "الاسم",
                      onChanged: (value) => _fullName = value,
                      validator: _validateUsername,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      labelText: "رقم الهاتف",
                      onChanged: (value) => _phoneNumber = value,
                      validator: _validatePhoneNumber,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      labelText: "البريد الإلكتروني",
                      onChanged: (value) => _email = value,
                      validator: _validateEmail,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      labelText: "رقم الهوية الوطنية",
                      onChanged: (value) => _nationalIdNumber = value,
                      validator: _validateNationalId,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      labelText: "كلمة المرور",
                      obscureText: true,
                      onChanged: (value) => _password = value,
                      validator: _validatePassword,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (value) {
                            setState(() {
                              _termsAccepted = value ?? false;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: Color(0xFF375DAD),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "أوافق على الشروط والأحكام",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      elevation: 0,
                      padding: EdgeInsets.all(18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && _termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('جارٍ التسجيل...')),
                          );
                          try {
                            var response = await AuthService().signUp(
                              fullName: _fullName,
                              email: _email,
                              password: _password,
                              phoneNumber: _phoneNumber,
                              nationalIdNumber: _nationalIdNumber,
                              context: context,
                            );
                            if (response != null) {
                              print('تم التسجيل بنجاح: ${response['message']}');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpVerificationPage(email: _email),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('فشل التسجيل. يرجى المحاولة مرة أخرى.')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
                            );
                          }
                        } else if (!_termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('يرجى الموافقة على الشروط')),
                          );
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF7C7878), Color(0xFF7C7878)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            "تسجيل",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "هل لديك حساب؟ تسجيل الدخول",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
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
          // Positioned(
          //   bottom: 0, // Position the footer at the bottom
          //   left: 0,
          //   right: 0,
          //   child: FooterWidget(), // Use the FooterWidget here
          // ),

        ],
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    bool obscureText = false,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFF375DAD)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        errorStyle: TextStyle(color: Colors.redAccent),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
