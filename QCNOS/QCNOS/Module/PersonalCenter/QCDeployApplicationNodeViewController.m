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
@interface QCDeployApplicationNodeViewController ()

@property (nonatomic, strong) NSMutableArray *listArray;

@end


static NSString * const QCPersonNodeHeaderCellId = @"QCPersonNodeHeaderCellId";

static NSString * const QCPersonNodeListCellId = @"QCPersonNodeListCellId";

@implementation QCDeployApplicationNodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    [self setBaseInfo];
}

- (void)companyGetTypeListRequest {
    
    NSURLRequest *request = [NSURLRequest companyGetWithParameters:nil];
    [QCURLSessionManager dataTaskWithRequest:request successBlock:^(id responseObject) {
//        QCGetBlockType* model = [QCGetBlockType yy_modelWithJSON:responseObject];
//        [self.listArray removeAllObjects];
//        [self.listArray addObjectsFromArray:model.data];
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
    
    self.navigationItem.title = @"应用节点";
    
    [self addTableViewWithGroupFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonNodeHeaderCell class]) bundle:nil] forCellReuseIdentifier:QCPersonNodeHeaderCellId];
    
    
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
        
        QCPersonNodeHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonNodeHeaderCellId forIndexPath:indexPath];

        
        return cell;
    }
    QCPersonNodeListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonNodeListCellId forIndexPath:indexPath];
    return cell;
    
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
    
    if (indexPath.section == 0) {
     
        
        QCDeployApplicationBlockViewController* vc = [[QCDeployApplicationBlockViewController alloc] init];
        
        vc.type = 1;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
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
