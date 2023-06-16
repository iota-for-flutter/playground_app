import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../data/app_provider.dart';
import '../models/example_step.dart';
import '../theme/custom_overlay.dart';
import '../widgets/example_stepper_framework.dart';

class Example6 extends StatefulWidget {
  const Example6({super.key, required this.title});

  final String title;

  @override
  State<Example6> createState() => _Example6State();
}

class _Example6State extends State<Example6> {
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

    exampleSteps = [
      ExampleStep(
        'Step 1',
        """This example uses the last stored ADDRESS which you can see as Input. 

Click on the button "Execute" to process all steps to create a DID.

MAKE SURE THAT THERE WERE FUNDS REQUESTED FOR THIS SPECIFIC ADDRESS !!!""",
        _executeStepIndex0,
      ),
    ];

    exampleSteps[0].input =
        Provider.of<AppProvider>(context, listen: false).lastAddress;
  }

  void _executeStepIndex0() {
    _callFfiCreateDecentralizedIdentifier();
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

  Future<void> _callFfiCreateDecentralizedIdentifier() async {
    // To be replaced by API call to Rust library
    setState(() => exampleSteps[0].setOutput(
        'FAKE: Decentralized Identifier created. - Stronghold path: $_strongholdFilePath'));
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
