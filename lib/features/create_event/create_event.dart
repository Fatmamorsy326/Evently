import 'package:evently/core/UIUtils.dart';
import 'package:evently/core/extensions/date_ex.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/resources/validation.dart';
import 'package:evently/core/widgets/custom_tab_bar.dart';
import 'package:evently/core/widgets/custom_text_button.dart';
import 'package:evently/features/create_event/location_picker_map.dart';
import 'package:evently/firebase/firebase_service.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late CategoryModel selectedCategory=CategoryModel.categories(context)[0];
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime selectedDateTime = DateTime.now();
  TimeOfDay pickedTimeTemp = TimeOfDay.now();
  String locationAddress = "Choose Event Location";
  LatLng? selectedLocation;
  @override
  void initState() {
    titleController=TextEditingController();
    descriptionController=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_event,style: TextStyle(fontWeight: FontWeight.w400,color: ColorsManager.blue,fontSize: 22.sp),),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  REdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16.r),
                  child: Image.asset(selectedCategory.image),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTabBar(categories: CategoryModel.categories(context), selectedBgColor: ColorsManager.blue, selectedFgColor:ColorsManager.white, unselectedBgColor: ColorsManager.white, unselectedFgColor: ColorsManager.blue,itemOnClicked: (category) {
                  selectedCategory=category;
                  setState(() {

                  });
                },),
                SizedBox(
                  height: 16.h,
                ),
                Text(AppLocalizations.of(context)!.title,style: Theme.of(context).textTheme.bodySmall,),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  validator: (value) => Validation.titleValidation(value, context),
                  controller:titleController ,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.edit_note),
                    hintText: AppLocalizations.of(context)!.event_title
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(AppLocalizations.of(context)!.description,style: Theme.of(context).textTheme.bodySmall,),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  validator: (value) => Validation.descriptionValidation(value, context),
                  controller: descriptionController,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.event_description,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Text(selectedDateTime.formattedDate,style: Theme.of(context).textTheme.bodySmall,),
                    Spacer(),
                    CustomTextButton(text: AppLocalizations.of(context)!.choose_date, onTap: (){
                      _selectEventDate();
                    })
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    Text(selectedDateTime.formattedTime,style: Theme.of(context).textTheme.bodySmall,),
                    Spacer(),
                    CustomTextButton(text: AppLocalizations.of(context)!.choose_time, onTap: (){
                      _selectEventTime();
                    })
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                InkWell(
                  onTap: () {
                    _chooseLocation();
                  },
                  child: Container(
                    padding: REdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: ColorsManager.blue,width: 1)
                    ),
                    child: Row(
                      children: [
                        Card(
                          color: ColorsManager.blue,
                          child: Padding(
                            padding:  REdgeInsets.symmetric(vertical:12 ,horizontal: 12),
                            child: Icon(Icons.my_location,color: configProvider.isDark?ColorsManager.black:ColorsManager.white,),
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: Text(locationAddress,style: TextStyle(fontWeight: FontWeight.w500,color: ColorsManager.blue,fontSize: 16.sp)),

                        ),
                        Icon(Icons.arrow_forward_ios_sharp,color: ColorsManager.blue,size: 24.sp,),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      _createEvent();
                    }, child: Text(AppLocalizations.of(context)!.add_event))
                ),
                SizedBox(
                  height: 16.h,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectEventDate() async {
    selectedDateTime =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
            selectedDateTime;
    selectedDateTime = selectedDateTime.copyWith(hour: pickedTimeTemp.hour, minute: pickedTimeTemp.minute);

    setState(() {});
  }

  void _selectEventTime() async {
    pickedTimeTemp =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
            pickedTimeTemp;

    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTimeTemp.hour,
      minute: pickedTimeTemp.minute,
    );
    setState(() {});
  }



  Future<void> _createEvent() async {
    if(_formKey.currentState?.validate()== false)return;
    if (selectedLocation == null) {
      UIUtils.showMsg("Please select event location", ColorsManager.red);
      return;
    }
    EventModel event =EventModel(id: "", category: selectedCategory, title: titleController.text, description: descriptionController.text, date: selectedDateTime, latitude: 31.098899, longitude: 29.768523,creatorId:FirebaseAuth.instance.currentUser!.uid );
    UIUtils.showLoading(context);
    await FirebaseService.addEventToFirebase(event, context);
    UIUtils.hideLoading(context);
    UIUtils.showMsg("create event successfully", Colors.green);
    Navigator.pop(context);
  }

  Future<void> _chooseLocation() async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerMap(
          initialLocation: selectedLocation,
        ),
      ),
    );
    if (result != null) {
      setState(() async {
        selectedLocation = result;
        Placemark place = await getAddressFromLatLng(result.latitude, result.longitude);
        locationAddress="${place.country},${place.locality},${place.street}";
      });
    }
  }

  Future<Placemark> getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];
    print("Country: ${place.country}");
    print("City: ${place.locality}");
    print("Governorate: ${place.administrativeArea}");
    print("Street: ${place.street}");
    return place;
  }

}
