import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemFormDialog extends StatefulWidget {
  final Item? itemToEdit;

  const ItemFormDialog({Key? key, this.itemToEdit}) : super(key: key);

  @override
  _ItemFormDialogState createState() => _ItemFormDialogState();
}

class _ItemFormDialogState extends State<ItemFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.itemToEdit?.name ?? '');
    _descController = TextEditingController(text: widget.itemToEdit?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final desc = _descController.text.trim();
      
      final newItem = Item(
        id: widget.itemToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        description: desc,
      );
      
      Navigator.pop(context, newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.itemToEdit != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Item' : 'Add New Item'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Save Changes' : 'Add'),
        ),
      ],
    );
  }
}
