//
//Created by ESJsonFormatForMac on 18/09/27.
//

#import <Foundation/Foundation.h>

@class QCGetBlockTypeChildList;
@interface QCGetBlockType : NSObject

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSArray<QCGetBlockTypeChildList *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface QCGetBlockTypeChildList : QCBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger parentId;

@property (nonatomic, copy) NSString *updateId;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, assign) NSInteger seq;

@property (nonatomic, strong) NSArray<QCGetBlockTypeChildList *> *childList;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *createId;

@property (nonatomic, copy) NSString *createTime;

@end


