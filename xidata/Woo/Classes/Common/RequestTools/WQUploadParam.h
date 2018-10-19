//
//  WQUploadParam.h
//  zjcmcc
//
//  Created by 彩讯 on 17/1/12.
//  Copyright © 2017年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WQUploadParam : NSObject
/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSData *data1;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *name1;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
