import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BeautyFiltersScreen extends StatefulWidget {
  const BeautyFiltersScreen({super.key});
  @override
  State<BeautyFiltersScreen> createState() => _BeautyFiltersScreenState();
}

class _BeautyFiltersScreenState extends State<BeautyFiltersScreen> {
  int selectedFilter = 0;

  final filters = [
    {"name": "Natural", "icon": "✨"},
    {"name": "Glow", "icon": "🌟"},
    {"name": "Warm", "icon": "☀️"},
    {"name": "Cool", "icon": "❄️"},
    {"name": "Vivid", "icon": "🌈"},
    {"name": "Soft", "icon": "🌸"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beauty Filters"),
        backgroundColor: const Color(0xFFFFB6C1),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Save", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage("https://kayakita.com/kk_logo.png"),
                  fit: BoxFit.contain,
                  opacity: 0.3,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(filters[selectedFilter]["icon"]!, style: const TextStyle(fontSize: 64)),
                    const SizedBox(height: 8),
                    Text(filters[selectedFilter]["name"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    const Text("Take a photo to apply filter", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Take Photo"),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB6C1), foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => selectedFilter = i),
                child: Container(
                  width: 72,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: selectedFilter == i ? const Color(0xFFFFB6C1) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: selectedFilter == i ? Border.all(color: const Color(0xFFFFB6C1), width: 2) : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(filters[i]["icon"]!, style: const TextStyle(fontSize: 28)),
                      const SizedBox(height: 4),
                      Text(filters[i]["name"]!, style: TextStyle(fontSize: 11, fontWeight: selectedFilter == i ? FontWeight.bold : FontWeight.normal, color: selectedFilter == i ? Colors.white : Colors.grey)),
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
}