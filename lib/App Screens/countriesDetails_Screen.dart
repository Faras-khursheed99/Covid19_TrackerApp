import 'package:flutter/material.dart';

class CountriesdetailsScreen extends StatelessWidget {
  final String image;
  final String name;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  final int active;
  final int critical;
  final int todayRecovered;
  final int test;

  const CountriesdetailsScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // ✅ Scrollable container
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(image, height: 100, width: 100),
              const SizedBox(height: 20),
              InfoTile(title: 'Total Cases', value: totalCases),
              InfoTile(title: 'Total Deaths', value: totalDeaths),
              InfoTile(title: 'Total Recovered', value: totalRecovered),
              InfoTile(title: 'Active Cases', value: active),
              InfoTile(title: 'Critical Cases', value: critical),
              InfoTile(title: 'Today Recovered', value: todayRecovered),
              InfoTile(title: 'Tests Conducted', value: test),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final int value;

  const InfoTile({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: Text(value.toString()),
      ),
    );
  }
}
