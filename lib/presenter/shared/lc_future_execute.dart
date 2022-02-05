import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/presenter/shared/dialogs/lc_info_dialog.dart';
import 'package:provider/provider.dart';

class LCFutureExecute extends StatefulWidget {
  final Future Function(BuildContext) futureBuilder;
  final Widget Function(BuildContext, bool, VoidCallback) builder;
  final Function(BuildContext, dynamic)? onOk;

  const LCFutureExecute({
    required this.futureBuilder,
    required this.builder,
    this.onOk,
    Key? key,
  }) : super(key: key);

  @override
  State<LCFutureExecute> createState() => _LCFutureExecuteState();
}

class _LCFutureExecuteState extends State<LCFutureExecute> {
  var loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> _navKey =
        Provider.of<GlobalKey<NavigatorState>>(context, listen: false);

    void onPressed() async {
      setState(() {
        loading = true;
      });
      try {
        var future = widget.futureBuilder(context);

        var res = await future;

        if (widget.onOk != null) {
          widget.onOk!(context, res);
        }
      } on FirebaseAuthException catch (ex) {
        lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: ex.toString(),
          confirmationText: 'Ok!',
        );
      } on FirebaseException catch (ex) {
        lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: ex.toString(),
          confirmationText: 'Ok!',
        );
      } on Exception catch (ex) {
        lcInfoDialog(
          context: _navKey.currentContext!,
          title: 'Ops ocorreu um erro',
          text: ex.toString(),
          confirmationText: 'Ok!',
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }

    return widget.builder(context, loading, onPressed);
  }
}
