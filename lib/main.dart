import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define screens
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Initialize screens list
    _screens = [
      HomeScreenWithHeader(),
      ActivityScreenWithHeader(),
      ReportsScreenWithHeader(),
      ProfileScreenWithHeader(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No top-level column, just directly show the screens
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Reports"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a quick add activity dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: QuickAddActivityDialog(),
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// Custom header widget to reuse across screens
Widget buildHeader(BuildContext context) {
  return Container(
    color: Theme.of(context).primaryColor,
    padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: MediaQuery.of(context).padding.top + 8, // Add safe area padding
        bottom: 8
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.info_outline, color: Colors.black),
          onPressed: () {
            // Show the fitness tracking info dialog instead of a SnackBar
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: FitnessInfoDialog(),
                );
              },
            );
          },
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile Clicked!")),
            );
          },
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 13,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

// Fitness info dialog widget
class FitnessInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Keep track of your activity with Google Fit",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),

          // Heart Points section
          Column(
            children: [
              Icon(
                Icons.favorite,
                color: Color(0xFF07BE9A),
                size: 28,
              ),
              SizedBox(height: 8),
              Text(
                "Heart Points",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF07BE9A),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Pick up the pace to score points toward this goal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),

          SizedBox(height: 32),

          // Steps section
          Column(
            children: [
              Icon(
                Icons.directions_walk,
                color: Color(0xFF184EA5),
                size: 28,
              ),
              SizedBox(height: 8),
              Text(
                "Steps",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF184EA5),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Just keep moving to meet this goal",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),

          SizedBox(height: 32),

          Text(
            "As well as counting steps, you'll score Heart Points when you push yourself",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),

          SizedBox(height: 24),

          ElevatedButton(
            onPressed: () {
              // Close current dialog
              Navigator.of(context).pop();

              // Show Heart Points onboarding dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: HeartPointsOnboardingDialog(),
                  );
                },
              );
            },
            child: Text("Next"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Heart Points onboarding dialog
class HeartPointsOnboardingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "How to score your Heart Points",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),

          // Heart Points icon with arrow
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Color(0xFF07BE9A),
                size: 80,
              ),
              Positioned(
                right: 5,
                bottom: 15,
                child: Icon(
                  Icons.arrow_upward,
                  color: Color(0xFF07BE9A),
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          Text(
            "You'll score points for activity that raises your heart rate, like brisk walking, cycling, and HIIT",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),

          SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              // Close current dialog
              Navigator.of(context).pop();

              // Show the Weekly Target Info Dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: WeeklyTargetInfoDialog(),
                  );
                },
              );
            },
            child: Text("Next"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(150, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Weekly Target Info Dialog - New dialog that shows information about the WHO recommendations
class WeeklyTargetInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "A simple way to stay healthy",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side with heart icon and text
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Color(0xFF07BE9A),
                        size: 28,
                      ),
                      Text(
                        " 150",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF07BE9A),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Weekly target",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF07BE9A),
                    ),
                  ),
                ],
              ),

              // Right side with WHO logo
              Container(
                width: 100,
                height: 100,
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/WHO_logo.svg/1200px-WHO_logo.svg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),

          SizedBox(height: 40),

          Text(
            "Your weekly target is based on physical activity recommendations from the World Health Organization.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),

          SizedBox(height: 24),

          Text(
            "Scoring 150 Heart Points each week can help you live longer, sleep better, and boost your mood.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),

          SizedBox(height: 40),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Done"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              foregroundColor: Colors.blue[700],
              minimumSize: Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Quick Add Activity Dialog
class QuickAddActivityDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add activity",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),

          // Activity options
          _buildActivityOption(context, Icons.directions_run, "Running", Color(0xFF07BE9A)),
          _buildActivityOption(context, Icons.directions_bike, "Cycling", Color(0xFF184EA5)),
          _buildActivityOption(context, Icons.fitness_center, "Workout", Colors.orange),
          _buildActivityOption(context, Icons.pool, "Swimming", Colors.blue),

          SizedBox(height: 16),

          // More option
          InkWell(
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("More activities option clicked")),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.more_horiz, color: Colors.grey[600]),
                  SizedBox(width: 16),
                  Text(
                    "More...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16),

          // Cancel button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "CANCEL",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityOption(BuildContext context, IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$label activity selected")),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home screen with scrollable content including header
class HomeScreenWithHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample energy data for the last 7 days - normalized values between 0.0-1.0
    // These numbers represent the relative heights of the bars in your image
    final List<double> energyData = [0.9, 0.75, 0.95, 0.7, 0.92, 0.85, 0.6];

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header will scroll with content
          buildHeader(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(child: _buildConcentricCircularProgress(0.7759, 0.7532)),
                SizedBox(height: 30),
                EventBox(
                  title: "Last sleep",
                  subtitle: "Today",
                  value: "7h 24m",
                  description: "Asleep",
                ),
                SizedBox(height: 16),
                EventBox(
                  title: "Your daily goals",
                  subtitle: "last 7 days",
                  value: "3/7",
                  description: "Achieved",
                  weeklyProgress: [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9],
                ),
                SizedBox(height: 16),
                EventBox(
                  title: "Your weekly target",
                  subtitle: "23 Feb – 1 Mar",
                  value: "65 of 150",
                  description: "Scoring 150 Heart Points a week can help you live longer, sleep better and boost your mood",
                  showProgressBar: true,
                  progressValue: 65,
                  progressMaxValue: 150,
                ),
                SizedBox(height: 16),
                EventBox(
                  title: "Energy expended",
                  subtitle: "Last 7 days",
                  value: "1,146 Cal",
                  description: "Today",
                  showBarChart: true,
                  barChartData: energyData,
                ),
                // Adding extra padding at the bottom for better scrolling
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Other screens with headers
class ActivityScreenWithHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildHeader(context),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Activity Screen", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportsScreenWithHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildHeader(context),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Reports Screen", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreenWithHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildHeader(context),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Profile Screen", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildConcentricCircularProgress(double outerProgress, double innerProgress) {
  return Column(
    children: [
      SizedBox(
        width: 145,
        height: 145,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 125,
              height: 125,
              child: CircularProgressIndicator(
                value: outerProgress,
                strokeWidth: 7,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07BE9A)),
                strokeCap: StrokeCap.round,
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: innerProgress,
                strokeWidth: 7,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF184EA5)),
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "0",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color(0xFF07BE9A), height: 0.9),
                ),
                SizedBox(height: 3.0),
                Text(
                  "2,817",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF184EA5), height: 0.9),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),

      // Icons with Labels
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: Color(0xFF07BE9A), size: 16),
                  SizedBox(width: 4),
                  Text("Heart Pts", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          SizedBox(width: 24),
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.directions_walk, color: Color(0xFF184EA5), size: 16),
                  SizedBox(width: 4),
                  Text("Steps", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ],
      ),

      SizedBox(height: 12),

      // Numbers and Labels (calories, km, move min)
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Calories
          Column(
            children: [
              Text("0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              Text("cal", style: TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
          SizedBox(width: 40),

          // Kilometers
          Column(
            children: [
              Text("1.93", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              Text("km", style: TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
          SizedBox(width: 40),

          // Move Minutes
          Column(
            children: [
              Text("39", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              Text("Move Min", style: TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
        ],
      ),
    ],
  );
}
// Event Box UI Component with Progress Bar and Bar Chart
class EventBox extends StatelessWidget {
  final String? date;
  final String title;
  final String subtitle;
  final String value;
  final String description;
  final List<double>? weeklyProgress; // List of 7 progress values (0.0 - 1.0)
  final bool showProgressBar; // Parameter to show/hide progress bar
  final bool showBarChart; // New parameter to show/hide bar chart
  final List<double>? barChartData; // Data for bar chart
  final int progressValue; // Current progress value (e.g., 65)
  final int progressMaxValue; // Maximum progress value (e.g., 150)

  const EventBox({
    this.date,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.description,
    this.weeklyProgress,
    this.showProgressBar = false,
    this.showBarChart = false,
    this.barChartData,
    this.progressValue = 0,
    this.progressMaxValue = 100,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the progress value from the value string if it contains " of "
    int currentValue = progressValue;
    int maxValue = progressMaxValue;

    if (value.contains(" of ")) {
      try {
        final parts = value.split(" of ");
        currentValue = int.parse(parts[0]);
        maxValue = int.parse(parts[1]);
      } catch (e) {
        // Use default values if parsing fails
      }
    }

    // Calculate progress ratio
    final progressRatio = currentValue / maxValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (date != null) ...[
            Text(
              date!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 6),
          ],
          GestureDetector(
            onTap: () {
              if (title == "Your weekly target") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: WeeklyTargetInfoDialog(),
                    );
                  },
                );
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              title,
                              style: TextStyle(
                                  fontSize: title == "Energy expended" ? 18 : (showBarChart ? 28 : 18),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )
                          ),
                          SizedBox(height: 4),
                          Text(
                              subtitle,
                              style: TextStyle(
                                  fontSize: showBarChart ? 18 : 14,
                                  color: Colors.grey.shade700
                              )
                          ),
                        ],
                      ),
                      if (title == "Your weekly target" || showBarChart)
                        GestureDetector(
                          onTap: () {
                            if (title == "Your weekly target") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: WeeklyTargetInfoDialog(),
                                  );
                                },
                              );
                            }
                          },
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.grey[500],
                            size: 24,
                          ),
                        ),
                    ],
                  ),

                  if (showBarChart && barChartData != null && barChartData!.length > 0) ...[
                    SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Left side with calorie count
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.split(' ')[0], // Extract the number part
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            Text(
                              value.split(' ')[1], // Extract the unit part (Cal)
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              description, // "Today"
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 24),
                        // Right side with bar chart
                        Expanded(
                          child: _buildBarChart(barChartData!),
                        ),
                      ],
                    ),
                  ] else if (showProgressBar && title == "Your weekly target") ...[
                    // Weekly target-specific layout
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          currentValue.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF07BE9A),
                          ),
                        ),
                        Text(
                          " of $maxValue",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Enhanced progress bar with indicator dot
                    Stack(
                      children: [
                        // Background of progress bar
                        Container(
                          height: 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF07BE9A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),

                        // Actual progress
                        LayoutBuilder(
                            builder: (context, constraints) {
                              return Container(
                                height: 8,
                                width: constraints.maxWidth * progressRatio,
                                decoration: BoxDecoration(
                                  color: Color(0xFF07BE9A),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }
                        ),

                        // Indicator dot at progress position
                        LayoutBuilder(
                            builder: (context, constraints) {
                              return Positioned(
                                left: (constraints.maxWidth * progressRatio) - 4,
                                top: 0,
                                child: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF07BE9A),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
    // Description with logo for the weekly target
    Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Expanded(
    child: Text(
    description,
    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
    ),
    ),
    SizedBox(width: 8),
    Container(
    width: 60,
    height: 60,
    child: Image.network(
    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/WHO_logo.svg/1200px-WHO_logo.svg.png',
    fit: BoxFit.contain,
    ),
    ),
    ],
    ),
    ] else ...[
    SizedBox(height: 8),
    Text(
    value,
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF6D5EE5)
    )
    ),

    // Standard progress bar (not the weekly target style)
    if (showProgressBar && title != "Your weekly target") ...[
    SizedBox(height: 12),
    ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: LinearProgressIndicator(
    value: progressRatio,
    backgroundColor: Colors.grey.shade300,
    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07BE9A)),
    minHeight: 10,
    ),
    ),
    SizedBox(height: 8),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("0", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    Text(maxValue.toString(), style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    ],
    ),
    ],

    // Show Circular Progress Bars if enabled
    if (weeklyProgress != null && weeklyProgress!.length == 7 && !showProgressBar && !showBarChart) ...[
    SizedBox(height: 12),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(7, (index) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
    children: [
    SizedBox(
    width: 35,
    height: 35,
    child: Stack(
    alignment: Alignment.center,
    children: [
    CircularProgressIndicator(
    value: weeklyProgress![index],
    strokeWidth: 4,
    backgroundColor: Colors.grey.shade300,
    valueColor: AlwaysStoppedAnimation<Color>(
    weeklyProgress![index] > 0.5 ? Color(0xFF07BE9A) : Color(0xFF184EA5),
    ),
    ),
    Text(
    (index + 1).toString(),
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    ),
    ],
    ),
    ),
    SizedBox(height: 4),
    Text(
    "Day ${index + 1}",
    style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
    ),
    ],
    ),
    );

                        }),
                      ),
                    ),
                  ],

                  if (description.isNotEmpty && !showBarChart && title != "Your weekly target") ...[
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ],
                ],
              ],
            ),
          ),
    )],
      ),
    );
  }

  // Simple bar chart builder that matches the design in the image
  Widget _buildBarChart(List<double> data) {
    final days = ['S', 'S', 'M', 'T', 'W', 'T', 'F'];
    final maxValue = data.reduce((curr, next) => curr > next ? curr : next);

    return Container(
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          data.length,
              (index) {
            final normalizedHeight = (data[index] / maxValue) * 90;
            final isToday = index == data.length - 1; // Friday is today

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: normalizedHeight,
                  decoration: BoxDecoration(
                    color: Color(0xFF1976D2), // Blue color matching the image
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // The original bar chart using fl_chart (kept for reference but not used for Energy Expended)
  Widget _buildBarChartOriginal(List<double> data) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxY = data.reduce((curr, next) => curr > next ? curr : next) * 1.2;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        maxY: maxY,
        minY: 0,
        groupsSpace: 8,
        barGroups: List.generate(
          data.length,
              (index) => BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: data[index],
                color: Color(0xFF07BE9A),
                width: 8,
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('');
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${value.toInt()} cal',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    days[value.toInt()],
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
              dashArray: [4, 4],
            );
          },
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}