import 'package:calendar_ptmk/constant.dart';
import 'package:calendar_ptmk/pages/event_expanded_interface.dart/components/event_expanded_body.dart';
import 'package:flutter/material.dart';

class EventExpanded extends StatelessWidget {
  const EventExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kPrimaryColor,
              kWhiteColor,
            ],
          ),
        ),
        child: const EventExpandedBody(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      foregroundColor: kWhiteColor,
      backgroundColor: kPrimaryColor,
      title: const Text('Expanded Event'),
    );
  }
}
