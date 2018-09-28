//
//  QCDeployApplicationNodeViewController.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCDeployApplicationNodeViewController.h"
#import "QCPersonNodeHeaderCell.h"
#import "QCPersonNodeListCell.h"
#import "QCDeployApplicationBlockViewController.h"
#import "QCApplicaNodeList.h"
#import "QCPersonSelectNodeHeaderCell.h"
#import "QCGetBlockType.h"
@interface QCDeployApplicationNodeViewController ()

@property (nonatomic, strong) NSMutableArray *listArray;

@end


static NSString * const QCPersonNodeHeaderCellId = @"QCPersonNodeHeaderCellId";

static NSString * const QCPersonNodeListCellId = @"QCPersonNodeListCellId";

static NSString * const QCPersonSelectNodeHeaderCellId = @"QCPersonSelectNodeHeaderCellId";


@implementation QCDeployApplicationNodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    [self setBaseInfo];
    
    if (self.type == 3) {
        
        [self companyGetTypeListRequest];
        
    }else{
        
        QCApplicaNodeListData *model = [[QCApplicaNodeListData alloc] init];
        
        QCUserInformation* userInfo = [QCUserManager standardUserManager].user;
        
        
        model.logoPhoto = userInfo.headPhoto;
        model.name = userInfo.nickName ? : userInfo.realName;
        model.nodeName = @"承载管理";
        model.createTime = [userInfo.createTime longLongValue];
        model.creditCode = userInfo.idNumber;
        [self.listArray addObject:model];
        [self.listArray addObject:self.nodeListModel];

        [self.tableView reloadData];
        
    }
}

- (void)companyGetTypeListRequest {
    NSURLRequest *request = [NSURLRequest companyGetWithParameters:nil];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
        QCApplicaNodeList *model = [QCApplicaNodeList yy_modelWithJSON:responseObject];
        [self.listArray removeAllObjects];
        [self.listArray addObjectsFromArray:model.data];
        [self.tableView reloadData];
    } failBlock:^(QCError *error) {
        [YJProgressHUD showError:error.localizedDescription];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    
    [self addTableViewWithGroupFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    
    if (self.type == 1) {
        
        self.navigationItem.title = @"应用节点";

        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonNodeHeaderCell class]) bundle:nil] forCellReuseIdentifier:QCPersonNodeHeaderCellId];
        
    }else{
        
        if (self.type == 0) {
            
            self.navigationItem.title = @"选择归属主体";

        }else{
            
            self.navigationItem.title = @"确认信息";

        }
        
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonSelectNodeHeaderCell class]) bundle:nil] forCellReuseIdentifier:QCPersonSelectNodeHeaderCellId];

    }
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonNodeListCell class]) bundle:nil] forCellReuseIdentifier:QCPersonNodeListCellId];

}


#pragma mark - UITableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.listArray.count + 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (self.type == 1) {
            
            QCPersonNodeHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonNodeHeaderCellId forIndexPath:indexPath];
            
            return cell;

        }else{
            
            
            QCPersonSelectNodeHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonSelectNodeHeaderCellId forIndexPath:indexPath];
            cell.lbName.text = self.blockTypeModel.name;
            
            cell.lbRight.text = [NSString stringWithFormat:@"应用区块-%@ ﹥ ",self.parentName];
            cell.lbDesc.text = @"应用区块归属节点一经选择不可更改";
            cell.rightBtn.titleLabel.text = [NSString stringWithFormat:@"可选节点%ld节",self.listArray.count];
            
            return cell;

        }
        
    }
    QCPersonNodeListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonNodeListCellId forIndexPath:indexPath];
    QCApplicaNodeListData *model = self.listArray[indexPath.section - 1];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.logoPhoto]];
    cell.titleLabel.text = model.name;
    cell.nodeLabel.text = model.nodeName;
    cell.time1Label.text = [[NSDate dateStrFromCstampTime:model.createTime withDateFormat:@"YYYY.MM.dd HH:mm:ss"] stringByAppendingString:@"-创建"];
    cell.code.text = model.creditCode;
<<<<<<< HEAD
    cell.nodeWidth.constant = [QCDeployApplicationNodeViewController getWidthWithText:model.nodeName font:10.f];
=======
    if (self.type == 3 && indexPath.section == 1) {

        cell.nameLabel.text = @"公民身份证号码";
    }else{
        
        cell.nameLabel.text = @"统一社会信用代码";

    }
>>>>>>> e40ba6612cdb982ffed7cf3751854b864b2c6dd7
    
    return cell;
    
}

//根据高度度求宽度  text 计算的内容 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text
                       font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                               NSFontAttributeName:
                                                   [UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width + 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        return 73;

    }
    return 143;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 5;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return CGFLOAT_MIN;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor colorFromHexString:@"#f5f5f5"];
    
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type == 1) {
        
        if (indexPath.section == 0) {
            
            
            QCDeployApplicationBlockViewController* vc = [[QCDeployApplicationBlockViewController alloc] init];
            
            vc.type = 1;
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        
        if (indexPath.section > 0) {
            
            
            QCDeployApplicationNodeViewController* vc = [[QCDeployApplicationNodeViewController alloc] init];
            
            vc.type = 3;
            vc.parentName = self.parentName;
            vc.blockTypeModel = self.blockTypeModel;
            QCApplicaNodeListData *model = self.listArray[indexPath.section - 1];

            vc.nodeListModel = model;
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    

}

#pragma mark - 懒加载
-(NSMutableArray *)listArray{

    if (!_listArray) {

        _listArray = @[].mutableCopy;

    }

    return _listArray;

}

@end
