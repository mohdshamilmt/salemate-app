import 'package:flutter/material.dart';

// Filter screen for applying sales filters
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Selected status (default: Pending)
  String selectedStatus = "Pending";

  // Selected customer (default placeholder)
  String selectedCustomer = "Customer";

  DateTime? fromDate;
  DateTime? toDate;

  // Method to pick date (from/to)
  Future<void> pickDate(bool isFrom) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  // Temporary customer selection (to be replaced with API later)
  void selectCustomer() {
    setState(() {
      selectedCustomer = "Savad Farooque";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
      
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_circle_left, color: Colors.white),
          ),
      
          actions: const [
            Icon(Icons.remove_red_eye_outlined, color: Colors.blueAccent),
            SizedBox(width: 15),
            Text("Filter", style: TextStyle(color: Colors.blueAccent)),
            SizedBox(width: 15),
          ],
      
          backgroundColor: Colors.black,
          title: const Text("Filters", style: TextStyle(color: Colors.white)),
        ),
      
        body: Padding(
          padding: const EdgeInsets.all(16),
      
          child: Column(
            children: [
              // Month filter UI (static for now)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("This Month", style: TextStyle(color: Colors.white)),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
              ),
      
              const SizedBox(height: 20),
      
              // Date range selection
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pickDate(true),
                      child: dateBox(
                        fromDate == null
                            ? "From Date"
                            : "${fromDate!.day}-${fromDate!.month}-${fromDate!.year}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => pickDate(false),
                      child: dateBox(
                        toDate == null
                            ? "To Date"
                            : "${toDate!.day}-${toDate!.month}-${toDate!.year}",
                      ),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 20),
      
              // Status selection chips
              Row(
                children: [
                  chip("Pending"),
                  const SizedBox(width: 10),
                  chip("Invoiced"),
                  const SizedBox(width: 10),
                  chip("Cancelled"),
                ],
              ),
      
              const SizedBox(height: 20),
      
              // Customer selection dropdown (UI only)
              GestureDetector(
                onTap: selectCustomer,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCustomer,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
                ),
              ),
      
              const SizedBox(height: 20),
      
              // Display selected customer as removable chip
              if (selectedCustomer != "Customer")
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedCustomer,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCustomer = "Customer";
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Date display box widget
  Widget dateBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 16, color: Colors.white),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  // Status chip widget
  Widget chip(String text) {
    bool isSelected = selectedStatus == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedStatus = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : const Color.fromARGB(255, 47, 66, 75),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
