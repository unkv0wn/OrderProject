import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:orderview/src/widgets/categories/categories_widget.dart';
import 'package:orderview/src/widgets/customtile/listtile_widget.dart';

class SidebarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int)
      onSelectedIndex; // Função de callback para passar o índice selecionado

  const SidebarWidget({
    super.key,
    required this.selectedIndex,
    required this.onSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Icon(
                LucideIcons.packageOpen,
                size: 164,
                color: Colors.white,
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(thickness: 1.2, color: Colors.grey.shade900),
              const SizedBox(
                height: 15,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  CategoriesWidget(
                    categories: "Home",
                  ),
                  ListTileCustom(
                      icon: LucideIcons.house,
                      title: "Home",
                      index: 0,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  CategoriesWidget(
                    categories: "Cadastro",
                  ),
                  ListTileCustom(
                      icon: LucideIcons.users,
                      title: "Clientes",
                      index: 1,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  ListTileCustom(
                      icon: LucideIcons.stretchVertical,
                      title: "Logradouro",
                      index: 2,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  ListTileCustom(
                      icon: LucideIcons.scale,
                      title: "Unidades de Medidas",
                      index: 3,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  ListTileCustom(
                      icon: LucideIcons.creditCard,
                      title: "Formas de Pagamento",
                      index: 4,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  ListTileCustom(
                      icon: LucideIcons.tags,
                      title: "Marcas",
                      index: 5,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  ListTileCustom(
                      icon: LucideIcons.package2,
                      title: "Produtos",
                      index: 6,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                  CategoriesWidget(
                    categories: "Pedido",
                  ),
                  ListTileCustom(
                      icon: LucideIcons.shoppingCart,
                      title: "Pedidos",
                      index: 7,
                      selectedIndex: selectedIndex,
                      onTap: onSelectedIndex),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
