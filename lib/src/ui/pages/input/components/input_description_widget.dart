import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';

class InputDescriptionWidget extends StatelessWidget {
  const InputDescriptionWidget({
    super.key,
    required TextEditingController descriptionController,
    this.onChanged,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Description',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(width: 8),
              const Text(
                '(Optional)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: kGrayColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Write here...',
                border: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
