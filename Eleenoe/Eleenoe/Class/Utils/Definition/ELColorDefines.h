//
//  ELColorDefines.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#ifndef ELColorDefines_h
#define ELColorDefines_h

#define  UIColorRandom  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//Tabbar Color
#define   TabbarNormalColor     UIColorFromRGB(0xDDDDDD)
#define   TabbarHightColor      UIColorFromRGB(0x8EC31F)

//Page Color
#define  PageCurrentColor       UIColorFromRGB(0xFF758C)

//Main Color
#define MainThemColor           UIColorFromRGB(0x8EC31F)
#define MainLightThemColor      UIColorFromRGB(0xC3E282)
#define MainBackgroundColor     UIColorFromRGB(0xf4f4f4)
//Text Color
#define MainTitleColor          UIColorFromRGB(0x333333)
#define MainWhiteTitleColor     UIColorFromRGB(0xFFFFFF)
#define MainLightGrayTitleColor UIColorFromRGB(0x999999)
#define MainBlackTitleColor     UIColorFromRGB(0x333333)

//line Color
#define MainGrayBorderColor     UIColorFromRGB(0xE4E4E4)


//TableView Color
#define MainTableViewColor      UIColorFromRGB(0xF3F3F3)


#endif /* ELColorDefines_h */
