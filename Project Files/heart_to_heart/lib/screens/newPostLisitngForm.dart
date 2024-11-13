import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewListing extends StatefulWidget
{
  const NewListing({super.key});

  @override
  State<NewListing> createState() => _NewListingState();
}

class _NewListingState extends State<NewListing>
{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Form(
          key: _formKey,
          child:
          Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                children:<Widget>
                [
                  CustomTextField(label: 'Title',),

                  SizedBox(height: 20,),

                  CustomTextField(label: 'Description',),

                  SizedBox(height: 20,),

                  DropDown(list: ['Distance', 'Old to New', 'New to Old'], fstEl: 'Sort By'),

                  SizedBox(height: 20,), // Add spacing between the dropdowns

                  DropDown(list: ['Fresh Food', 'Preserved Food'], fstEl: 'Fresh Food'),

                  SizedBox(height: 30,),

                  Expanded(child: InsertImage())

                ],
              )
          )
      ),
    );
  }
}



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
    fstEl = widget.fstEl;

    // Ensure the initial dropdownValue exists in the list
    // If it doesn't exist, set it to the first item in the list
    if (!list.contains(fstEl))
    {
      dropdownValue = list.first;
    }
    else
    {
      dropdownValue = fstEl;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration
      (
        border: Border.all
        (
          color: Colors.teal,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),

      child: DropdownButton
      (
        isExpanded: true,
        value: dropdownValue,

        items: list.map<DropdownMenuItem<String>>((String value)
        {
          return DropdownMenuItem<String>
          (
            value: value,
            child: Text(value),
          );
        }).toList(),

        onChanged: (String? newVal)
        {
          setState(()
          {
            dropdownValue = newVal!;
          });
        }
      ),


    );
  }
}



class InsertImage extends StatefulWidget
{
  const InsertImage({super.key});

  @override
  State<InsertImage> createState() => _InsertImageState();
}

class _InsertImageState extends State<InsertImage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children:
        [
          DottedBorder(
            color: Colors.teal,
            dashPattern: [30, 10],
            strokeWidth: 7,
            borderType: BorderType.RRect, // Use rounded rectangle
            radius: Radius.circular(30),
            child: Container(
              height: 200,
              width: 400,
              color: Colors.transparent,
            )
          )
        ],
      ),
    );
  }
}


class DottedBorderPainter extends CustomPainter
{
  @override
  void paint(Canvas canvas, Size size)
  {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;  // Thickness of the dash

    double dashWidth = 10.0; // Width of each dash
    double dashSpace = 5.0;  // Space between dashes

    // Draw dashed top border
    double startX = 0.0;
    while (startX < size.width)
    {
      // Draw dash
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace; // Move to the next dash position
    }

    // Draw dashed bottom border
    startX = 0.0;
    while (startX < size.width)
    {
      // Draw dash
      canvas.drawLine(Offset(startX, size.height), Offset(startX + dashWidth, size.height), paint);
      startX += dashWidth + dashSpace; // Move to the next dash position
    }

    // Draw dashed left border
    double startY = 0.0;
    while (startY < size.height)
    {
      // Draw dash on the left
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace; // Move to the next dash position
    }

    // Draw dashed right border
    startY = 0.0;
    while (startY < size.height)
    {
      // Draw dash on the right
      canvas.drawLine(Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += dashWidth + dashSpace; // Move to the next dash position
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)
  {
    return false;
  }
}


class CustomTextField extends StatefulWidget
{
  final String label;

  CustomTextField({required this.label});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
{
  FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  @override
  void initState()
  {
    super.initState();
    _controller = TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose()
  {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {}); // Update the widget when focus changes
  }

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,

      decoration: InputDecoration(
        labelText: widget.label,
        hintText: 'Enter ${widget.label}',
        border: OutlineInputBorder(),

        enabledBorder: OutlineInputBorder
        (
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),

        focusedBorder: OutlineInputBorder
        (
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),

        labelStyle: TextStyle
        (
          color: _focusNode.hasFocus ? Colors.teal : Colors.black,
        ),

        errorBorder: OutlineInputBorder
        (
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),

        focusedErrorBorder: OutlineInputBorder
        (
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: (value)
      {
        if (value == null || value.isEmpty)
        {
          return 'Please fill the ${widget.label} field.';
        }
        return null;
      },
    );
  }
}