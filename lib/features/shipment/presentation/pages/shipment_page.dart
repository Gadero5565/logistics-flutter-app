import 'package:flutter/material.dart';

import '../../../../core/theme/app_colours.dart';
import '../widgets/shipment_list_item.dart';
import '../widgets/shipments_filter_ship.dart';

class ShipmentsPage extends StatefulWidget {
  const ShipmentsPage({Key? key}) : super(key: key);

  @override
  State<ShipmentsPage> createState() => _ShipmentsPageState();
}

class _ShipmentsPageState extends State<ShipmentsPage> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All',
    'Pending',
    'In Transit',
    'Delivered',
    'Delayed',
  ];

  // Sample data - in a real app this would come from a repository
  final List<Map<String, dynamic>> _shipments = [
    {
      'id': 'SHP1001',
      'destination': 'New York, NY',
      'status': 'In Transit',
      'statusColor': AppColors.statusPending,
      'etaDate': 'Jun 15, 2023',
      'items': 5,
    },
    {
      'id': 'SHP1002',
      'destination': 'Los Angeles, CA',
      'status': 'Pending',
      'statusColor': AppColors.statusPending,
      'etaDate': 'Jun 18, 2023',
      'items': 3,
    },
    {
      'id': 'SHP1003',
      'destination': 'Chicago, IL',
      'status': 'Delivered',
      'statusColor': AppColors.statusCompleted,
      'etaDate': 'Jun 10, 2023',
      'items': 2,
    },
    {
      'id': 'SHP1004',
      'destination': 'Houston, TX',
      'status': 'Delayed',
      'statusColor': AppColors.statusRejected,
      'etaDate': 'Jun 16, 2023',
      'items': 1,
    },
    {
      'id': 'SHP1005',
      'destination': 'Miami, FL',
      'status': 'In Transit',
      'statusColor': AppColors.statusPending,
      'etaDate': 'Jun 17, 2023',
      'items': 4,
    },
  ];

  List<Map<String, dynamic>> get filteredShipments {
    if (_selectedFilter == 'All') {
      return _shipments;
    }
    return _shipments.where((shipment) => shipment['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shipments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to create shipment
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search shipments...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // Filter chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: RequestFilterChip(
                    label: _filters[index],
                    isSelected: _selectedFilter == _filters[index],
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = _filters[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Shipment list
          Expanded(
            child: filteredShipments.isEmpty
                ? const Center(
              child: Text(
                'No shipments found',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filteredShipments.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final shipment = filteredShipments[index];
                return ShipmentListItem(
                  id: shipment['id'],
                  destination: shipment['destination'],
                  status: shipment['status'],
                  statusColor: shipment['statusColor'],
                  etaDate: shipment['etaDate'],
                  items: shipment['items'],
                  onTap: () {
                    // Navigate to shipment details
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new shipment
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}