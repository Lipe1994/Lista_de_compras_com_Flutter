import 'package:flutter/material.dart';
import 'package:lista_de_compras/theme.dart';

class Navigation extends StatefulWidget {
  final List<Tab> tabs;
  final List<Widget> children;
  final int initialIndex;

  const Navigation(
      {Key? key,
      required this.tabs,
      required this.children,
      this.initialIndex = 0})
      : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(
        length: widget.tabs.length,
        initialIndex: widget.initialIndex,
        vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
              controller: _controller,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              indicator: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: whiteColor,
              ),
              labelColor: secondaryColor,
              tabs: widget.tabs),
          Expanded(
            child:
                TabBarView(controller: _controller, children: widget.children),
          ),
        ],
      ),
    );
  }
}
