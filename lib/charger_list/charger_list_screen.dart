import 'package:eve_demo/charger_list/widgets/charger_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/charger_list_bloc.dart';

class ChargerListScreen extends StatefulWidget {
  const ChargerListScreen({super.key});

  @override
  ChargerListScreenState createState() => ChargerListScreenState();
}

class ChargerListScreenState extends State<ChargerListScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ChargerListBloc>().add(LoadListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChargerListBloc, ChargerListState>(
        listener: (context, state) {
          if (state is ChargerListLoadingFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(padding: const EdgeInsets.all(16.0),
            child: (state is ChargerListLoadingFailedState) ?
            Center(child: ElevatedButton(onPressed: ()=>context.read<ChargerListBloc>().add(LoadListEvent()), child: const Text('Retry'))) : Column(
              children: [
                // Search bar
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search Charger',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    //context.read<ChargerListBloc>().add(SearchChargerEvent(query));
                  },
                ),
                // List or loading indicator based on state
                const SizedBox(height: 4,),
                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (state is ChargerListLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChargerListLoadingSuccessState) {
                        if (state.list.isEmpty) {
                          return const Center(child: Text('No chargers found.'));
                        }
                        return ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            final charger = state.list[index];
                            return Padding(padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(onTap: (){

                              },
                                child: chargerCard(charger),
                              ),
                            );
                          },
                        );
                      } else if (state is ChargerListLoadingFailedState) {
                        return const Center(child: Text('Failed to load chargers.'));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}