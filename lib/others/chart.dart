import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:prarambh_demo_1/pages/no_internet.dart';
import 'package:provider/provider.dart';

import 'connectivity.dart';

class Chart extends StatefulWidget {
  String? uid;
  Chart({Key? key, this.uid}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<FundingData> fundingDataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  void fetchDataFromFirebase() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("Funding")
        .where('uid', isEqualTo: widget.uid)
        .orderBy('investmentPeriod')
        .get();
    setState(() {
      fundingDataList = snapshot.docs.map((doc) {
        Timestamp? timestamp = doc.data()['investmentPeriod'];
        double? amount = doc.data()['amount'];

        return FundingData(timestamp!.toDate(), amount);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // return LineChartWidget(fundingDataList);
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline != null) {
        return model.isOnline!
            ? SizedBox(
                height: 400,
                width: 600,
                child: Transform.scale(
                  scale: 1,
                  child: LineChartWidget(fundingDataList),
                ),
              )
            : const NoInternet();
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class LineChartWidget extends StatelessWidget {
  final List<FundingData> data;

  LineChartWidget(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<FundingData, DateTime>> seriesList = [
      charts.Series<FundingData, DateTime>(
        id: 'Funding',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (FundingData data, _) => data.investmentPeriod,
        measureFn: (FundingData data, _) => data.amount,
        data: data,
      )
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: charts.TimeSeriesChart(
        seriesList,
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }
}

class FundingData {
  final DateTime investmentPeriod;
  final double? amount;

  FundingData(this.investmentPeriod, this.amount);
}
