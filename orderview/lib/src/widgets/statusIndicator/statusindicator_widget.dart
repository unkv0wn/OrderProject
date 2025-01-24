import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status;

  const StatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(status);
    Icon iconChange = _getStatusIcon(status);
    String statusText = _getStatusText(status);

    return Container(
      width: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withValues(alpha: 0.3),
            statusColor.withValues(alpha: 0.7)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(width: 2, color: statusColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconChange, // Aqui o widget Icon já está completo
          SizedBox(width: 8),
          Text(
            statusText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '0':
        return Colors.orange;
      case '1':
        return Colors.green;
      case '2':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case '0':
        return Icon(Icons.timelapse, color: Colors.white, size: 15);
      case '1':
        return Icon(Icons.check_circle, color: Colors.white, size: 15);
      case '2':
        return Icon(Icons.cancel, color: Colors.white, size: 15);
      default:
        return Icon(Icons.help_outline, color: Colors.white, size: 15);
    }
  }
}

String _getStatusText(String status) {
  switch (status) {
    case '0':
      return "Pendente";
    case '1':
      return "Concluido";
    case '2':
      return "Cancelado";
    default:
      return "N/A";
  }
}
