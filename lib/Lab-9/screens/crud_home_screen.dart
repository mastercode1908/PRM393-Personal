import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/storage_service.dart';
import 'item_form_dialog.dart';

class CrudHomeScreen extends StatefulWidget {
  const CrudHomeScreen({Key? key}) : super(key: key);

  @override
  _CrudHomeScreenState createState() => _CrudHomeScreenState();
}

class _CrudHomeScreenState extends State<CrudHomeScreen> {
  final StorageService _storageService = StorageService();
  final TextEditingController _searchController = TextEditingController();

  List<Item> _allItems = [];
  List<Item> _filteredItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final items = await _storageService.readItems();
    setState(() {
      _allItems = items;
      _filteredItems = items;
      _isLoading = false;
    });
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        return item.name.toLowerCase().contains(query) ||
               item.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _saveData() async {
    await _storageService.writeItems(_allItems);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved successfully!')),
    );
  }

  void _showAddEditDialog({Item? item}) async {
    final result = await showDialog<Item>(
      context: context,
      builder: (context) => ItemFormDialog(itemToEdit: item),
    );

    if (result != null) {
      setState(() {
        if (item == null) {
          // Add new
          _allItems.add(result);
        } else {
          // Edit existing
          final index = _allItems.indexWhere((i) => i.id == item.id);
          if (index != -1) {
            _allItems[index] = result;
          }
        }
        _filterItems(); // refresh UI
      });
      _saveData(); // Auto-save
    }
  }

  void _confirmDelete(Item item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _deleteItem(item);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _deleteItem(Item item) {
    setState(() {
      _allItems.removeWhere((i) => i.id == item.id);
      _filterItems();
    });
    _saveData(); // Auto-save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9 - Local Storage'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          
          // List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredItems.isEmpty
                    ? const Center(child: Text('No items found.'))
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: ListTile(
                              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(item.description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _showAddEditDialog(item: item),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _confirmDelete(item),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Add new item',
      ),
    );
  }
}
