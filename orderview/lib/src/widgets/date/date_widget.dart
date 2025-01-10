import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart'; // Para formatar a data


class DateWidget extends StatelessWidget {
  final TextEditingController dateController;
  final DateTime selectedDate;
  final bool isRequired;
  final String labeltext;
  final Function(DateTime) onDateSelected;

  const DateWidget({
    super.key,
    required this.dateController,
    required this.selectedDate,
    this.isRequired = false,
    required this.onDateSelected,
    required this.labeltext,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 01),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                labeltext,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              if (isRequired)
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 47,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      dateController.text.isEmpty
                          ? 'Selecione a data'
                          : dateController.text,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[600],
                      ),
                    ),
                    Spacer(),
                    Icon(
                      LucideIcons.calendar,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
