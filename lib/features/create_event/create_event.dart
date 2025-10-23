import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/images_manager.dart';
import 'package:evently/core/widgets/custom_tab_bar.dart';
import 'package:evently/core/widgets/custom_text_button.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late CategoryModel selectedCategory=CategoryModel.categories(context)[0];

  @override
  Widget build(BuildContext context) {
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
                keyboardType: TextInputType.visiblePassword,
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
                maxLines: 4,
                keyboardType: TextInputType.visiblePassword,
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
                  Text(AppLocalizations.of(context)!.event_date,style: Theme.of(context).textTheme.bodySmall,),
                  Spacer(),
                  CustomTextButton(text: AppLocalizations.of(context)!.choose_date, onTap: (){})
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Icon(Icons.watch_later_outlined),
                  Text(AppLocalizations.of(context)!.event_time,style: Theme.of(context).textTheme.bodySmall,),
                  Spacer(),
                  CustomTextButton(text: AppLocalizations.of(context)!.choose_time, onTap: (){})
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                  child: ElevatedButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.add_event))
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
