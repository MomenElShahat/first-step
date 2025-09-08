import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dimens.dart';

class Gaps {
  const Gaps._();

  static Widget hGap4 = SizedBox(width: Dimens.dp4.w);
  static Widget hGap5 = SizedBox(width: Dimens.dp5.w);
  static Widget hGap8 = SizedBox(width: Dimens.dp8.w);
  static Widget hGap10 = SizedBox(width: Dimens.dp10.w);
  static Widget hGap12 = SizedBox(width: Dimens.dp12.w);
  static Widget hGap13 = SizedBox(width: Dimens.dp13.w);
  static Widget hGap14 = SizedBox(width: Dimens.dp14.w);
  static Widget hGap15 = SizedBox(width: Dimens.dp15.w);
  static Widget hGap16 = SizedBox(width: Dimens.dp16.w);
  static Widget hGap18 = SizedBox(width: Dimens.dp18.w);


  static Widget hGap20 = SizedBox(width: Dimens.dp20.w);
  static Widget hGap32 = SizedBox(width: Dimens.dp32.w);
  static Widget hGap40 = SizedBox(width: Dimens.dp40.w);
  static Widget hGap(int value) => SizedBox(width: value.w);

  static Widget vGap3 = SizedBox(height: Dimens.dp3.h);
  static Widget vGap4 = SizedBox(height: Dimens.dp4.h);
  static Widget vGap5 = SizedBox(height: Dimens.dp5.h);
  static Widget vGap8 = SizedBox(height: Dimens.dp8.h);
  static Widget vGap10 = SizedBox(height: Dimens.dp10.h);
  static Widget vGap12 = SizedBox(height: Dimens.dp12.h);
  static Widget vGap13 = SizedBox(height: Dimens.dp13.h);
  static Widget vGap14 = SizedBox(height: Dimens.dp14.h);
  static Widget vGap15 = SizedBox(height: Dimens.dp15.h);
  static Widget vGap16 = SizedBox(height: Dimens.dp16.h);
  static Widget vGap20 = SizedBox(height: Dimens.dp20.h);
  static Widget vGap24 = SizedBox(height: Dimens.dp24.h);
  static Widget vGap26 = SizedBox(height: Dimens.dp26.h);

  static Widget vGap32 = SizedBox(height: Dimens.dp32.h);
  static Widget vGap30 = SizedBox(height: Dimens.dp30.h);
  static Widget vGap38 = SizedBox(height: Dimens.dp38.h);
  static Widget vGap40 = SizedBox(height: Dimens.dp40.h);
  static Widget vGap44 = SizedBox(height: Dimens.dp44.h);
  static Widget vGap34 = SizedBox(height: Dimens.dp34.h);
  static Widget vGap48 = SizedBox(height: Dimens.dp48.h);

  static Widget vGap50 = SizedBox(height: Dimens.dp50.h);
  static Widget vGap60 = SizedBox(height: Dimens.dp60.h);

  static Widget vGap64 = SizedBox(height: Dimens.dp64.h);
  static Widget vGap77 = SizedBox(height: Dimens.dp77.h);
  static Widget vGap84 = SizedBox(height: Dimens.dp84.h);
  static Widget vGap128 = SizedBox(height: Dimens.dp128.h);
  static Widget vGap256 = SizedBox(height: Dimens.dp256.h);

  static Widget vGap(int value) => SizedBox(height: value.h);

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = Offstage(
    offstage: true,
    child: SizedBox.shrink(),
  );
}
