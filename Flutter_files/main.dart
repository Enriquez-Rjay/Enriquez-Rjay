import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_package;
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'dart:developer' as devtools;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Type Identifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade700,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade200, // Light orange
              Colors.orange.shade500, // Orange
              Colors.deepOrange.shade700, // Dye orange
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // App Icon/Logo
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.restaurant,
                      size: 80,
                      color: Colors.deepOrange.shade700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // App Title
                  const Text(
                    'Meal Type Identifier',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Description
                  Text(
                    'Identify meal types instantly using AI\npowered image recognition',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 60),
                  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ToolsListPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepOrange.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 56,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 12,
                      shadowColor: Colors.black.withOpacity(0.4),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Swipeable Meal Images Carousel
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        final mealImages = [
                          'assets/Burger.jpg',
                          'assets/Egg.jpg',
                          'assets/Chicken.jpg',
                          'assets/Fries.jpg',
                          'assets/Noodles.jpg',
                          'assets/Pizza.jpg',
                          'assets/Rice.jpg',
                          'assets/Salad.jpg',
                          'assets/Sandwich.jpg',
                          'assets/Soup.jpg',
                        ];

                        final mealNames = [
                          'Burger',
                          'Egg',
                          'Chicken',
                          'Fries',
                          'Noodles',
                          'Pizza',
                          'Rice',
                          'Salad',
                          'Sandwich',
                          'Soup',
                        ];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.orange.shade300,
                                  Colors.orange.shade500,
                                  Colors.deepOrange.shade600,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      mealImages[index],
                                      fit: BoxFit.scaleDown,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[400],
                                          child: const Icon(
                                            Icons.image_not_supported,
                                            size: 64,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Meal name overlay
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: Text(
                                      mealNames[index],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Ensure bottom spacing matches screen padding to avoid white space
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Updated ToolsListPage with Sidebar Navigation
class ToolsListPage extends StatelessWidget {
  const ToolsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Types'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade200,
                Colors.orange.shade500,
                Colors.deepOrange.shade700,
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade900,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.restaurant,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Meal Type Identifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _DrawerMenuItem(
                icon: Icons.camera_alt,
                title: 'Scan',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
              ),
              _DrawerMenuItem(
                icon: Icons.history,
                title: 'Logs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  );
                },
              ),
              _DrawerMenuItem(
                icon: Icons.analytics,
                title: 'Analytics',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatisticsPage(),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.white30, thickness: 1, height: 30),
              _DrawerMenuItem(
                icon: Icons.list,
                title: 'Meal Types',
                onTap: () {
                  Navigator.pop(context);
                },
                isActive: true,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade200, // Light orange
              Colors.orange.shade500, // Orange
              Colors.deepOrange.shade700, // Dye orange
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Meal Types:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 12,
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 28),
                    SizedBox(width: 16),
                    Text(
                      'Proceed to Camera',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    _MealListItem(label: 'Burger'),
                    _MealListItem(label: 'Egg'),
                    _MealListItem(label: 'Chicken'),
                    _MealListItem(label: 'Fries'),
                    _MealListItem(label: 'Noodles'),
                    _MealListItem(label: 'Pizza'),
                    _MealListItem(label: 'Rice'),
                    _MealListItem(label: 'Salad'),
                    _MealListItem(label: 'Sandwich'),
                    _MealListItem(label: 'Soup'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Drawer Menu Item Widget
class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

// Meal List Item for the column layout
class _MealListItem extends StatelessWidget {
  final String label;

  const _MealListItem({required this.label});

  // Map meal labels to asset image paths
  String _getImagePath(String label) {
    final imageMap = {
      'Burger': 'assets/Burger.jpg',
      'Egg': 'assets/Egg.jpg',
      'Chicken': 'assets/Chicken.jpg',
      'Fries': 'assets/Fries.jpg',
      'Noodles': 'assets/Noodles.jpg',
      'Pizza': 'assets/Pizza.jpg',
      'Rice': 'assets/Rice.jpg',
      'Salad': 'assets/Salad.jpg',
      'Sandwich': 'assets/Sandwich.jpg',
      'Soup': 'assets/Soup.jpg',
    };
    return imageMap[label] ?? 'assets/upload.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealDetailPage(label: label)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.09),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.deepOrange.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Attractive Image Container
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  _getImagePath(label),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to view details',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Database Helper Class
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('scan_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = path_package.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE scan_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        label TEXT NOT NULL,
        confidence REAL NOT NULL,
        image_path TEXT NOT NULL,
        date_time TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertScan(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('scan_history', row);
  }

  Future<List<Map<String, dynamic>>> getAllScans() async {
    final db = await instance.database;
    return await db.query('scan_history', orderBy: 'id DESC');
  }

  Future<int> deleteScan(int id) async {
    final db = await instance.database;
    return await db.delete('scan_history', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllScans() async {
    final db = await instance.database;
    return await db.delete('scan_history');
  }

  // Normalize label - trim and handle variations
  static String _normalizeLabel(String label) {
    return label.trim();
  }

  // Get statistics for charts
  Future<Map<String, int>> getLabelCounts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT label, COUNT(*) as count 
      FROM scan_history 
      GROUP BY label 
      ORDER BY count DESC
    ''');
    
    Map<String, int> labelCounts = {};
    for (var row in results) {
      final rawLabel = row['label'] as String;
      final normalizedLabel = _normalizeLabel(rawLabel);
      labelCounts[normalizedLabel] = (labelCounts[normalizedLabel] ?? 0) + (row['count'] as int);
    }
    return labelCounts;
  }

  Future<Map<String, double>> getAverageConfidence() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT label, AVG(confidence) as avg_confidence 
      FROM scan_history 
      GROUP BY label 
      ORDER BY avg_confidence DESC
    ''');
    
    Map<String, double> avgConfidence = {};
    for (var row in results) {
      avgConfidence[row['label']] = row['avg_confidence'] as double;
    }
    return avgConfidence;
  }
}

class MyHomePage extends StatefulWidget {
  final String? initialTool;
  const MyHomePage({super.key, this.initialTool});

  @override
  State<MyHomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHomePage> {
  File? filePath;
  String label = "";
  double confidence = 0.0;
  List<dynamic>? recognitions;

  // Get meal image path based on label
  String _getMealImagePath(String mealLabel) {
    final imageMap = {
      'Burger': 'assets/Burger.jpg',
      'Egg': 'assets/Egg.jpg',
      'Chicken': 'assets/Chicken.jpg',
      'Fries': 'assets/Fries.jpg',
      'Noodles': 'assets/Noodles.jpg',
      'Pizza': 'assets/Pizza.jpg',
      'Rice': 'assets/Rice.jpg',
      'Salad': 'assets/Salad.jpg',
      'Sandwich': 'assets/Sandwich.jpg',
      'Soup': 'assets/Soup.jpg',
    };
    // Try exact match first
    if (imageMap.containsKey(mealLabel)) {
      return imageMap[mealLabel]!;
    }
    // Try case-insensitive match
    for (var entry in imageMap.entries) {
      if (entry.key.toLowerCase() == mealLabel.toLowerCase()) {
        return entry.value;
      }
    }
    return 'assets/upload.jpg';
  }

  Future<void> _tfiteInit() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  Future<void> _saveToHistory() async {
    if (filePath != null && label.isNotEmpty) {
      await DatabaseHelper.instance.insertScan({
        'label': label,
        'confidence': confidence,
        'image_path': filePath!.path,
        'date_time': DateTime.now().toIso8601String(),
      });
    }
  }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recs = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 10,
      threshold: 0.01,
      asynch: true,
    );

    if (recs == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log("Recognitions: $recs");
    setState(() {
      recognitions = recs;
      if (recs.isNotEmpty) {
        // Get confidence value (0.0 to 1.0) and convert to percentage
        final confValue = (recs[0]['confidence'] as num).toDouble();
        confidence = confValue * 100.0;
        devtools.log("Confidence value: $confValue, Percentage: $confidence");
        
        // Extract label - remove number prefix if present (e.g., "0 Burger" -> "Burger")
        String rawLabel = recs[0]['label'].toString();
        devtools.log("Raw label: $rawLabel");
        // Remove leading numbers and spaces
        rawLabel = rawLabel.replaceFirst(RegExp(r'^\d+\s*'), '').trim();
        label = rawLabel;
        devtools.log("Processed label: $label, Confidence: $confidence%");
      }
    });

    // Save to history
    await _saveToHistory();
  }

  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recs = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 10,
      threshold: 0.01,
      asynch: true,
    );

    if (recs == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log("Recognitions: $recs");
    setState(() {
      recognitions = recs;
      if (recs.isNotEmpty) {
        // Get confidence value (0.0 to 1.0) and convert to percentage
        final confValue = (recs[0]['confidence'] as num).toDouble();
        confidence = confValue * 100.0;
        devtools.log("Confidence value: $confValue, Percentage: $confidence");
        
        // Extract label - remove number prefix if present (e.g., "0 Burger" -> "Burger")
        String rawLabel = recs[0]['label'].toString();
        devtools.log("Raw label: $rawLabel");
        // Remove leading numbers and spaces
        rawLabel = rawLabel.replaceFirst(RegExp(r'^\d+\s*'), '').trim();
        label = rawLabel;
        devtools.log("Processed label: $label, Confidence: $confidence%");
      }
    });

    // Save to history
    await _saveToHistory();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tfiteInit();
    // If opened with an initial tool, set the label so the scanner shows it
    if (widget.initialTool != null && widget.initialTool!.isNotEmpty) {
      label = widget.initialTool!;
      confidence = 0.0;
    }
  }

  // Normalize a raw label string: lowercase, remove punctuation
  String _clean(String s) => s.replaceAll(RegExp(r"[^a-z0-9 ]"), '').toLowerCase();

  // Correct common misspellings coming from asset names / labels
  String _correctCommon(String s) {
    var t = s.toLowerCase();
    final Map<String, String> fixes = {
      'wranch': 'wrench',
      'wrnch': 'wrench',
      'cobination': 'combination',
      'nindle': 'needle',
      'flier': 'plier',
      'plirs': 'pliers',
      'plie r': 'plier',
      // screwdriver variants
      'screw driver': 'screwdriver',
      'screw-driver': 'screwdriver',
      'screwdrivier': 'screwdriver',
      'screw drivier': 'screwdriver',
      'star screw': 'star screwdriver',
      'flat screw': 'flat screwdriver',
    };
    fixes.forEach((k, v) {
      t = t.replaceAll(k, v);
    });
    return t;
  }


  // Map a raw recognition label to the canonical key used in allMeals
  String _canonicalKeyFor(String raw, List<String> allMeals) {
    final cleaned = _clean(_correctCommon(raw)).replaceAll('', ' ').trim();
    final cleanedNoSpace = cleaned.replaceAll(' ', '');
    
    // exact / normalized match first
    for (var meal in allMeals) {
      final mealClean = _clean(meal).trim();
      final mealNoSpace = mealClean.replaceAll(' ', '');
      if (cleanedNoSpace == mealNoSpace) return meal.trim().toLowerCase();
      if (cleaned == mealClean) return meal.trim().toLowerCase();
      if (cleanedNoSpace.contains(mealNoSpace) || mealNoSpace.contains(cleanedNoSpace)) {
        return meal.trim().toLowerCase();
      }
    }
    
    // token-based match
    final tokens = cleaned.split(RegExp(r'\s+')).where((t) => t.length > 2).toSet();
    String? best;
    int bestScore = 0;
    for (var meal in allMeals) {
      final mTokens = _clean(_correctCommon(meal)).split(RegExp(r'\s+')).where((t) => t.length > 2).toSet();
      final intersect = tokens.intersection(mTokens);
      if (intersect.isEmpty) continue;
      if (intersect.length > bestScore) {
        bestScore = intersect.length;
        best = meal.trim().toLowerCase();
      }
    }
    return best ?? cleaned;
  }

  // Compute normalized map (canonical -> percent) using recognitions
  Map<String, double> _computeNormalizedMap() {
    const List<String> allMeals = [
      'Burger',
      'Egg',
      'Chicken',
      'Fries',
      'Noodles',
      'Pizza',
      'Rice',
      'Salad',
      'Sandwich',
      'Soup',
    ];

    final Map<String, double> original = {};
    if (recognitions != null && recognitions!.isNotEmpty) {
      for (var e in recognitions!) {
        String raw = e['label'].toString();
        // Remove number prefix if present (e.g., "0 Burger" -> "Burger")
        raw = raw.replaceFirst(RegExp(r'^\d+\s*'), '').trim();
        final key = _canonicalKeyFor(raw, allMeals);
        original[key] = (e['confidence'] as num) * 100.0;
      }
    }

    // Build canonical working map with default 0
    final Map<String, double> working = {};
    for (var meal in allMeals) {
      working[meal.trim().toLowerCase()] = 0.0;
    }
    // assign known original values
    for (var entry in original.entries) {
      // if entry.key exactly matches a canonical key, use it
      if (working.containsKey(entry.key)) {
        working[entry.key] = entry.value;
      } else {
        // try to fuzzy match again to canonical names
        for (var meal in allMeals) {
          final can = meal.trim().toLowerCase();
          if (can.contains(entry.key) || entry.key.contains(can)) {
            working[can] = max(working[can]!, entry.value);
          }
        }
      }
    }

    final double sum = working.values.fold(0.0, (a, b) => a + b);
    final Map<String, double> normalized = {};
    if (sum > 0) {
      final double maxVal = working.values.reduce((a, b) => a > b ? a : b);
      if (maxVal / sum >= 0.98) {
        String maxKey = working.entries.firstWhere((e) => e.value == maxVal).key;
        for (var k in working.keys) normalized[k] = (k == maxKey) ? 100.0 : 0.0;
      } else {
        for (var entry in working.entries) {
          normalized[entry.key] = (entry.value / sum) * 100.0;
        }
      }
    } else {
      for (var k in working.keys) normalized[k] = 0.0;
    }
    return normalized;
  }

  // Teachable Machine style VERTICAL bars (columns) for current predictions — show ALL classes
  Widget _buildPredictionBars() {
    const List<String> allMeals = [
      'Burger',
      'Egg',
      'Chicken',
      'Fries',
      'Noodles',
      'Pizza',
      'Rice',
      'Salad',
      'Sandwich',
      'Soup',
    ];

    // Use centralized normalization helper so both bars and accuracy text align
    final normalizedMap = _computeNormalizedMap();

    double _findConfidence(String meal) {
      final key = meal.trim().toLowerCase();
      if (normalizedMap.containsKey(key)) return normalizedMap[key]!;
      for (var k in normalizedMap.keys) {
        if (k.contains(key) || key.contains(k)) return normalizedMap[k]!;
      }
      return 0.0;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: allMeals.map((meal) {
          final double pct = _findConfidence(meal).clamp(0.0, 100.0);
          final bool hasData = pct > 0.0;
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Percentage text above the bar
                SizedBox(
                  height: 16,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '${pct.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: hasData ? Colors.deepOrange.shade700 : Colors.black45,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                // Vertical bar (column)
                Container(
                  width: 24,
                  height: 110 * (pct / 100.0).clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    color: hasData ? Colors.deepOrange.shade700 : Colors.grey.shade300,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    boxShadow: hasData
                        ? [
                            BoxShadow(
                              color: Colors.deepOrange.withOpacity(0.3),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : [],
                  ),
                ),
                const SizedBox(height: 6),
                // Meal label below the bar
                SizedBox(
                  height: 34,
                  width: 28,
                  child: Text(
                    meal,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: hasData ? Colors.black87 : Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 12);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Identify Meals"),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade200,
                Colors.orange.shade500,
                Colors.deepOrange.shade700,
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade900,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.restaurant,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Meal Type Identifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _DrawerMenuItem(
                icon: Icons.camera_alt,
                title: 'Scan',
                onTap: () {
                  Navigator.pop(context);
                },
                isActive: true,
              ),
              _DrawerMenuItem(
                icon: Icons.history,
                title: 'Logs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  );
                },
              ),
              _DrawerMenuItem(
                icon: Icons.analytics,
                title: 'Analytics',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatisticsPage(),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.white30, thickness: 1, height: 30),
              _DrawerMenuItem(
                icon: Icons.list,
                title: 'Meal Types',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ToolsListPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade200,
              Colors.orange.shade500,
              Colors.deepOrange.shade700,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                sizedBox,
                Card(
                  elevation: 24,
                  shadowColor: Colors.deepOrange.withOpacity(0.3),
                  color: Colors.white.withOpacity(0.95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                child: SizedBox(
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        Container(
                          height: 280,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: filePath != null
                                ? Image.file(
                                    filePath!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback to asset image if file can't be loaded
                                      return label.isNotEmpty
                                          ? Image.asset(
                                              _getMealImagePath(label),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey[300],
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.image_not_supported,
                                                      size: 64,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 64,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                    },
                                  )
                                : (label.isNotEmpty
                                    ? Image.asset(
                                        _getMealImagePath(label),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                                size: 64,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 64,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                label,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Builder(builder: (context) {
                                // Use the same normalized map as the bar graph for consistency
                                final normalizedMap = _computeNormalizedMap();
                                const allMeals = [
                                  'Burger',
                                  'Egg',
                                  'Chicken',
                                  'Fries',
                                  'Noodles',
                                  'Pizza',
                                  'Rice',
                                  'Salad',
                                  'Sandwich',
                                  'Soup',
                                ];
                                
                                // Find the canonical key for the current label
                                final canonical = _canonicalKeyFor(label, allMeals);
                                double pct = 0.0;
                                
                                // Get percentage from normalized map (same as bar graph)
                                if (normalizedMap.containsKey(canonical)) {
                                  pct = normalizedMap[canonical]!;
                                } else {
                                  // Fallback: try to find by matching keys
                                  for (var key in normalizedMap.keys) {
                                    if (key.contains(canonical) || canonical.contains(key)) {
                                      pct = normalizedMap[key]!;
                                      break;
                                    }
                                  }
                                  // If still no match, use confidence as fallback
                                  if (pct == 0.0 && confidence > 0) {
                                    pct = confidence;
                                  }
                                }
                                
                                final display = '${pct.round()}%';
                                return Text(
                                  'The Accuracy is $display',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18),
                                );
                              }),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  pickImageCamera();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black.withOpacity(0.2),
                ),
                icon: const Icon(Icons.camera_alt, size: 22),
                label: const Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  pickImageGallery();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 6,
                  shadowColor: Colors.deepOrange.withOpacity(0.3),
                ),
                icon: const Icon(Icons.image, size: 22),
                label: const Text(
                  'Album',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Teachable Machine style prediction bars below buttons
              SizedBox(
                height: min(260.0, MediaQuery.of(context).size.height * 0.32),
                child: _buildPredictionBars(),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

// Statistics Page
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Map<String, int> _labelCounts = {};
  bool _isLoading = true;

  // All 10 meal types
  static const List<String> _mealTypes = [
    'Burger',
    'Egg',
    'Chicken',
    'Fries',
    'Noodles',
    'Pizza',
    'Rice',
    'Salad',
    'Sandwich',
    'Soup',
  ];

  // Mapping from model labels to standardized meal type names
  static const Map<String, String> _labelMapping = {
    // Locking Plier variations
    'Locking Plier': 'Locking Plier',
    'LockingPlier': 'Locking Plier',
    'Locking Pliers': 'Locking Plier',
    'LockingPliers': 'Locking Plier',
    'Locking_Plier': 'Locking Plier',
    'locking plier': 'Locking Plier',
    'lockingplier': 'Locking Plier',
    'Locking': 'Locking Plier',
    
    // Open End Wrench variations
    'Open End Wrench': 'Open End Wrench',
    'OpenEndWrench': 'Open End Wrench',
    'Open_End_Wrench': 'Open End Wrench',
    'Open End': 'Open End Wrench',
    'open end wrench': 'Open End Wrench',
    'openendwrench': 'Open End Wrench',
    'OpenEnd': 'Open End Wrench',
    
    // Torque Wrench variations
    'Torque Wrench': 'Torque Wrench',
    'TorqueWrench': 'Torque Wrench',
    'Torque_Wrench': 'Torque Wrench',
    'torque wrench': 'Torque Wrench',
    'torquewrench': 'Torque Wrench',
    'Torque': 'Torque Wrench',
    
    // Needle Nose Plier variations
    'Needle Nose Plier': 'Needle Nose Plier',
    'NeedleNosePlier': 'Needle Nose Plier',
    'Needle Nose Pliers': 'Needle Nose Plier',
    'NeedleNosePliers': 'Needle Nose Plier',
    'Needle_Nose_Plier': 'Needle Nose Plier',
    'needle nose plier': 'Needle Nose Plier',
    'needlenoseplier': 'Needle Nose Plier',
    'Needle Nose': 'Needle Nose Plier',
    'NeedleNose': 'Needle Nose Plier',
    
    // Star Screwdriver variations
    'Star Screwdriver': 'Star Screwdriver',
    'StarScrewdriver': 'Star Screwdriver',
    'Star_Screwdriver': 'Star Screwdriver',
    'Star': 'Star Screwdriver',
    'star screwdriver': 'Star Screwdriver',
    'starscrewdriver': 'Star Screwdriver',
    'Star Screw': 'Star Screwdriver',
    
    // Flat Screwdriver variations
    'Flat Screwdriver': 'Flat Screwdriver',
    'FlatScrewdriver': 'Flat Screwdriver',
    'Flat_Screwdriver': 'Flat Screwdriver',
    'Flat': 'Flat Screwdriver',
    'flat screwdriver': 'Flat Screwdriver',
    'flatscrewdriver': 'Flat Screwdriver',
    'Flat Screw': 'Flat Screwdriver',
    
    // Combination Wrench variations
    'Combination Wrench': 'Combination Wrench',
    'CombinationWrench': 'Combination Wrench',
    'Combination_Wrench': 'Combination Wrench',
    'Combination Tools': 'Combination Wrench',
    'CombinationTools': 'Combination Wrench',
    'Combination': 'Combination Wrench',
    'combination wrench': 'Combination Wrench',
    'combinationwrench': 'Combination Wrench',
    'Combination Tool': 'Combination Wrench',
    'CombinationTool': 'Combination Wrench',
    
    // Hammer variations
    'Hammer': 'Hammer',
    'hammer': 'Hammer',
    'HAMMER': 'Hammer',
    
    // Adjustable Wrench variations
    'Adjustable Wrench': 'Adjustable Wrench',
    'AdjustableWrench': 'Adjustable Wrench',
    'Adjustable_Wrench': 'Adjustable Wrench',
    'Adjustable': 'Adjustable Wrench',
    'adjustable wrench': 'Adjustable Wrench',
    'adjustablewrench': 'Adjustable Wrench',
    
    // Nut Driver variations
    'Nut Driver': 'Nut Driver',
    'NutDriver': 'Nut Driver',
    'Nut_Driver': 'Nut Driver',
    'Nut': 'Nut Driver',
    'nut driver': 'Nut Driver',
    'nutdriver': 'Nut Driver',
    // Common misspellings / labels from user's labels.txt
    'Locking flier': 'Locking Plier',
    'Open end wranch': 'Open End Wrench',
    'Nindle nose flier': 'Needle Nose Plier',
    'Star Screw drivier': 'Star Screwdriver',
    'Flat screw drivier': 'Flat Screwdriver',
    'Cobination wranch': 'Combination Wrench',
  };

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh data when page becomes visible (but only once per frame)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadStatistics();
      }
    });
  }

  Future<void> _loadStatistics() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
    });
    
    final counts = await DatabaseHelper.instance.getLabelCounts();
    
    // Normalize labels to match meal types
    Map<String, int> normalizedCounts = {};
    for (var entry in counts.entries) {
      final matchingClass = _findMatchingMealType(entry.key);
      if (matchingClass != null) {
        normalizedCounts[matchingClass] = (normalizedCounts[matchingClass] ?? 0) + entry.value;
      } else {
        // Debug: print unmapped labels
        devtools.log('Unmapped label: "${entry.key}"');
      }
    }
    
    if (mounted) {
      setState(() {
        _labelCounts = normalizedCounts;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade200,
                Colors.orange.shade500,
                Colors.deepOrange.shade700,
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade900,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.restaurant,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Meal Type Identifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _DrawerMenuItem(
                icon: Icons.camera_alt,
                title: 'Scan',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
              ),
              _DrawerMenuItem(
                icon: Icons.history,
                title: 'Logs',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryPage(),
                    ),
                  );
                },
              ),
              _DrawerMenuItem(
                icon: Icons.bar_chart,
                title: 'Analytics',
                onTap: () {
                  Navigator.pop(context);
                },
                isActive: true,
              ),
              const Divider(color: Colors.white30, thickness: 1, height: 30),
              _DrawerMenuItem(
                icon: Icons.list,
                title: 'Meal Types',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ToolsListPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _labelCounts.isEmpty
              ? const Center(
                  child: Text(
                    'No data available yet.\nStart scanning meals!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total Scans Card
                      Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.bar_chart, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_labelCounts.values.reduce((a, b) => a + b)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Total Scans'),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(Icons.analytics, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${_labelCounts.length}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Meal Types'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Visualization Title
                      const Text(
                        'Visualization',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Line Chart Card
                      Card(
                        elevation: 8,
                        color: Colors.white.withOpacity(0.95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            height: 400,
                            child: _buildLineChart(),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      _buildLineChartLegend(),
                      
                      const SizedBox(height: 32),
                      
                      // Detailed Data Section
                      const Text(
                        'Detailed Data',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Data Table
                      _buildDataTable(),
                    ],
                  ),
                ),
    );
  }

  // Helper method to find matching meal type (handles variations)
  String? _findMatchingMealType(String label) {
    final normalizedLabel = label.trim();
    
    // First, check the mapping dictionary
    if (_labelMapping.containsKey(normalizedLabel)) {
      return _labelMapping[normalizedLabel];
    }
    
    // Check case-insensitive mapping
    for (var entry in _labelMapping.entries) {
      if (entry.key.toLowerCase() == normalizedLabel.toLowerCase()) {
        return entry.value;
      }
    }
    
    // Exact match with meal types
    for (var mealType in _mealTypes) {
      if (mealType.trim().toLowerCase() == normalizedLabel.toLowerCase()) {
        return mealType;
      }
    }
    
    // Partial match (in case of extra spaces or slight variations)
    for (var mealType in _mealTypes) {
      final mealTypeLower = mealType.trim().toLowerCase();
      final labelLower = normalizedLabel.toLowerCase();
      
      // Check if label contains meal type name or vice versa
      if (mealTypeLower.contains(labelLower) || labelLower.contains(mealTypeLower)) {
        // Make sure it's a meaningful match (not just single letters)
        if (labelLower.length >= 3 || mealTypeLower.length >= 3) {
          return mealType;
        }
      }
    }
    
    // Last resort: try to match key words
    final labelWords = normalizedLabel.toLowerCase().split(RegExp(r'[\s_]+'));
    for (var mealType in _mealTypes) {
      final mealTypeWords = mealType.toLowerCase().split(' ');
      // Check if most words match
      int matchCount = 0;
      for (var word in labelWords) {
        if (word.length >= 3 && mealTypeWords.any((mt) => mt.contains(word) || word.contains(mt))) {
          matchCount++;
        }
      }
      if (matchCount >= 1 && matchCount >= labelWords.length / 2) {
        return mealType;
      }
    }
    
    return null;
  }

  Widget _buildLineChart() {
    // Get counts for each meal type - ensure all 10 types are shown
    // _labelCounts is already normalized in _loadStatistics
    final spots = _mealTypes.asMap().entries.map((entry) {
      final index = entry.key;
      final mealType = entry.value;
      final count = _labelCounts[mealType] ?? 0;
      return FlSpot(index.toDouble(), count.toDouble());
    }).toList();

    // Calculate maxY - ensure it's at least 1 to show the graph properly
    double maxY = 10.0;
    if (_labelCounts.isNotEmpty) {
      final maxCount = _labelCounts.values.reduce((a, b) => a > b ? a : b);
      maxY = (maxCount.toDouble() * 1.2).ceilToDouble();
      if (maxY < 1) maxY = 10.0;
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY > 0 ? (maxY / 10).ceilToDouble() : 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              interval: 1, // Show every label
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < _mealTypes.length) {
                  final mealType = _mealTypes[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SizedBox(
                        width: 60,
                        child: Text(
                          mealType,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              interval: maxY > 0 ? (maxY / 10).ceilToDouble() : 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        minX: 0,
        maxX: (_mealTypes.length - 1).toDouble(),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.35,
            color: Colors.deepOrange.shade700,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: Colors.deepOrange.shade700,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.deepOrange.withOpacity(0.1),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepOrange.withOpacity(0.3),
                  Colors.deepOrange.withOpacity(0.05),
                ],
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final mealIndex = touchedSpot.x.toInt();
                if (mealIndex >= 0 && mealIndex < _mealTypes.length) {
                  final mealType = _mealTypes[mealIndex];
                  return LineTooltipItem(
                    '$mealType\n${touchedSpot.y.toInt()} scans',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return null;
              }).toList();
            },
          ),
          handleBuiltInTouches: true,
        ),
      ),
    );
  }

  Widget _buildLineChartLegend() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 12,
      children: _mealTypes.asMap().entries.map((entry) {
        final mealType = entry.value;
        final count = _labelCounts[mealType] ?? 0;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade700,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$mealType: $count',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDataTable() {
    return Card(
      elevation: 4,
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.deepOrange.shade700),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          dataRowMinHeight: 50,
          dataRowMaxHeight: 60,
          columns: const [
            DataColumn(label: Text('Meal Type')),
            DataColumn(label: Text('Scan Count'), numeric: true),
          ],
          rows: _mealTypes.map((mealType) {
            final count = _labelCounts[mealType] ?? 0;
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    mealType,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// History Page
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await DatabaseHelper.instance.getAllScans();
    setState(() {
      _history = data;
    });
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.instance.deleteScan(id);
    _loadHistory();
  }

  Future<void> _clearAll() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All History'),
        content: const Text('Are you sure you want to delete all scan history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DatabaseHelper.instance.deleteAllScans();
      _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
        actions: [
          if (_history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _clearAll,
              tooltip: 'Clear All',
            ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.orange.shade200,
                Colors.orange.shade500,
                Colors.deepOrange.shade700,
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade900,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.restaurant,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Meal Type Identifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _DrawerMenuItem(
                icon: Icons.camera_alt,
                title: 'Scan',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                  );
                },
              ),
              _DrawerMenuItem(
                icon: Icons.history,
                title: 'Logs',
                onTap: () {
                  Navigator.pop(context);
                },
                isActive: true,
              ),
              _DrawerMenuItem(
                icon: Icons.bar_chart,
                title: 'Analytics',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StatisticsPage(),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.white30, thickness: 1, height: 30),
              _DrawerMenuItem(
                icon: Icons.list,
                title: 'Meal Types',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ToolsListPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _history.isEmpty
          ? const Center(
              child: Text(
                'No scan history yet',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                final dateTime = DateTime.parse(item['date_time']);
                final formattedDate = DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: item['image_path'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(item['image_path']),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image),
                                );
                              },
                            ),
                          )
                        : null,
                    title: Text(
                      item['label'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Accuracy: ${item['confidence'].toStringAsFixed(0)}%'),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteItem(item['id']),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MealDetailPage extends StatelessWidget {
  final String label;

  const MealDetailPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade700,
        elevation: 0,
        title: Text(label),
      ),
      backgroundColor: Colors.deepOrange.shade700,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            // Image mapping for meal types
            Builder(builder: (ctx) {
              final imgMap = {
                'Burger': 'assets/Burger.jpg',
                'Egg': 'assets/Egg.jpg',
                'Chicken': 'assets/Chicken.jpg',
                'Fries': 'assets/Fries.jpg',
                'Noodles': 'assets/Noodles.jpg',
                'Pizza': 'assets/Pizza.jpg',
                'Rice': 'assets/Rice.jpg',
                'Salad': 'assets/Salad.jpg',
                'Sandwich': 'assets/Sandwich.jpg',
                'Soup': 'assets/Soup.jpg',
              };

              final desc = {
                'Burger': 'A burger is a sandwich consisting of a patty of ground meat, typically beef, placed inside a sliced bun.',
                'Egg': 'Eggs are a versatile food that can be prepared in many ways - fried, scrambled, boiled, or poached.',
                'Chicken': 'Chicken is a popular protein source that can be prepared fried, grilled, roasted, or in various dishes.',
                'Fries': 'French fries are deep-fried strips of potato, often served as a side dish or snack.',
                'Noodles': 'Noodles are a type of food made from unleavened dough, commonly used in Asian cuisine.',
                'Pizza': 'Pizza is an Italian dish consisting of a flatbread base topped with cheese, sauce, and various toppings.',
                'Rice': 'Rice is a staple food grain that is a primary food source for more than half of the world\'s population.',
                'Salad': 'A salad is a dish consisting of mixed pieces of food, typically vegetables, often with a dressing.',
                'Sandwich': 'A sandwich is a food item consisting of one or more types of food placed between slices of bread.',
                'Soup': 'Soup is a liquid food, typically made by boiling meat, fish, or vegetables in stock or water.',
              };

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: min(220.0, MediaQuery.of(ctx).size.height * 0.30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Image.asset(
                              imgMap[label] ?? 'assets/upload.jpg',
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              errorBuilder: (c, e, st) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image, size: 48),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    desc[label] ?? 'No description available for this meal type.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 14),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}