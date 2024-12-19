import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_count/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_count/bloc/counter/counter_event.dart';
import 'package:flutter_bloc_count/bloc/counter/counter_state.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _counterBloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Counter App'),
          ),
          body:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<CounterBloc, CounterState>(
                  builder: (context,state){
                    print('observe state');
                    return Center(child: Text(state.counter.toString(),style: const TextStyle(fontSize: 60),));
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<CounterBloc, CounterState>(
                    buildWhen: (current, previous) => false,
                      builder: (context,state){
                        print('observe state');
                        return ElevatedButton(onPressed: (){
                          context.read<CounterBloc>().add(IncrementCounter());
                        }, child: const Text('Increment'));
                      }
                  ),
                  const SizedBox(width: 20,),
                  BlocBuilder<CounterBloc, CounterState>(
                      buildWhen: (current, previous) => false,
                      builder: (context,state){
                        print('observe state');
                        return ElevatedButton(onPressed: (){
                          context.read<CounterBloc>().add(DecrementCounter());
                        }, child: const Text('Decrement'));
                      }
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
}


///PREVIOUS IMPLEMENTATION WHERE USE GLOBAL BLOC
// class _CounterScreenState extends State<CounterScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Counter App'),
//       ),
//       body:  Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           BlocBuilder<CounterBloc, CounterState>(
//               builder: (context,state){
//                 print('observe state');
//                 return Center(child: Text(state.counter.toString(),style: const TextStyle(fontSize: 60),));
//               }
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(onPressed: (){
//                 context.read<CounterBloc>().add(IncrementCounter());
//               }, child: const Text('Increment')),
//               const SizedBox(width: 20,),
//               ElevatedButton(onPressed: (){
//                 context.read<CounterBloc>().add(DecrementCounter());
//               }, child: const Text('Decrement')),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
