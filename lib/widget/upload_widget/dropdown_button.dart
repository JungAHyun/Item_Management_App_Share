import 'package:flutter/material.dart';

class DropdownButtonState extends StatefulWidget {
  late var selectedList;
  late final seletedsort;

  DropdownButtonState(
    List<String> sortilst,
    String selectedsort, {
    super.key,
    this.selectedList,
    this.seletedsort,
  });

  @override
  State<DropdownButton> createState() =>
      _DropdownButtonState(selectedList, seletedsort);
}

class _DropdownButtonState extends State<DropdownButton> {
  late var selectedList;
  late final seletedsort;
  late String firtSelect;

  _DropdownButtonState(this.seletedsort, this.selectedList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 65,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 55, 61, 79),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton(
        alignment: Alignment.center,
        value: seletedsort,
        items: selectedList.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(
            () {
              seletedsort = value!;
            },
          );
        },
      ),
    );
  }
}
