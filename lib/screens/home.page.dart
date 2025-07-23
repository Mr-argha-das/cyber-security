import 'dart:ui';
import 'package:aithena/screens/class_section/add_classes.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool showmenu = false;
  int sectionIndex = 0;
  List<Widget> pages = [DashboardPAge(), AddClassPage()];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            children: [
              if (constraints.maxWidth > 800)
                SidebarMenu(
                  showSubmentu: (value) {
                    setState(() {
                      showmenu = !showmenu;
                    });
                  },
                ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const HeaderBar(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showmenu == true)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: BoxBorder.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color.fromARGB(151, 233, 222, 255),
                                ),
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                width: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          sectionIndex = 1;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 4,
                                        ),
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              "Add Class",
                                              style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 4,
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: ListTile(
                                          title: Text(
                                            "Class List",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 4,
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: ListTile(
                                          title: Text(
                                            "Add Section",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 4,
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: ListTile(
                                          title: Text(
                                            "Section List",
                                            style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height - 100,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(200, 233, 222, 255),
                                // border: BoxBorder.all(color: Colors.grey),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: pages[sectionIndex],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DashboardPAge extends StatelessWidget {
  const DashboardPAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(height: 20),
        SummaryCards(),
        SizedBox(height: 20),
        ChartsRow(),
        SizedBox(height: 20),
        BottomPanels(),
      ],
    );
  }
}

class SidebarMenu extends StatelessWidget {
  final Function showSubmentu;
  const SidebarMenu({super.key, required this.showSubmentu});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            SidebarItem(icon: Icons.dashboard, label: 'Admin'),
            SidebarItem(icon: Icons.person, label: 'Teacher'),
            SidebarItem(icon: Icons.school, label: 'Student'),
            SidebarItem(icon: Icons.people, label: 'Students'),
            GestureDetector(
              onTap: () => showSubmentu(5),
              child: SidebarItem(
                icon: Icons.menu_book,
                label: 'Class & Section',
              ),
            ),
            SidebarItem(icon: Icons.book, label: 'Subjects'),
            SidebarItem(icon: Icons.grade, label: 'Grades'),
            SidebarItem(icon: Icons.assignment, label: 'Homework'),
            SidebarItem(icon: Icons.beach_access, label: 'Holiday'),
            SidebarItem(icon: Icons.monetization_on, label: 'Fees'),
            SidebarItem(icon: Icons.fact_check, label: 'Exam & Result'),
            SidebarItem(icon: Icons.class_, label: 'Class'),
            SidebarItem(icon: Icons.dashboard_customize, label: 'Combo'),
          ],
        ),
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const SidebarItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        height: 70,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(color: Colors.blue),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Welcome Admin!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.notification_important, color: Colors.black),
                SizedBox(width: 12),
                Icon(Icons.flag_circle, color: Colors.black),
                SizedBox(width: 12),
                Text(
                  'Ryan Taylor',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 12),
                CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  Widget buildCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(title, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              buildCard("Students", "50055", Icons.school, Colors.blue),
              const SizedBox(height: 10),
              buildCard("Awards", "50+", Icons.emoji_events, Colors.orange),
              const SizedBox(height: 10),
              buildCard("Department", "30+", Icons.apartment, Colors.green),
              const SizedBox(height: 10),
              buildCard(
                "Revenue",
                "\$505",
                Icons.attach_money,
                Colors.deepPurple,
              ),
            ],
          );
        } else {
          return Row(
            children: [
              buildCard("Students", "50055", Icons.school, Colors.blue),
              buildCard("Awards", "50+", Icons.emoji_events, Colors.orange),
              buildCard("Department", "30+", Icons.apartment, Colors.green),
              buildCard(
                "Revenue",
                "\$505",
                Icons.attach_money,
                Colors.deepPurple,
              ),
            ],
          );
        }
      },
    );
  }
}

class ChartsRow extends StatelessWidget {
  const ChartsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: const [
              ChartCard(title: 'Overview', type: 'line'),
              SizedBox(height: 20),
              ChartCard(title: 'Number of Students', type: 'bar'),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: ChartCard(title: 'Overview', type: 'line'),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ChartCard(title: 'Number of Students', type: 'bar'),
              ),
            ],
          );
        }
      },
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final String type;
  const ChartCard({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: type == 'line'
                    ? LineChart(LineChartData(lineBarsData: []))
                    : BarChart(BarChartData(barGroups: [])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomPanels extends StatelessWidget {
  const BottomPanels({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: const [
              StarStudentsTable(),
              SizedBox(height: 20),
              StudentActivityList(),
            ],
          );
        } else {
          return Row(
            children: const [
              Expanded(child: StarStudentsTable()),
              SizedBox(width: 20),
              Expanded(child: StudentActivityList()),
            ],
          );
        }
      },
    );
  }
}

class StarStudentsTable extends StatelessWidget {
  const StarStudentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 30,
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Marks')),
              DataColumn(label: Text('Percentage')),
              DataColumn(label: Text('Year')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('PRE2209')),
                  DataCell(Text('John Smith', overflow: TextOverflow.ellipsis)),
                  DataCell(Text('1185')),
                  DataCell(Text('98%')),
                  DataCell(Text('2019')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('PRE1245')),
                  DataCell(
                    Text('Jolie Hoskins', overflow: TextOverflow.ellipsis),
                  ),
                  DataCell(Text('1195')),
                  DataCell(Text('99.5%')),
                  DataCell(Text('2018')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentActivityList extends StatelessWidget {
  const StudentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: const [
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text('1st place in "Chess"'),
              subtitle: Text('John Doe won 1st place in Chess'),
              trailing: Text('1 day ago'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.sports_handball),
              title: Text('Participated in "Carrom"'),
              subtitle: Text('Justin Lee participated in Carrom'),
              trailing: Text('2 hours ago'),
            ),
          ],
        ),
      ),
    );
  }
}
