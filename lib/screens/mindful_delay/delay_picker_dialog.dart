import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mindful_delay_controller.dart';

class DelayPickerDialog extends StatefulWidget {
  final String packageName;
  final String appName;

  const DelayPickerDialog({
    super.key,
    required this.packageName,
    required this.appName,
  });

  @override
  State<DelayPickerDialog> createState() => _DelayPickerDialogState();
}

class _DelayPickerDialogState extends State<DelayPickerDialog> {
  late int value;
  bool isMinutes = true;

  late MindfulDelayController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<MindfulDelayController>();

    final rule = controller.getRule(widget.packageName);

    if (rule == null) {
      value = 1;
      isMinutes = true;
    } else {
      if (rule.delaySeconds >= 60) {
        value = (rule.delaySeconds ~/ 60).clamp(1, 60);
        isMinutes = true;
      } else {
        value = rule.delaySeconds.clamp(1, 59);
        isMinutes = false;
      }
    }
  }

  int get delaySeconds {
    if (isMinutes) {
      return value * 60;
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final rule = controller.getRule(widget.packageName);

    return AlertDialog(
      title: Text(widget.appName),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          const Text(
            "Mindful Delay",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [

              Expanded(
                child: DropdownButton<int>(
                  value: value,
                  isExpanded: true,
                  items: List.generate(
                    isMinutes ? 60 : 59,
                    (index) {

                      final number = index + 1;

                      return DropdownMenuItem(
                        value: number,
                        child: Text(number.toString()),
                      );
                    },
                  ),
                  onChanged: (v) {
                    if (v == null) return;

                    setState(() {
                      value = v;
                    });
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: DropdownButton<bool>(
                  value: isMinutes,
                  isExpanded: true,
                  items: const [

                    DropdownMenuItem(
                      value: false,
                      child: Text("Seconds"),
                    ),

                    DropdownMenuItem(
                      value: true,
                      child: Text("Minutes"),
                    ),
                  ],
                  onChanged: (v) {
                    if (v == null) return;

                    setState(() {
                      isMinutes = v;

                      if (isMinutes && value > 60) {
                        value = 60;
                      }

                      if (!isMinutes && value > 59) {
                        value = 59;
                      }
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (rule != null && rule.enabled)
            Column(
              children: [

                const Divider(),

                if (!rule.isDisableScheduled)
                  ElevatedButton.icon(
                    onPressed: () async {

                      await controller.scheduleDisable(
                        widget.packageName,
                      );

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.timer_off),
                    label: const Text(
                      "Schedule Turn Off (48 Hours)",
                    ),
                  ),

                if (rule.isDisableScheduled)
                  ElevatedButton.icon(
                    onPressed: () async {

                      await controller.cancelScheduledDisable(
                        widget.packageName,
                      );

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.restore),
                    label: const Text(
                      "Cancel Scheduled Turn Off",
                    ),
                  ),
              ],
            ),
        ],
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),

        FilledButton(
          onPressed: () async {

            await controller.setDelay(
              packageName: widget.packageName,
              delaySeconds: delaySeconds,
            );

            if (mounted) {
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}