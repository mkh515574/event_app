import 'package:event_app/core/utils/app_assets.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/core/utils/firebase_utils.dart';
import 'package:event_app/core/utils/widgets/custom_button.dart';
import 'package:event_app/core/utils/widgets/custom_text_form_filed.dart';
import 'package:event_app/features/events/create_event/widgets/date_or_time_view_item.dart';
import 'package:event_app/features/events/model/event_model.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/app_language_provider.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../core/utils/events_assets.dart';
import '../../home/view/widgets/tap_view_item.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isFormSubmitted = false;

  String formattedDate = '';
  String formattedTime = '';
  late String imageUrl;
  late List<Map<String, IconData>> categories;

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    categories = [
      {appLocalizations.sports: Icons.directions_bike},
      {appLocalizations.gaming: Icons.videogame_asset},
      {appLocalizations.work_shop: Icons.build},
      {appLocalizations.meeting: Icons.meeting_room},
      {appLocalizations.holiday: Icons.beach_access},
      {appLocalizations.birthday: Icons.cake},
      {appLocalizations.eating: Icons.restaurant},
      {appLocalizations.book_club: Icons.book},
      {appLocalizations.exhibition: Icons.museum},
    ];
    final appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
      listen: false,
    );

    var themeMode = appLanguageProvider.isDark();
    imageUrl = EventAssets.getImage(
      categories[selectedIndex].keys.first,
      themeMode,
    );

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    bool isDark = appLanguageProvider.isDark();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          appLocalizations.create_event,
          style: AppTextStyle.bold20primaryLight,
        ),
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
                        borderColor: selectedIndex == index
                            ? isDark
                                  ? AppColors.backgroundDarkColor
                                  : AppColors.primaryLightColor
                            : AppColors.primaryLightColor,
                        iconColor: selectedIndex == index
                            ? (isDark
                                  ? AppColors.backgroundDarkColor
                                  : AppColors.backgroundLightColor)
                            : AppColors.primaryLightColor,

                        backgroundColor: selectedIndex == index
                            ? AppColors.primaryLightColor
                            : (isDark
                                  ? AppColors.backgroundDarkColor
                                  : AppColors.whiteColor),
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

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Title",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextFormFiled(
                      controller: titleController,
                      prefixIcon: Icons.edit_note_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event title';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event description';
                        }
                        return null;
                      },
                      hintText: "Event Description",
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateOrTimeViewItem(
                    label: formattedDate.isEmpty
                        ? "Choose Date"
                        : formattedDate,
                    icon: Icons.calendar_today_outlined,
                    title: "Event Date",
                    isEmpty: isFormSubmitted && formattedDate.isEmpty,
                    error: "Please enter event date",
                    onPressed: () async {
                      final date = await showDatePickerView();
                      if (date.isNotEmpty) {
                        setState(() {
                          formattedDate = date;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateOrTimeViewItem(
                    label: formattedTime.isEmpty
                        ? "Choose Time"
                        : formattedTime,
                    icon: Icons.access_time_outlined,
                    title: "Event Time",
                    onPressed: () async {
                      final time = await showTimePickerView(context);
                      if (time.isNotEmpty) {
                        setState(() {
                          formattedTime = time;
                        });
                      }
                    },
                    isEmpty: isFormSubmitted && formattedTime.isEmpty,
                    error: "Please enter event time",
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Text("Location", style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: height * 0.01),

              CustomButton(
                onPressed: () {
                  // todo: Implement location selection
                },
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
                      child: SvgPicture.asset(AppAssets.vector),
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
              CustomButton(onPressed: addEvent, title: "Add Event"),
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

  Future<String> showTimePickerView(context) async {
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

  void addEvent() {
    setState(() {
      isFormSubmitted = true;
    });

    if (formKey.currentState!.validate() &&
        formattedDate.isNotEmpty &&
        formattedTime.isNotEmpty) {
      EventModel eventModel = EventModel(
        title: titleController.text,
        imagePath: imageUrl,
        timeOfDay: formattedTime,
        description: descriptionController.text,
        categoryName: categories[selectedIndex].keys.first,
        date: DateFormat('dd/MM/yyyy').parse(formattedDate),
      );
      FireBaseUtils.addEvent(eventModel)
          .then((value) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Event Created Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor:AppColors.primaryLightColor,
                textColor: Colors.white,
                fontSize: 16.0
            );


          })
          .timeout(
            Duration(milliseconds: 500),
            onTimeout: () {
              Fluttertoast.showToast(
                  msg: "Event Created Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.primaryLightColor,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
          );
    }
  }
}
