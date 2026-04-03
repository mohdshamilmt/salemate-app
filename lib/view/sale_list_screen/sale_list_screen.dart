import 'package:flutter/material.dart';
import 'package:post_data_to_api_sample/controller/sales_screen_contoller.dart';
import 'package:provider/provider.dart';

// Screen to display list of sales data
class SaleListScreen extends StatefulWidget {
  const SaleListScreen({super.key});

  @override
  State<SaleListScreen> createState() => _SaleListScreenState();
}

class _SaleListScreenState extends State<SaleListScreen> {
  @override
  void initState() {
    // Fetch sales data after widget build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SalesScreenContoller>().getsalesData("");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Sales List")),
      
        body: Consumer<SalesScreenContoller>(
          builder: (context, prvdrobj, child) => Column(
            children: [
              // Search input field
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    // Delay API call while typing
                    Future.delayed(const Duration(milliseconds: 500), () {
                      prvdrobj.getsalesData(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
      
              // Sales list view
              Expanded(
                child: ListView.builder(
                  itemCount: prvdrobj.salesList.length,
                  itemBuilder: (context, index) {
                    var item = prvdrobj.salesList[index];
      
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
      
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Voucher number and total amount
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item["VoucherNo"]?.toString() ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "₹ ${item["GrandTotal"]?.toString() ?? "0"}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
      
                            const SizedBox(height: 8),
      
                            // Customer name
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    item["CustomerName"]?.toString() ?? "",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
      
                            const SizedBox(height: 5),
      
                            // Date
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  item["Date"]?.toString() ?? "",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
      
                            const SizedBox(height: 5),
      
                            // Status label
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item["Status"]?.toString() ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
