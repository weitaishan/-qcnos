//
//  QCDefine.h
//  QCNOS
//
//  Created by 量芯集团有限公司 on 2018/9/3.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#ifndef QCDefine_h
#define QCDefine_h

#define k_Color_Main_Navigation   RGBA(76, 129, 239, 1)      // 导航栏颜色
#define Color_Cell_Separator    RGBA(230,230,230,1)         //#e6e6e6

#define k_Color_Text_Main    RGBA(76, 129, 239, 1)         //主调色

#define k_Color_title    RGBA(52, 52, 52, 1)         //titleColor


#define SERVER_SCHEME_AND_HOST_AND_PORT [QCServerSwitch serverSwith]

#define QCStringFormat(format, ...) [NSString stringWithFormat:format,##__VA_ARGS__]

#endif /* QCDefine_h */
