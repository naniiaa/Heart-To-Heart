import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  // InkWell(
  // onTap: ()
  // {
  // //Text('main page');
  // }, // Splash color over image
  // child: Ink.image(
  // fit: BoxFit.cover, // Fixes border issues
  // width: 50,
  // height: 50,
  // padding: const EdgeInsets.all(15.0),
  // image: const AssetImage('assets/images/heart.png'),
  // ),
  // ),

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>
                [
                  CustomTextField(label: 'Title'),

                  SizedBox(height: 20),

                  CustomTextField(label: 'Description'),

                  SizedBox(height: 20),

                  DropDown(list: ['Distance', 'Old to New', 'New to Old'], fstEl: 'Sort By'),

                  SizedBox(height: 20),

                  DropDown(list: ['Fresh Food', 'Preserved Food'],fstEl: 'Fresh Food'),

                  SizedBox(height: 30),

                  Expanded(child: InsertImage()),

                  SizedBox(height: 30),

                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: double.infinity,
                              color: Colors.teal
                          )
                      ),
                      child: Text("Submit"))
                ],
              ))),
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
    } else {
      dropdownValue = fstEl;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.teal,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          items: list.map<DropdownMenuItem<String>>((String value)
          {
            return DropdownMenuItem<String>(
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
          }),
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
  File? image;
  late ImagePicker imagePicker;

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  chooseImage() async
  {
    XFile? selectedImg = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selectedImg != null)
    {
      image = File(selectedImg.path);
      setState(()
      {
        image;
      });
    }
  }

  captureImage() async
  {
    XFile? selectedImg = await imagePicker.pickImage(source: ImageSource.camera);
    if(selectedImg != null)
    {
      image = File(selectedImg.path);
      setState(()
      {
        image;
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DottedBorder(
            color: Colors.teal,
            dashPattern: [30, 10],
            strokeWidth: 7,
            borderType: BorderType.RRect, // Use rounded rectangle
            radius: Radius.circular(30),
            child: Container(
              height: 222,
              width: 400,
              child: Column(
                children: <Widget>
                [
                  SizedBox(height: 10),

                  image == null? Icon(Icons.image_outlined, size: 80): Image.file(image!),

                  Text("Choose a file or capture a picture", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),

                  Text("JPEG, PNG, PDG formats up to 50MB", style: TextStyle(color: Colors.grey)),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: ()
                    {
                      chooseImage();
                    },
                    onLongPress: ()
                    {
                      captureImage();
                    },
                    child: Text('Browse/Capture'),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
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

  void _onFocusChange()
  {
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
        ),
        labelStyle: TextStyle(
          color: _focusNode.hasFocus ? Colors.teal : Colors.black,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
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
