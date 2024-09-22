import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/user.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/widgets/summary_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? storesCount = 0;
  int? agentsCount = 0;
  List<User>? agents;
  List<Map<String, dynamic>> agentStores = [];

  final DatabaseService _db = locator<DatabaseService>();

  Future<int?> getStoresCount() async {
    return await _db.getStoresCount();
  }

  Future<int?> getAgentsCount() async {
    return await _db.getAgentsCount();
  }

  Future<List?> getAgents() async {
    return await _db.getAgents();
  }

  Future<int?> getAgentStoresCount(String uid) async {
    return await _db.getAgentStoresCount(uid);
  }

  Future<void> _fetchData() async {
    final getStoresCount = _db.getStoresCount();
    final getAgentsCount = _db.getAgentsCount();
    final results = await Future.wait([
      getStoresCount,
      getAgentsCount,
    ]);
    if (!mounted) return;

    setState(() {
      storesCount = results[0];
      agentsCount = results[1];
    });

    final fetchedAgents = await getAgents();
    if (!mounted) return;
    setState(() {
      agents = fetchedAgents?.map((e) => User.fromMap(e)).toList();
    });
    if (agents != null) {
      for (final User agent in agents!) {
        final storeCount = await getAgentStoresCount(agent.uid);
        setState(() {
          agentStores.add({
            "name": agent.firstName!,
            "color": agent.color,
            "storeCount": storeCount!,
          });
          debugPrint("Stores: $agentStores");
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: Sizes.base, vertical: Sizes.lg),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(Sizes.lg),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: PieChart(
                          PieChartData(
                            sections: agentStores.map((data) {
                              final percentage =
                                  (data["storeCount"] / storesCount!) * 100;
                              return PieChartSectionData(
                                radius: 50,
                                color: Color(int.parse(data["color"])),
                                value: percentage.ceilToDouble(),
                                // title: data["name"],
                                // titleStyle: theme.textTheme.titleLarge,
                                // titlePositionPercentageOffset: 2,
                                // badgeWidget: Text(
                                //   data["storeCount"].toString(),
                                //   style: theme.textTheme.bodyLarge!
                                //       .copyWith(color: Colors.white),
                                // ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: agentStores
                            .map(
                              (e) => Row(
                                children: [
                                  Container(
                                    width: Sizes.base,
                                    height: Sizes.base,
                                    margin: EdgeInsets.only(right: Sizes.sm),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(int.parse(e["color"])),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${e["name"]}",
                                      style: theme.textTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Spacing.verticalSpacingMed,
              SummaryTile(
                name: "Stores",
                value: storesCount!,
              ),
              Spacing.verticalSpacingMed,
              SummaryTile(
                name: "Agents",
                value: agentsCount!,
              ),
            ],
          )
        ],
      ),
    );
  }
}
