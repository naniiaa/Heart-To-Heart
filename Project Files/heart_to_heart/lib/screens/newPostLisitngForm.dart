import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<_InsertImageState> _insertImageKey = GlobalKey<_InsertImageState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String sortByValue = 'Sort By';
  String foodTypeValue = 'Fresh Food';

  void submitForm() async
  {
    if (_formKey.currentState?.validate() ?? false)
    {
      try
      {
        String title = titleController.text;
        String description = descriptionController.text;

        await _firestore.collection('lisitngs').add(
        {
          'title': title,
          'description': description,
          'type': sortByValue,
          'category': foodTypeValue,
          'image': 'heehee'
        });

        // After submission, clear the form
        titleController.clear();
        descriptionController.clear();

        setState(()
        {
          sortByValue = 'Sort By'; // reset dropdowns to default
          foodTypeValue = 'Type Of';
        });

      }
      catch(e)
      {
        print("Error adding user: $e");
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Submitted!')));
      // if (_insertImageKey.currentState?.isImageSelected() ?? false)
      // {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Submitted!')));
      // }
      // else
      // {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image.')));
      // }
    }
    else
    {
      // If the form is not valid (some fields are not
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields correctly.')));
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>
                [
                  SizedBox(height: 20),

                  InkWell(
                    onTap: ()
                    {
                      Navigator.pop(context);
                    }, // Splash color over image
                    child: Ink.image
                    (
                      fit: BoxFit.cover, // Fixes border issues
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(15.0),
                      image: const AssetImage('assets/images/heart.png'),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children:
                    [
                        IconButton(
                            onPressed: ()
                            {
                              Navigator.pop(context);
                            }, icon: Icon(Icons.close,size: 35,)
                        ),
                      SizedBox(width: 38),
                      Text("Post New Listing", style: TextStyle(fontSize: 30),)
                    ],
                  ),

                  SizedBox(height: 20),

                  CustomTextField(label: 'Title', controller: titleController),

                  SizedBox(height: 20),

                  CustomTextField(label: 'Description', controller: descriptionController),

                  SizedBox(height: 20),

                  DropDown(
                    //type
                      list: ['Fresh food', 'Preserved food', 'Dairy', 'Grains', 'Pseudo grains', 'Legumes', 'Ancient Grains', 'Processed food', 'Furniture', 'Clothing' , 'Toys' ,  'Appliances', 'Repair', 'Clean Up' , 'Healthcare', 'Odd jobs'],
                      fstEl: sortByValue,
                      onChanged: (newVal)
                      {
                        setState(()
                        {
                          sortByValue = newVal;
                        });
                      }
                  ),

                  SizedBox(height: 20),

                  DropDown(
                    //category
                      list: ['Item Donations','Food Donations','Service Donations'],
                      fstEl: foodTypeValue,
                      onChanged: (newVal)
                      {
                        setState(()
                        {
                          foodTypeValue = newVal;
                        }
                        );
                      }
                  ),

                  SizedBox(height: 20),

                  Expanded(child: InsertImage()),

                  SizedBox(height: 20),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                        onPressed: ()
                        {
                          submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            width: 3.0,  // Use a valid width here
                            color: Colors.teal,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                        ),
                        child: Text("Submit", style: TextStyle(color: Colors.blue),)
                    ),
                  )

                ],
              )
          )
      ),
    );
  }
}

class DropDown extends StatefulWidget
{
  const DropDown(
  {
    super.key,
    required this.list,
    required this.fstEl,
    required this.onChanged,
  });

  final List<String> list;
  final String fstEl;
  final ValueChanged<String> onChanged;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown>
{
  late String dropdownValue;

  @override
  void initState()
  {
    super.initState();
    dropdownValue = widget.fstEl;

    // You can uncomment the following lines to ensure the initial value
    //is present in the list (if you need this logic):

    if (!widget.list.contains(dropdownValue))
    {
      dropdownValue = widget.list.first;  // Default to the first item
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
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue, // This is the current selected value
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newVal) {
          if (newVal != null) {
            setState(() {
              dropdownValue = newVal;  // Update the internal state and UI
            });
            widget.onChanged(newVal);  // Notify the parent with the new value
          }
        },
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
  File? image;
  late ImagePicker imagePicker;

  isImageSelected()
  {
    if(this.image == null)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select or capture an image.')));
      return false;
    }
    return true;
  }

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

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        width: 3.0,  // Use a valid width here
                        color: Colors.teal,
                      ),
                    ),
                    child: Text('Browse/Capture', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
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
  final TextEditingController controller;

  CustomTextField({required this.label, required this.controller});

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
      controller: widget.controller,
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
          String message = 'Please fill the ${widget.label} field.';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          return message;
        }
          return null;
      },
    );
  }
}
