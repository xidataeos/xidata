//
//  NSMutableAttributedString+NilString.h
//  zjcmcc
//
//  Created by 周中广 on 15/1/4.
//  Copyright (c) 2015年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (NilString)

- (instancetype)initWithNotNilString:(NSString *)str;
- (instancetype)initWithNotNilString:(NSString *)str attributes:(NSDictionary *)attrs;
@end
