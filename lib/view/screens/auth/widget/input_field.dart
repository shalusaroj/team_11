import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final IconData icon;
  final String title;
  final TextEditingController? controller;
  final bool isPassword;
  final void Function(String)? onChanged; // Callback function

  const InputField({
    Key? key,
    required this.title,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffffefef),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && _obscureText,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            onChanged: widget.onChanged, // Pass the onChanged callback
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                widget.icon,
                color: Colors.black,
                size: 22,
              ),
              hintText: widget.title,
              hintStyle: const TextStyle(fontSize: 14, color: Colors.black26),
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
              )
                  : null,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}


