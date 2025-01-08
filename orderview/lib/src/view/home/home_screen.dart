import 'package:flutter/material.dart';
import 'package:orderview/src/service/menu/menu_handler.dart';
import 'package:orderview/src/widgets/sidebar/sidebar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1; // Mantenha o estado de selectedIndex

  // Função que será chamada quando um item do Sidebar for selecionado
  void _onSidebarItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Atualiza o índice do item selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SidebarWidget(
              selectedIndex:
                  selectedIndex, // Passa o selectedIndex para o Sidebar
              onSelectedIndex:
                  _onSidebarItemTapped, // Passa a função de callback
            ),
          ),
          VerticalDivider(
            thickness: 1.2,
            color: Colors.grey.shade900,
          ),
          Expanded(
              flex: 5,
              child: menuHandler(
                  selectedIndex) // Passa o selectedIndex para o menuHandler
              )
        ],
      ),
    );
  }
}
