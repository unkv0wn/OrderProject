import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  final ValueNotifier<String> valueNotifier;
  final List<String> items;
  final String hint;
  final String? selectedItem;
  final void Function(String?)? onChanged;
  final String? labelText;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    required this.valueNotifier,
    required this.items,
    required this.hint,
    this.selectedItem,
    this.onChanged,
    this.labelText,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Row(
            children: [
              Text(
                labelText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              if (isRequired)
                const Text(
                  '*',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
        const SizedBox(height: 8), // Espaçamento entre o rótulo e o dropdown
        ValueListenableBuilder<String>(
          valueListenable: valueNotifier,
          builder: (BuildContext context, String value, _) {
            final bool isValidValue = items.contains(value);
            return DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white70, width: 1.5),
                ),
              ),
              hint: Text(
                hint,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 17,
                ),
              ),
              value: isValidValue ? value : null,
              onChanged: (newValue) {
                valueNotifier.value = newValue ?? '';
                if (onChanged != null) {
                  onChanged!(newValue);
                }
              },
              items: items.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Text(
                      option,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              }).toList(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            );
          },
        ),
      ],
    );
  }
}
