
import 'package:event_app/core/utils/app_assets.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/widgets/custom_button.dart';
import 'package:event_app/core/utils/widgets/custom_text_form_filed.dart';
import 'package:event_app/features/create_event/widgets/date_or_time_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/providers/app_language_provider.dart';
import '../../core/utils/app_text_style.dart';
import '../../core/utils/events_assets.dart';
import '../home/view/widgets/tap_view_item.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final List<Map<String, IconData>> categories = [
    {'Sports': Icons.directions_bike},
    {'Gaming': Icons.videogame_asset},
    {'WorkShop': Icons.build},
    {'Meeting': Icons.meeting_room},
    {'Holiday': Icons.beach_access},
    {'Birthday': Icons.cake},
    {'Eating': Icons.restaurant},
    {'Book Club': Icons.book},
    {'Exhibition': Icons.museum},
  ];

  String formattedDate = '';
  String formattedTime = '';

  @override
  Widget build(BuildContext context) {
    final appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
      listen: false,
    );

    var themeMode = appLanguageProvider.isDark();
    final imageUrl = EventAssets.getImage(
      categories[selectedIndex].keys.first,
      themeMode,
    );

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Create Event", style: AppTextStyle.bold20primaryLight),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primaryLightColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),

                child: Image.asset(
                  imageUrl,
                  height: height * 0.25,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.047,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: TapViewItem(
                        label: categories[index].keys.first,
                        icon: categories[index].values.first,
                        isSelected: selectedIndex == index,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: 9,
                ),
              ),

              SizedBox(height: height * 0.02),
              Text("Title", style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: height * 0.01),
              CustomTextFormFiled(
                controller: titleController,
                prefixIcon: Icons.edit_note_outlined,
                hintText: "Event Title",
              ),
              SizedBox(height: height * 0.01),
              Text(
                "Description",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: height * 0.01),
              CustomTextFormFiled(
                controller: descriptionController,
                maxLines: 4,
                hintText: "Event Description",
              ),
              SizedBox(height: height * 0.02),
              DateOrTimeViewItem(
                label: formattedDate.isEmpty ? "Choose Date" : formattedDate,
                icon: Icons.calendar_month,
                title: "Event Date",
                onPressed: () async {
                  final date = await showDatePickerView();
                  if (date.isNotEmpty) {
                    setState(() {
                      formattedDate = date;
                    });
                  }
                },
              ),
              DateOrTimeViewItem(
                label: formattedTime.isEmpty? "Choose Time" : formattedTime,
                icon: Icons.access_time,
                title: "Event Time",
                onPressed: ()async {
                  final time = await showTimePickerView();
                  if (time.isNotEmpty) {
                    setState(() {
                      formattedTime = time;
                    });
                  }
                },
              ),
              SizedBox(height: height * 0.02),
              Text("Location", style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: height * 0.01),

              CustomButton(
                onPressed: ()  {},
                hasIcons: true,
                widget: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SvgPicture.asset(AppAssets.mapIcon),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "Choose Event Location",
                      style: AppTextStyle.medium20primaryLight.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primaryLightColor,
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).canvasColor,
              ),
              SizedBox(height: height * 0.02),
              CustomButton(onPressed: () {}, title: "Add Event"),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> showDatePickerView() async {
    DateTime? selectedDate;

    selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (selectedDate == null) {
      return '';
    } else {
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

      return formattedDate;
    }
  }
  Future<String> showTimePickerView() async {
    TimeOfDay? selectedTime;
    selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime == null) {
      return '';
    } else {
      String formattedTime = selectedTime.format(context);
      return formattedTime;
    }

  }
}
