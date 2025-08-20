import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logistics_app/features/requests/domain/usecases/get_categories.dart';
import 'package:logistics_app/features/requests/presentation/bloc/user_requests_bloc.dart';
import 'package:logistics_app/features/requests/presentation/pages/request_detailed_page.dart';
import '../../../../core/storage/app_storage.dart';
import '../../../../core/theme/app_colours.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../../../injection.dart' as di;
import '../../domain/entities/request_entity.dart';
import '../../domain/usecases/create_request_usecase.dart';
import '../bloc/categories_with_types/categories_bloc.dart';
import '../bloc/create_request/create_request_bloc.dart';
import '../widgets/request_list_item_widget.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All',
    'Pending',
    'In Progress',
    'Completed',
    'Rejected',
  ];

  List<RequestEntity> _filterRequests(List<RequestEntity> requests) {
    if (_selectedFilter == 'All') return requests;
    return requests.where((req) => req.status == _selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppColors.statusPending;
      case 'In Progress':
        return AppColors.statusProcessing;
      case 'Completed':
        return AppColors.statusCompleted;
      case 'Rejected':
        return AppColors.statusRejected;
      default:
        return AppColors.accentDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
      di.sl<UserRequestsBloc>()..add(
        GetUserRequestsEvent(userId: AppStorage().getUserId() ?? 00),
      ),
  child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Requests',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<UserRequestsBloc, UserRequestsState>(
        builder: (context, state) {
          if (state is LoadingUserRequestsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedUserRequestsState) {
            final filteredRequests = _filterRequests(state.requests);
            return filteredRequests.isEmpty
                ? const Center(child: Text('No requests found'))
                : RefreshIndicator(child: ListView.separated(
              itemCount: filteredRequests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final request = filteredRequests[index];
                return RequestListItem(
                  id: request.requestId.toString(),
                  name: request.requestSequence,
                  type: request.requestsType.typeName,
                  category: request.categoryEntity.categoryName,
                  status: request.status,
                  statusColor: _getStatusColor(request.status),
                  date: DateFormat(
                    'dd MMM yyyy',
                  ).format(request.dateTime),
                  priority: request.requestPriority.priorityType,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestDetailedPage(
                          userId: AppStorage().getUserId() ?? 0,
                          isCreationMode: false,
                          request: request, // Pass the selected request
                        ),
                      ),
                    );
                  },
                );
              },
            ), onRefresh: () => _onRefresh(context),);
          } else {
            return const Center(child: Text('Load requests'));
          }
        },
        listener: (context, state) {
          if (state is ErrorUserRequestsState) {
            SnackBarMessage().showSnackBar(
              message: state.message,
              backgroundColor: AppColors.error,
              context: context,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => di.sl<CreateRequestBloc>()),
                  BlocProvider(create: (context) => di.sl<CategoriesBloc>()),
                ],
                child: RequestDetailedPage(
                  userId: AppStorage().getUserId() ?? 0,
                  isCreationMode: true,
                ),
              ),
            ),
          );

          if (result == true) {
            // Refresh requests list
            context.read<UserRequestsBloc>().add(
              GetUserRequestsEvent(userId: AppStorage().getUserId() ?? 0),
            );
          }
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    ),
);
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<UserRequestsBloc>(context).add(RefreshUserRequestsEvent(userId:AppStorage().getUserId() ?? 0 ));
  }
}
