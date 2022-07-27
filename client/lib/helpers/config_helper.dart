import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/intake.dart';

class ConfigHelper {
  static late int calorieIntake;
  static late int proteinIntake;
  static late int carbsIntake;
  static late int fatsIntake;
  static late int sodiumIntake;

  static void setCachedConfig(
    int cIntake,
    int pIntake,
    int caIntake,
    int fIntake,
    int sIntake,
  ) {
    calorieIntake = cIntake;
    proteinIntake = pIntake;
    carbsIntake = caIntake;
    fatsIntake = fIntake;
    sodiumIntake = sIntake;
  }
  
  static Future init() async {
    final prefs = await SharedPreferences.getInstance();
    final int? calorieAttempt = prefs.getInt('calorie_intake');

    if (calorieAttempt != null) {
      setCachedConfig(
        calorieAttempt, 
        prefs.getInt('protein_intake')!, 
        prefs.getInt('carbs_intake')!, 
        prefs.getInt('fats_intake')!, 
        prefs.getInt('sodium_intake')!
      );
    } else {
      setCachedConfig(2000, 100, 200, 50, 1200);

      editConfig(
        calorieIntake, 
        proteinIntake, 
        carbsIntake, 
        fatsIntake, 
        sodiumIntake
      );
    }
  }

  static Future editConfig(
    int cIntake,
    int pIntake,
    int caIntake,
    int fIntake,
    int sIntake,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('calorie_intake', cIntake);
    prefs.setInt('protein_intake', pIntake);
    prefs.setInt('carbs_intake', caIntake);
    prefs.setInt('fats_intake', fIntake);
    prefs.setInt('sodium_intake', sIntake);

    setCachedConfig(cIntake, pIntake, caIntake, fIntake, sIntake);
  }

  static List<int> getConfig() {
    return [
      calorieIntake,
      proteinIntake,
      carbsIntake,
      fatsIntake,
      sodiumIntake
    ];
  }

  static List<charts.Series<PercentageChart, String>> getCalorieChart(
      List<Intake> data) {
    int consumed = data.map((e) => e.calories).sum;
    return PercentageChart.getPercentualChart(
        'Calories', consumed, calorieIntake);
  }

  static List<charts.Series<PercentageChart, String>> getProteinChart(
      List<Intake> data) {
    int consumed = data.map((e) => e.protein).sum;
    return PercentageChart.getPercentualChart(
        'Protein', consumed, proteinIntake);
  }

  static List<charts.Series<PercentageChart, String>> getCarbsChart(
      List<Intake> data) {
    int consumed = data.map((e) => e.carbs).sum;
    return PercentageChart.getPercentualChart('Carbs', consumed, carbsIntake);
  }

  static List<charts.Series<PercentageChart, String>> getFatsChart(
      List<Intake> data) {
    int consumed = data.map((e) => e.fats).sum;
    return PercentageChart.getPercentualChart('Fats', consumed, fatsIntake);
  }

  static int getDisplayValue(List<PercentageChart> data, int mode) {
    switch (mode) {
      case 1:
        return data.first.value;
      case 2:
        return ((data.last.value / (data.first.value + data.last.value)) * 100)
            .round();
      case 3:
        return ((data.first.value / (data.first.value + data.last.value)) * 100)
            .round();
      // case 0: return data.last.value;
      default:
        return data.last.value;
    }
  }

  static String getModeLabel(int mode) {
    switch (mode) {
      case 1:
        return "Info consumed (absolute)";
      case 2:
        return "Info left (percentual)";
      case 3:
        return "Info consumed (percentual)";
      // case 0: return data.last.value;
      default:
        return "Info left (absolute)";
    }
  }
}

class PercentageChart {
  String status;
  int value;

  PercentageChart(this.status, this.value);

  static List<charts.Series<PercentageChart, String>> getPercentualChart(
      String chartId, int consumed, int free) {
    return [
      PercentageChart('CONSUMED', consumed),
      PercentageChart('FREE', consumed > free ? 0 : free - consumed),
    ].getChart(chartId,
        (obj) => obj.status == 'CONSUMED' ? Colors.blue : Colors.blueGrey);
  }
}

extension ChartExtensions on List<PercentageChart> {
  List<charts.Series<PercentageChart, String>> getChart(
      String chartId, Color Function(PercentageChart) colorFunc) {
    return [
      charts.Series<PercentageChart, String>(
          id: chartId,
          colorFn: (obj, _) => charts.ColorUtil.fromDartColor(colorFunc(obj)),
          domainFn: (obj, _) => obj.status,
          measureFn: (obj, _) => obj.value,
          data: this)
    ];
  }
}
