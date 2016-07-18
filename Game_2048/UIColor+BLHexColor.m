//
//  UIColor+BLHexColor.m
//  ilusia
//
//  Created by ivanfervar on 14/5/15.
//  Copyright (c) 2015 Grupo Ancana. All rights reserved.
//

#import "UIColor+BLHexColor.h"

@implementation UIColor (BLHexColor)

+(instancetype)colorWithHex:(NSString *)hexString andAlpha:(CGFloat)alpha
{
    NSString *red = [hexString substringWithRange:NSMakeRange(1, 2)];
    NSString *green = [hexString substringWithRange:NSMakeRange(3, 2)];
    NSString *blue = [hexString substringWithRange:NSMakeRange(5, 2)];
    
    unsigned redInt;
    unsigned greenInt;
    unsigned blueInt;
    
    NSScanner *redScanner = [NSScanner scannerWithString:red];
    NSScanner *greenScanner = [NSScanner scannerWithString:green];
    NSScanner *blueScanner = [NSScanner scannerWithString:blue];
    
    [redScanner scanHexInt:&redInt];
    [greenScanner scanHexInt:&greenInt];
    [blueScanner scanHexInt:&blueInt];
    
    return [UIColor colorWithRed:redInt/255.0 green:greenInt/255.0 blue:blueInt/255.0 alpha:alpha];
    
}

@end
