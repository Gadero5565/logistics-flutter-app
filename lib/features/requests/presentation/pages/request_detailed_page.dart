import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../dashboard/domain/entities/dashboard_entity.dart';
import '../../domain/entities/category_with_types.dart';
import '../../domain/entities/create_request_entity.dart';
import '../../domain/entities/request_entity.dart';
import '../bloc/categories_with_types/categories_bloc.dart';
import '../bloc/create_request/create_request_bloc.dart';

class RequestDetailedPage extends StatefulWidget {
  final int userId;
  final bool isCreationMode;
  final RequestEntity? request;

  const RequestDetailedPage({
    required this.userId,
    this.isCreationMode = true,
    this.request, // Optional for view mode
  });

  @override
  _RequestDetailedPageState createState() => _RequestDetailedPageState();
}

class _RequestDetailedPageState extends State<RequestDetailedPage> {
  final _formKey = GlobalKey<FormState>();
  CreateRequestBloc? _createRequestBloc;
  late CategoriesBloc _categoriesBloc;
  List<CategoryWithTypesEntity> _categories = [];
  List<RequestsTypes> _filteredTypes = [];

  // Add this flag to track if we've initialized categories
  bool _isInitialCategorySet = false;

  // Form fields
  int? _categoryId;
  int? _typeId;
  String _requestText = '';
  String _priority = '0';

  @override
  void initState() {
    super.initState();
    // Only get bloc in creation mode
    if (widget.isCreationMode) {
      _createRequestBloc = BlocProvider.of<CreateRequestBloc>(context);
      BlocProvider.of<CategoriesBloc>(context).add(LoadCategoriesEvent());
    }
  }

  void _onCategoryChanged(int? categoryId) {
    setState(() {
      _categoryId = categoryId;
      _typeId = null;
      _filteredTypes = [];

      if (categoryId != null) {
        for (final cat in _categories) {
          if (cat.categoryId == categoryId) {
            _filteredTypes = cat.types;
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isCreationMode ? 'Create Request' : 'Request Details',
        ),
      ),
      body:
          widget.isCreationMode ? _buildCreationForm() : _buildRequestDetails(),
    );
  }

  Widget _buildCreationForm() {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesLoaded) {
          _categories = categoriesState.categories;

          // Only set initial category once
          if (!_isInitialCategorySet && _categories.isNotEmpty) {
            _isInitialCategorySet = true;

            // Schedule for next frame to avoid setState during build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onCategoryChanged(_categories.first.categoryId);
            });
          }
        }
        if (categoriesState is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return BlocConsumer<CreateRequestBloc, CreateRequestState>(
          listener: (context, state) {
            if (state is CreateRequestSuccess) {
              // Show success dialog
              _showSuccessDialog(context, state.createdRequest);
            }
            if (state is CreateRequestError) {
              _showErrorDialog(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is CreateRequestLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Category Selection
                    DropdownButtonFormField<int>(
                      value: _categoryId,
                      hint: Text('Select Category'),
                      items: _getCategoryItems(),
                      onChanged: _onCategoryChanged,
                      validator: (value) => value == null ? 'Required' : null,
                    ),

                    const SizedBox(height: 20),

                    // Type Selection
                    DropdownButtonFormField<int>(
                      value: _typeId,
                      hint: Text('Select Type'),
                      items: _getTypeItems(),
                      onChanged: (value) => setState(() => _typeId = value),
                      validator: (value) => value == null ? 'Required' : null,
                    ),

                    const SizedBox(height: 20),

                    // Request Text
                    TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Request Details',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                      onChanged: (value) => _requestText = value,
                    ),

                    const SizedBox(height: 20),

                    // Priority
                    DropdownButtonFormField<String>(
                      value: _priority,
                      items: const [
                        DropdownMenuItem(value: '0', child: Text('Normal')),
                        DropdownMenuItem(value: '1', child: Text('Low')),
                        DropdownMenuItem(value: '2', child: Text('High')),
                        DropdownMenuItem(value: '3', child: Text('Very High')),
                      ],
                      onChanged: (value) => setState(() => _priority = value!),
                      decoration: InputDecoration(labelText: 'Priority'),
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit Request'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRequestDetails() {
    final request = widget.request!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Request ID', request.requestId.toString()),
          _buildDetailRow('Request Sequence', request.requestSequence),
          _buildDetailRow('Type', request.requestsType.typeName),
          _buildDetailRow('Category', request.categoryEntity.categoryName),
          _buildDetailRow('Status', request.status),
          _buildDetailRow('Priority', request.requestPriority.priorityType),
          _buildDetailRow(
            'Date',
            DateFormat('dd MMM yyyy').format(request.dateTime),
          ),
          const SizedBox(height: 20),
          Text(
            'Request Details:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(request.requestText),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _getCategoryItems() {
    return _categories.map<DropdownMenuItem<int>>((category) {
      return DropdownMenuItem<int>(
        value: category.categoryId,
        child: Text(category.categoryName),
      );
    }).toList();
  }

  List<DropdownMenuItem<int>> _getTypeItems() {
    return _filteredTypes.map<DropdownMenuItem<int>>((type) {
      return DropdownMenuItem<int>(value: type.id, child: Text(type.typeName));
    }).toList();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _createRequestBloc != null) {
      final request = CreateRequestEntity(
        categoryId: _categoryId!,
        typeId: _typeId!,
        requestText: _requestText,
        priority: _priority,
      );

      _createRequestBloc!.add( // Use with null check
        CreateNewRequestEvent(userId: widget.userId, request: request),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, CreatedRequest createdRequest) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Request Created'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request ID: ${createdRequest.requestId}'),
                const SizedBox(height: 8),
                Text('Request Code: ${createdRequest.requestCode}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context, true); // Close entire page
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Request Failed'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
