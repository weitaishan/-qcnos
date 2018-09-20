//
//  EnumApi.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/9.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#ifndef EnumApi_h
#define EnumApi_h

/**
 *  定义状态值
 */
typedef NS_ENUM(NSUInteger, Status) {
    /**
     *  失败
     */
    StatusFailure = 0,
    /**
     *  成功
     */
    StatusSuccess
};

/**
 *  性别
 */
typedef NS_ENUM(NSUInteger, Sex) {
    /**
     *  男
     */
    SexMale = 1,
    /**
     *  女
     */
    SexFemale
};
/**
 *  关联机构
 */
typedef NS_ENUM(NSUInteger, RelationStatus) {
    /**
     *  未关联
     */
    RelationStatusNot = 0,
    /**
     *  已关联
     */
    RelationStatusAlready
};
/**
 *  身份证正反面
 */
typedef NS_ENUM(NSUInteger, IdCardStatus) {
    /**
     *  身份证正面
     */
    IdCardStatusFront = 302,
    /**
     *  身份证反面
     */
    IdCardStatusBack
};
/**
 *  用户状态
 */
typedef NS_ENUM(NSUInteger, UserStatus) {
    /**
     *  待认证,用户注册成功但未提交实名认证
     */
    UserStatusWaitAuthentication = 1,
    /**
     *  认证未通过,后台管理实名认证审核未通过
     */
    UserStatusAuthenticationFail,
    /**
     *  已认证,后台管理通过实名认证审核
     */
    UserStatusAuthenticationSuccess,
    /**
     *  已关闭,后台管理操作“关闭”用户
     */
    UserStatusAuthenticationClose,
    /**
     *  认证中,用户提交实名认证后，但后台未操作审核
     */
    UserStatusAuthenticationing
};
/**
 *  验证码业务逻辑判断
 */
typedef NS_ENUM(NSUInteger, VcfCode) {
    
    VcfCodeRegister = 0,
    VcfCodeOther,
    VcfCodeRegisterTwo,
    VcfCodeChangePassword,
    VcfCodeChangePasswordTwo,
    VcfCodeLogin
};


/**
 *  待办计划状态
 */
typedef NS_ENUM(NSUInteger, GtasksPlanStatus) {
    
    GtasksPlanStatusGtasks = 0,
    GtasksPlanStatusComplete,
    GtasksPlanStatusTimeOut
    
};

/**
 *  上传文件
 */
typedef NS_ENUM(NSUInteger, UploadType) {
    
    UploadTypeAvatar = 0,
    UploadTypeAudio,
    UploadTypeVideo,
    UploadTypeFile,
    UploadTypeImg
};

/**
 *  客户问题类型
 */
typedef NS_ENUM(NSUInteger, CustomerQuestionType) {
    
    /**
     *  投诉
     */
    CustomerQuestionTypeComplaints = 0,
    /**
     *  问题
     */
    CustomerQuestionTypeQuestion,
    /**
     *  反馈
     */
    CustomerQuestionTypeFeedback,
    /**
     *  售后
     */
    CustomerQuestionTypeAftermarket,
    
    /**
     *  是否有新公告
     */
    CustomerQuestionTypeAnnouncement
};

/**
 *  客户处理问题状态
 */
typedef NS_ENUM(NSUInteger, CustomerQuestionStatus) {
    
    CustomerQuestionStatusUnprocessed = 0,
    CustomerQuestionStatusProcessed
    
};

/**
 *  方向
 */
typedef NS_OPTIONS(NSUInteger, Direction) {
    /**
     *  无
     */
    DirectionNone   = 1 << 0,
    /**
     *  上
     */
    DirectionTop    = 1 << 1,
    /**
     *  左
     */
    DirectionLeft   = 1 << 2,
    /**
     *  下
     */
    DirectionBottom = 1 << 3,
    /**
     *  右
     */
    DirectionRight  = 1 << 4
};

/**
 *  添加客户类型
 */
typedef NS_ENUM(NSUInteger, AddCustomerType) {
    
    AddCustomerTypeNone = 0,
    /**
     *  职业类型
     */
    AddCustomerTypeJobType,
    /**
     *  所在方位
     */
    AddCustomerTypeLocation,
    /**
     *  楼盘小区
     */
    AddCustomerTypeSubareaFillin,
    /**
     *  客户分类
     */
    AddCustomerTypeCustomerClassify,
    /**
     *  客户来源
     */
    AddCustomerTypeCustomerSource,
    /**
     *  优先级别
     */
    AddCustomerTypePriority,
    /**
     *  装修类型
     */
    AddCustomerTypeFitmentType,
    /**
     *  行业了解度
     */
    AddCustomerTypeIndustryUnderstanding,
    /**
     *  客户关注
     */
    AddCustomerTypeConcern,
    /**
     *  房屋类型
     */
    AddCustomerTypeHouseType,
    /**
     *  户型
     */
    AddCustomerTypeHomeType,
    /**
     *  居住状况
     */
    AddCustomerTypeResidentialSituation,
    /**
     *  装修风格
     */
    AddCustomerTypeDecorationStyle
};


/**
 *  报价类型
 */
typedef NS_ENUM(NSUInteger, QuotationType) {
    /**
     *  报价分类
     */
    QuotationTypeMain = 1,
    /**
     *  报价建材分类
     */
    QuotationTypeBuilding,
    /**
     *  报价详情
     */
    QuotationTypeDetails
    
};

/**
 *  工作文件类型
 */
typedef NS_ENUM(NSUInteger, WorkFileType) {
    /**
     *  图片上传
     */
    WorkFileTypeUploadImg = 1,
    /**
     *  图片审核
     */
    WorkFileTypeAuditImg,
    /**
     *  文档上传
     */
    WorkFileTypeUploadDocument,
    /**
     *  文档审核
     */
    WorkFileTypeAuditDocument
    
};

/**
 *  工作任务类型
 */
typedef NS_ENUM(NSUInteger, WorkTaskType) {
    /**
     *  其他
     */
    WorkTaskTypeOther = 0,
    /**
     *  图片上传
     */
    WorkTaskTypeImgUpload,
    /**
     *  文档上传
     */
    WorkTaskTypeFileUpload,
    /**
     *  客户服务计划
     */
    WorkTaskTypeCustomerServicePlan
    
};


#endif /* EnumApi_h */
