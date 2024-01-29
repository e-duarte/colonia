import 'package:flutter/material.dart';

class _HorizontalCheckListState extends State<HorizontalCheckList> {
  List<bool>? checks;
  List<String> values = [];

  @override
  void initState() {
    super.initState();
    checks = List.generate(widget.options.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  List.generate(widget.options.length, (index) => index).map(
                (i) {
                  return _buildOption(widget.options[i], checks![i], i);
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String text, bool check, int index) {
    return Row(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Option(
            text: text,
            check: check,
            onTap: (value) => _handleList(value, index),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  void _handleList(value, index) {
    setState(() {
      if (widget.oneSeletion) {
        checks = List.generate(widget.options.length, (index) => false);
        checks![index] = value;

        values = [widget.options[index]];
        widget.onChanged([...values]);
      } else {
        checks![index] = value;

        // values.add();
        if (value) {
          values.add(widget.options[index]);
        } else {
          values.removeWhere((option) => option == widget.options[index]);
        }
        widget.onChanged([...values]);
      }
    });
  }
}

class HorizontalCheckList extends StatefulWidget {
  const HorizontalCheckList({
    super.key,
    required this.title,
    required this.options,
    required this.oneSeletion,
    required this.onChanged,
  });

  final String title;
  final List<String> options;
  final bool oneSeletion;
  final void Function(List<String>) onChanged;

  @override
  State<HorizontalCheckList> createState() => _HorizontalCheckListState();
}

class Option extends StatelessWidget {
  const Option({
    super.key,
    required this.text,
    required this.check,
    required this.onTap,
  });

  final String text;
  final bool check;
  final void Function(bool value) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.01,
      width: MediaQuery.of(context).size.width * 0.06,
      child: OutlinedButton(
        onPressed: () => onTap(!check),
        style: OutlinedButton.styleFrom(
          backgroundColor: check ? Colors.green : null,
        ),
        child: Text(
          text,
          style: TextStyle(color: check ? Colors.white : Colors.green),
        ),
      ),
    );
  }
}
