import 'package:covid_19/App%20Screens/countriesDetails_Screen.dart';
import 'package:covid_19/Services/utilities/states_services.dart';
import 'package:flutter/material.dart';

class Countrieslists extends StatefulWidget {
  const Countrieslists({super.key});

  @override
  State<Countrieslists> createState() => _CountrieslistsState();
}

class _CountrieslistsState extends State<Countrieslists> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Countries List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Country",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Refresh UI on search
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: statesServices.Countrieslists(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<dynamic> filteredCountries =
                        snapshot.data!.where((country) {
                      String countryName = country['country'] ?? '';
                      return countryName
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase());
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        var country = filteredCountries[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CountriesdetailsScreen(
                                      image:
                                          country['countryInfo']?['flag'] ?? '',
                                      name: country['country'] ??
                                          'Unknown Country',
                                      totalCases: country['cases'] ?? 0,
                                      totalDeaths: country['deaths'] ?? 0,
                                      totalRecovered: country['recovered'] ?? 0,
                                      active: country['active'] ?? 0,
                                      critical: country['critical'] ?? 0,
                                      todayRecovered:
                                          country['todayRecovered'] ?? 0,
                                      test: country['tests'] ?? 0,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(
                                    country['countryInfo']?['flag'] ?? '',
                                  ),
                                ),
                                title: Text(country['country'] ?? 'Unknown'),
                                subtitle: Text(
                                  "Cases: ${country['cases'] ?? 0}",
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
