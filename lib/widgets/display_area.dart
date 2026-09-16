import 'package:currency_calculator/constants.dart';
import 'package:currency_calculator/cubits/display_area_cubit/display_area_cubit.dart';
import 'package:currency_calculator/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The area that the operations and the result appear in
class DisplayArea extends StatelessWidget {
  const DisplayArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayAreaCubit, DisplayAreaState>(
      builder: (context, state) {
        return SizedBox(
          height: 120, //TODO: make responsive
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (state.result.isNotEmpty)
                CustomText(
                  // top grey line
                  text: state.typedValue,
                  fontSize: 24,
                  textColor: kSecondaryColor,
                ),
              CustomText(
                // main cyan line
                text: state.result.isNotEmpty ? state.result : state.typedValue,
                fontSize: 28,
                textColor: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        );
      },
    );
  }
}
