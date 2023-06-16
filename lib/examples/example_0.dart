import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/custom_overlay.dart';
import '../data/app_provider.dart';
import '../models/example_step.dart';
import '../models/network.dart';
import '../widgets/example_stepper_framework.dart';

class Example0 extends StatefulWidget {
  const Example0({super.key, required this.title});

  final String title;

  @override
  State<Example0> createState() => _Example0State();
}

class _Example0State extends State<Example0> {
  // These variables belong to the state and are only initialized once,
  // in the initState method.
  late List<ExampleStep> exampleSteps;
  CustomOverlay customOverlay = CustomOverlay();

  //------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    exampleSteps = [
      ExampleStep(
        'Step 1',
        """To reset the stored Node Information, 
click on the button "Execute".""",
        _executeResetValues,
      ),
      ExampleStep(
        'Step 2',
        """Click on the button "Execute" to: 
- Create a client which will connect to the selected Network Node (see Input). 
- Read some Node Information.""",
        _executeStepIndex1,
      ),
    ];

    //exampleSteps[1].setInputEditable(true);
  }

  void _executeResetValues() {
    setState(() {
      Provider.of<AppProvider>(context, listen: false).nodeInfo = '';
      exampleSteps[1].setOutput('');
    });
  }

  void _executeStepIndex1() {
    _callFfiNodeInfo();
  }

  Future<void> _callFfiNodeInfo() async {
    String nodeUrl =
        Provider.of<AppProvider>(context, listen: false).currentNetwork.url;

    // To be replaced by API call to Rust library
    setState(() => exampleSteps[1]
        .setOutput('FAKE: node info called. - Node URL: $nodeUrl'));
  }

  //------------------------------------------------------------------------------
  @override
  void dispose() {
    customOverlay.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Network currentNetwork = Provider.of<AppProvider>(context).currentNetwork;
    exampleSteps[1].input =
        'Node: ${currentNetwork.name} \nURL:   ${currentNetwork.url}';
    return ExampleStepperFramework(
      exampleSteps: exampleSteps,
    );
  }
}
