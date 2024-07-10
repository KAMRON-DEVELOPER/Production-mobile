import 'package:flutter/material.dart';

class AuthField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final Function realtimeValidator;
  const AuthField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.realtimeValidator,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        errorText = widget.realtimeValidator(value);
        setState(() {});
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  const AuthButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => print(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
