import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/spacer_v.dart';
import 'package:lista_de_compras/theme.dart';

class BottomBody extends StatelessWidget {
  final List<Widget> children;
  final List<Widget> buttons;
  final Widget? search;
  final Widget? floatButtom;
  final Widget? total;
  final bool isFormLong;
  final bool isModal;

  const BottomBody(
      {required this.children,
      required this.buttons,
      this.floatButtom,
      this.isFormLong = false,
      this.isModal = false,
      this.search,
      this.total,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget listOfButtons = _Buttons(buttons);

    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          ),
          child: LayoutBuilder(builder: (context, viewport) {
            double keyboardHeight =
                WidgetsBinding.instance?.window.viewInsets.bottom ?? 0;
            var keyboardOpenedAndFormLong = keyboardHeight > 10 && isFormLong;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                isModal
                    ? Column(
                        children: [
                          const SpacerV(1),
                          Center(
                            child: Container(
                              height: 4,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16))),
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 3,
                    child: search ?? Container(),
                  ),
                ),
                const SpacerV(1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                    itemCount: children.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      List<Widget> items = [];

                      items.add(children[index]);

                      if (index == (children.length - 1)) {
                        items.add(
                          keyboardOpenedAndFormLong
                              ? listOfButtons
                              : Container(),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items,
                      );
                    },
                  ),
                ),
                !keyboardOpenedAndFormLong
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: listOfButtons,
                      )
                    : Container(),
                Material(
                  child: total ?? Container(),
                  elevation: 4,
                ),
              ],
            );
          }),
        ),
        Positioned(bottom: 16, right: 16, child: floatButtom ?? Container()),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  final List<Widget> buttons;
  const _Buttons(
    this.buttons, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...buttons.map(
          (item) => Column(
            children: [const SpacerV(1), item, const SpacerV(1)],
          ),
        ),
      ],
    );
  }
}
