import 'package:bloom/Models/PlantsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../notifiers/userNotifier.dart';
import '../../services/authentification_firebase_service.dart';
import '../../services/plant_firebase_service.dart';

class ListItems extends StatefulWidget {
  final Plant plant;

  ListItems({Key ? key, required this.plant,}):super(key: key);
  @override
  State<ListItems> createState() => _ListItemsState();
}
class _ListItemsState extends State<ListItems>{

  @override
  void initState() {
    super.initState();
  }

  Widget _buildListItems(Plant root){
    return ListTile(
      title: Text(
        root.Plant_Name!,
        style: GoogleFonts.montserrat(
          color: Color(0xff585757),
        ),
      ),
      trailing: Checkbox(
        activeColor: Color(0xff8EC877),
        value: root.isSelected,
        onChanged: (value)=> setState(() {
          root.isSelected=value!;
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListItems(widget.plant);
  }
}
