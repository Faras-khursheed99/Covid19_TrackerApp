import 'package:covid_19/App%20Screens/countriesLists.dart';
import 'package:covid_19/Modals/globalStates_modal.dart';
import 'package:covid_19/Services/utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WordStatesScreen extends StatefulWidget {
  const WordStatesScreen({super.key});

  @override
  State<WordStatesScreen> createState() => _WordStatesScreenState();
}

class _WordStatesScreenState extends State<WordStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  final colorlist = [
    const Color(0xFF2196F3),
    const Color(0xFFF45A2C),
    const Color(0xFF69F0AE),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            FutureBuilder(
              future: statesServices.fetchWorldstatesRecords(),
              builder: (context, AsyncSnapshot<globalStates_modal> snapShot) {
                if (!snapShot.hasData) {
                  // Show loading spinner while fetching data
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50,
                      controller: controller,
                    ),
                  );
                } else {
                  // Display data when it is fetched
                  return Expanded(
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapShot.data!.cases!.toString()),
                            "Deaths":
                                double.parse(snapShot.data!.deaths!.toString()),
                            "Recovered": double.parse(
                                snapShot.data!.recovered!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 2.8,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorlist,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ReuseableRow(
                                      title: 'Total',
                                      value: snapShot.data!.cases.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Deaths',
                                      value: snapShot.data!.deaths.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Recovered',
                                      value:
                                          snapShot.data!.recovered.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Active',
                                      value: snapShot.data!.active.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Caritical',
                                      value: snapShot.data!.critical.toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Today Recovered',
                                      value: snapShot.data!.todayRecovered
                                          .toString(),
                                    ),
                                    ReuseableRow(
                                      title: 'Today Deaths',
                                      value:
                                          snapShot.data!.todayDeaths.toString(),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Countrieslists()));
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2196F3),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Track Countries",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReuseableRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}
