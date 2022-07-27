import 'package:flutter/material.dart';
import 'package:promqueen_client/widgets/add_button.dart';
import 'package:promqueen_client/widgets/bar_title.dart';
import 'package:promqueen_client/widgets/settings_button.dart';

import 'models/intake.dart';

import 'helpers/remote_service.dart';

import 'widgets/error_screen.dart';
import 'widgets/loading.dart';
import 'widgets/reset_button.dart';
import 'main_screen.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  late Future<List<Intake>?> dataFuture;
  int chartMode = 0;

  @override
  void initState() {
    super.initState();
    dataFuture = RemoteService.getAllIntakes();
  }

  void _updateToCachedVer() => setState(() {
    dataFuture = Future<List<Intake>>((() => RemoteService.cachedIntakes));
  });

  void refreshChart() => setState(() => chartMode = chartMode);

  void changeChartMode(bool plus) =>
      setState(() => (chartMode == 3 && plus) || (chartMode == 0 && !plus)
          ? chartMode = plus ? 0 : 3
          : plus
              ? chartMode++
              : chartMode--);

  Future refetchIntakes([refetch = false]) async {
    setState(() {
      dataFuture = RemoteService.getAllIntakes(refetch);
    });
  }

  Future addIntake(
    String name,
    int calories,
    int protein,
    int carbs,
    int fats,
    int sodium
  ) async {
    if (await RemoteService.createIntake(
      name, 
      calories, 
      protein, 
      carbs, 
      fats, 
      sodium)) _updateToCachedVer();
  }

  Future editIntake(Intake data) async {
    if (await RemoteService.editIntake(data)) {
      setState(() {
        dataFuture = Future<List<Intake>>((() => RemoteService.cachedIntakes));
      });
    }
  }

  Future duplicateIntake(Intake data, BuildContext? ctx) async {
    if (await RemoteService.duplicateIntake(data)) _updateToCachedVer();
    if (ctx != null) Navigator.pop(ctx, 'DUPLICATED');
  }

  Future resetIntakes(BuildContext? ctx) async {
    if (RemoteService.cachedIntakes.isEmpty) {
      if (ctx != null) return Navigator.pop(ctx, 'ALREADY_EMPTY');
    }

    if (await RemoteService.resetIntakes()) {
      setState(() { dataFuture = Future<List<Intake>>((() => [])); });
    }

    if (ctx != null) Navigator.pop(ctx, 'OK');
  }

  Future deleteIntake(Intake obj) async {
    if (await RemoteService.deleteIntake(obj)) _updateToCachedVer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BarTitle(chartMode, changeChartMode), actions: [
        ResetButton(resetIntakes),
        SettingsButton(refreshChart),
      ]),
      body: FutureBuilder<List<Intake>?>(
        future: dataFuture,
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return snapshot.hasError || !snapshot.hasData
                ? ErrorScreen(refetchIntakes)
                : MainScreen(
                  snapshot.data as List<Intake>, 
                  deleteIntake,
                  editIntake,
                  duplicateIntake,
                  chartMode, 
                  changeChartMode
                );

            default: return const Loading();
          }
        }),
      ),
      floatingActionButton: AddButton(addIntake),
    );
  }
}
