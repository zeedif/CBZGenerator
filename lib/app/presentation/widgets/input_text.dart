import 'package:cbz_generator/app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String label;
  final Icon? icon;
  final Widget? iconSuffix;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const InputText({
    super.key,
    this.onChanged,
    this.controller,
    required this.label,
    this.icon,
    this.iconSuffix,
    this.inputType,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late bool _obscureText;
  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      initialValue: '',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.controller,
              obscureText: _obscureText,
              keyboardType: widget.inputType,
              onChanged: (text) {
                text = text.trim();
                if (widget.validator != null) {
                  // ignore: invalid_use_of_protected_member
                  state.setValue(text);
                  state.validate();
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(text);
                }
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                // errorText: state.hasError ? state.errorText : 'null',
                contentPadding: const EdgeInsets.only(
                  top: 0,
                  left: kDefaultPadding / 2,
                  right: kDefaultPadding / 2,
                ),
                prefixIcon: widget.icon,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.iconSuffix != null) widget.iconSuffix!,
                    if (widget.isPassword)
                      CupertinoButton(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        onPressed: () {
                          _obscureText = !_obscureText;
                          setState(() {});
                        },
                      ),
                  ],
                ),
                hintText: widget.label,
                labelText: widget.label,
              ),
            ),
            if (state.hasError)
              Text(
                state.errorText!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 11,
                ),
              ),
          ],
        );
      },
    );
  }
}
