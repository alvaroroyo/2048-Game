//
//  UIColor+BLHexColor.h
//  ilusia
//
//  Created by ivanfervar on 14/5/15.
//  Copyright (c) 2015 Grupo Ancana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BLHexColor)

/*!
 * @discussion Convert a hexadecimal color to UIColor
 * @param hexString hexadecimal string
 * @param alpha the alpha color
 * @return UIColor
 * @warning Te hex string start with '#'
 */
+(instancetype)colorWithHex:(NSString *)hexString andAlpha:(CGFloat)alpha;


@end
