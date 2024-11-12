import 'package:flutter/material.dart';


class DropDown extends StatefulWidget
{
  const DropDown({super.key, required this.list, required this.fstEl});

  final List<String> list;
  final String fstEl;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown>
{
  late List<String> list;
  late String fstEl;
  late String dropdownValue;

  @override
  void initState()
  {
    super.initState();
    list = widget.list;
    //fstEl = widget.fstEl;
    dropdownValue = widget.fstEl;
  }

  @override
  Widget build(BuildContext context)
  {
    return DropdownMenu<String>
    (
      initialSelection: list.first,
      onSelected: (String? value)
      {
        // This is called when the user selects an item.
        setState(()
        {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value)
      {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}