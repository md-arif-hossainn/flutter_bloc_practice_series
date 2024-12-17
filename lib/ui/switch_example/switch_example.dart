import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_count/bloc/switch/switch_event.dart';

import '../../bloc/switch/switch_bloc.dart';
import '../../bloc/switch/switch_state.dart';

class SwitchExampleBloc extends StatefulWidget {
  const SwitchExampleBloc({super.key});

  @override
  State<SwitchExampleBloc> createState() => _SwitchExampleBlocState();
}

class _SwitchExampleBlocState extends State<SwitchExampleBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example_Two'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notifications'),
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous,current) => previous.isSwitch != current.isSwitch,
                  builder: (context, state) {
                    print('notification');
                    return Switch(value: state.isSwitch, onChanged: (newValue) {
                      context.read<SwitchBloc>().add(
                          EnableOrDisableNotification());
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous,current) => previous.slider != current.slider,
              builder: (context, state) {
                print('slider');
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider),
                );
              },
            ),
            const SizedBox(height: 50),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous,current) => previous.slider != current.slider,
              builder: (context, state) {
                return Slider(value: state.slider, onChanged: (value) {
                  print(value);
                  print(state.slider);
                  context.read<SwitchBloc>().add(SliderEvent(slider: value));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

