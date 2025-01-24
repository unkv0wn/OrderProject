import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Icon? customIcon;
  final TextEditingController customController;
  final String? Function(String?)? validadorCustom;
  final bool isRequired;
  final bool readOnly;
  final VoidCallback? onEditingComplete;

  const FormInput({
    super.key,
    required this.labelText,
    this.customIcon,
    required this.customController,
    required this.validadorCustom,
    this.isRequired = false,
    required this.hintText,
    this.onEditingComplete,
    this.readOnly = false,
  });

  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    widget.customController.addListener(() {
      // Garantir que o cursor esteja no final do texto e que não esteja selecionado
      widget.customController.selection =
          TextSelection.collapsed(offset: widget.customController.text.length);
    });

    // Adiciona um listener ao FocusNode para detectar quando o foco é perdido
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Chama a função onEditingComplete quando o foco é perdido
        widget.onEditingComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.labelText,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            if (widget.isRequired)
              Text(
                '*',
                style: TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextFormField(
            readOnly: widget.readOnly,
            controller: widget.customController,
            inputFormatters: [UpperCaseTextFormatter()],
            focusNode: _focusNode, // Atribui o FocusNode ao TextFormField
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 17),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white70, width: 1.5)),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            style: TextStyle(color: Colors.white),
            validator: widget.validadorCustom,
            onEditingComplete: widget.onEditingComplete),
      ],
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // valor anterior
    TextEditingValue newValue, // novo valor
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(), // converte para uppercase
      selection: newValue.selection,
    );
  }
}
