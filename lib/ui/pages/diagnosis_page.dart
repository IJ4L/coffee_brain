import 'package:coffe_brain/cubit/naive_bayes/naive_bayes_proces_cubit.dart';
import 'package:coffe_brain/cubit/select_gejala_cubit.dart';
import 'package:coffe_brain/shared/string.dart';
import 'package:coffe_brain/shared/theme.dart';
import 'package:coffe_brain/ui/util/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Diagnosisscreen extends StatelessWidget {
  const Diagnosisscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final naiveCubit = context.read<NaiveBayesProcesCubit>();
    final selectEvent = context.read<SelectGejalaCubit>();
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_outlined, color: kBlackColor),
        ),
        actions: [
          BlocConsumer<NaiveBayesProcesCubit, NaiveBayesProcesState>(
            listener: (context, state) {
              if (state is NaiveBayesProcesFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Pilih Gejala !! (1 sampai 4)',
                      style: cocolateTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    backgroundColor: kPrimaryColor,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(milliseconds: 1500),
                  ),
                );
              }

              if (state is NaiveBayesProcesLoaded) {
                Navigator.pushNamed(context, '/diagnosis-value');
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () =>
                    naiveCubit.onPredict(convertData(selectEvent.state)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: SvgPicture.asset(
                    'assets/icons/ico_science.svg',
                    width: 20.r,
                    height: 20.r,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 10.h),
        child: Column(
          children: [
            Container(
              height: 48.h,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
              ),
              child: Center(
                child: Text(
                  'Gejala Penyakit Kopi',
                  style: cocolateTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return BlocBuilder<SelectGejalaCubit, List<int>>(
                    builder: (context, state) {
                      final isSelected = state.contains(index);
                      return GestureDetector(
                        onTap: () => isSelected != true
                            ? selectEvent.select(index)
                            : selectEvent.unselect(index),
                        child: Container(
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected ? kGreenColor : kPrimaryColor,
                                offset: const Offset(0, 2),
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text('${index + 1}.', style: blackTextStyle),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  gejala[index],
                                  style: blackTextStyle,
                                ),
                              ),
                              isSelected != false
                                  ? SvgPicture.asset(
                                      'assets/icons/ico_succses.svg',
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (_, index) => SizedBox(height: 16.h),
                itemCount: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}




//081527029703