import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../models/example_step.dart';
import '../theme/custom_overlay.dart';
import '../widgets/example_stepper_framework.dart';

class Example5 extends StatefulWidget {
  const Example5({super.key, required this.title});

  final String title;

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {
  // These variables belong to the state and are only initialized once,
  // in the initState method.
  late List<ExampleStep> exampleSteps;
  CustomOverlay customOverlay = CustomOverlay();

  //------------------------------------------------------------------------------
  String _strongholdFilePath = '';

  @override
  void initState() {
    super.initState();

    _getStrongholdFilePath();
    // platform = api.platform();
    // isRelease = api.rustReleaseMode();

    exampleSteps = [
      ExampleStep(
        'Step 1',
        """Please enter the ALIAS. 
Click on the button "Execute" to take over the input value and "Continue" to go to the next step.""",
        _executeStepIndex0,
      ),
      ExampleStep(
        'Step 2',
        """Click on the button "Execute" to check the balance for the Wallet Account Alias (see Input).      
        """,
        _executeStepIndex1,
      ),
    ];

    exampleSteps[0].input = 'Account_1';
    exampleSteps[0].setInputEditable(true);
  }

  void _executeStepIndex0() {
    setState(() {
      exampleSteps[0].setOutput(exampleSteps[0].input ?? '');
      exampleSteps[1].setInput(exampleSteps[0].output ?? '');
    });
  }

  void _executeStepIndex1() {
    _callFfiCheckBalance();
  }

  Future<void> _getStrongholdFilePath() async {
    final Directory appSupportDir = await getApplicationSupportDirectory();

    final Directory appSupportDirStrongholdFolder =
        Directory('${appSupportDir.path}/');
    setState(() {
      _strongholdFilePath = appSupportDirStrongholdFolder.path;
    });

    //print("_strongholdFilePath is $_strongholdFilePath");
  }

  Future<void> _callFfiCheckBalance() async {
    // To be replaced by API call to Rust library
    setState(() => exampleSteps[1].setOutput(
        'FAKE: Balanced checked. - Stronghold path: $_strongholdFilePath'));
  }

  //------------------------------------------------------------------------------
  @override
  void dispose() {
    customOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleStepperFramework(
      exampleSteps: exampleSteps,
    );
  }
}
