import 'package:bloc_arch/app/controller/something_controller.dart';
import 'package:bloc_arch/core/framework/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late SomethingController somethingController;

  bool isLoading = false;

  @override
  void initState() {
    somethingController = SomethingController();
    somethingController.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SomethingController>(
      create: (context) => somethingController,
      child: BlocConsumer<SomethingController, BaseState>(
        listener: (BuildContext context, state) {
          setState(() {
            isLoading = state is Loading;
          });
        },
        builder: (BuildContext context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: Stack(
              children: [
                if (state is Loading) const CircularProgressIndicator(),
                state is Error
                    ? Text(state.error.toString())
                    : const SizedBox(),
                if (state is Fetched<String>)
                  Text(
                    state.data,
                    style: const TextStyle(fontSize: 40),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
