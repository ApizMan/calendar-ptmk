import 'dart:convert';

import 'package:calendar_ptmk/constant.dart';
import 'package:calendar_ptmk/models/expanded_event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventExpandedBody extends StatefulWidget {
  const EventExpandedBody({super.key});

  @override
  State<EventExpandedBody> createState() => _EventExpandedBodyState();
}

class _EventExpandedBodyState extends State<EventExpandedBody> {
  bool _isShow = false;
  List<ExpandedEventModel> model = [];

  @override
  void initState() {
    super.initState();
    loadEventData().then((events) {
      setState(() {
        model = events;
      });
    });
  }

  Future<List<ExpandedEventModel>> loadEventData() async {
    const String filePath = 'assets/json/expanded-data.json';
    final String jsonString = await rootBundle.loadString(filePath);

    final List<dynamic> jsonList = json.decode(jsonString);
    final List<ExpandedEventModel> events =
        jsonList.map((json) => ExpandedEventModel.fromJson(json)).toList();

    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total Leave Application: ${model.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: kPrimaryColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: _buildContent(context, index),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: kGreyColor,
          child: Icon(
            Icons.person,
            size: 30,
            color: kWhiteColor,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model[index].name!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'REF ID: ${model[index].refId!}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'APPLY DATE: ${model[index].applyDate!}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'LEAVE TYPE: ${model[index].leaveType!}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'DATE LEAVE FROM ${model[index].dateFrom!} TO ${model[index].dateTo!}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'TOTAL DAY(S): ${model[index].totalDays!}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'LEAVE REASON: ${model[index].leaveReason!}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 10.0,
              ),
              if (model[index].leaveType == 'Unrecorded Leave')
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(kPrimaryColor),
                          ),
                          child: const Text(
                            'Approve',
                            style: TextStyle(color: kWhiteColor),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        if (_isShow == false)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isShow = !_isShow;
                              });
                            },
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(kRedColor),
                            ),
                            child: const Text(
                              'Reject',
                              style: TextStyle(color: kWhiteColor),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                      visible: _isShow,
                      child: Column(
                        children: [
                          const TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: kWhiteColor,
                              labelText: 'Please Insert Something',
                              hintText: 'Reason',
                              hintStyle: TextStyle(color: kGreyColor),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kGreyColor, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          kWhiteColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: kPrimaryColor),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isShow = !_isShow;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          kWhiteColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: kRedColor),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: kRedColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(kPrimaryColor),
                      ),
                      child: const Text(
                        'Approve Cancel Leave',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
