import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/character/fav_characters_sort_type.dart';
import '../bloc/fav_characters_bloc.dart';
import '../cubit/sort_characters_cubit.dart';

class SortDropdownMenu extends StatelessWidget {
  const SortDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCharactersSortingCubit, FavCharactersSortingState>(
      builder: (context, sortState) {
        SortType currentSortType = SortType.defaultOrder;

        if (sortState is FavCharactersSortingLoaded) {
          currentSortType = sortState.sortType;
        }

        return DropdownButton<SortType>(
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.sort),
          ),
          items:
              SortType.values.map((SortType value) {
                return DropdownMenuItem<SortType>(
                  value: value,
                  child: Text(
                    value.toString().split('.').last,
                    style: TextStyle(
                      fontWeight:
                          value == currentSortType
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (SortType? newValue) {
            if (newValue != null) {
              context.read<FavCharactersSortingCubit>().sortCharacters(
                context.read<FavCharactersBloc>().state.favCharactersList,
                newValue,
              );
            }
          },
        );
      },
    );
  }
}
