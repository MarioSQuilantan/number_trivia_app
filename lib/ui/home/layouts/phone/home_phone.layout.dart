import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/values/constants.dart';

import '../../../../features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class HomePhoneLayout extends StatelessWidget {
  const HomePhoneLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home phone'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0,
          ),
          shrinkWrap: true,
          children: <Widget>[
            const Center(
              child: Text(
                'Get a random number trivia',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is NumberTriviaIsLoading) {
                    return const CircularProgressIndicator();
                  }

                  if (state is NumberTriviaHasData) {
                    return Text(
                      key: HomePhoneLayoutKeys.numberTriviaData,
                      state.numberTrivia.text,
                      style: const TextStyle(fontSize: 18),
                    );
                  }

                  if (state is NumberTriviaHasError) {
                    return Text(
                      state.message,
                      style: const TextStyle(fontSize: 18),
                    );
                  }
                  return const Text(
                    'Generate a number trivia',
                    style: TextStyle(fontSize: 18),
                  );
                },
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  key: HomePhoneLayoutKeys.getRandomNumberTrivia,
                  onPressed: () => BlocProvider.of<NumberTriviaBloc>(context).add(GetRandomNumberTriviaEvent()),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Get a random number trivia'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
