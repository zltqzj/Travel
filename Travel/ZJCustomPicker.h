//
//  ZJCustomPicker.h
//  Travel
//
//  Created by ZKR on 1/22/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
// 未完待续

#import <UIKit/UIKit.h>



/*!
  ZJActionSheetPickerSyleTextPicker  文字
  ZJActionSheetPickerSyleDatePicker  时间
 */
typedef NS_ENUM(NSUInteger, ZJActionSheetPickerSyle) {
    ZJCustomPickerSyleTextPicker,
    ZJCustomPickerSyleDatePicker,
};


@class ZJCustomPicker;

@protocol ZJPickerDelegate <NSObject>

-(void)actionSheetPickerView:(ZJCustomPicker*)picker didSelectTitles:(NSArray*)titles;

@optional
- (void)actionSheetPickerView:(ZJCustomPicker *)pickerView didChangeRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface ZJCustomPicker : UIView

@end
