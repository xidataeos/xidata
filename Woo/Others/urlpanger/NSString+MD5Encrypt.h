//
//  NSString+MD5Encrypt.h
//  MOA
//
//  Created by  on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
 #import <UIKit/UIKit.h>

@interface NSString (md5)

- (NSString*)d5Encrypt;

- (NSString *)sha1;


@end
