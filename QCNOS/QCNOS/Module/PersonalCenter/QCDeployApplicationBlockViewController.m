//
//  QCDeployApplicationBlockViewController.m
//  QCNOS
//
//  Created by 魏太山 on 2018/9/27.
//  Copyright © 2018年 量芯集团有限公司. All rights reserved.
//

#import "QCDeployApplicationBlockViewController.h"
#import "QCPersonSelectNodeView.h"
#import "QCPersonSelectNodeListCell.h"
@interface QCDeployApplicationBlockViewController ()

@property (nonatomic, strong) NSMutableArray* listArr;

@property (nonatomic,strong) NSMutableArray<NSNumber *> *flagArray;

@end

static NSString * const QCPersonSelectNodeListCellId = @"QCPersonSelectNodeListCellId";

@implementation QCDeployApplicationBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseInfo];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBaseInfo{
    
    self.navigationItem.title = @"配置应用区块";
    
    [self addTableViewWithGroupFrame:CGRectMake(0,0, SCREEN_WIDTH,SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCPersonSelectNodeListCell class]) bundle:nil] forCellReuseIdentifier:QCPersonSelectNodeListCellId];
    
}


#pragma mark - 数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([self.flagArray[section] isEqualToNumber:@0]){
        
        return 0;
        
    }
    
//    return self.listArr[section].materialList.count;
    
    
    return 2;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    QCPersonSelectNodeListCell * cell = [tableView dequeueReusableCellWithIdentifier:QCPersonSelectNodeListCellId forIndexPath:indexPath];
    
    return cell;
    
}


#pragma mark - 代理方法

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.tableView.estimatedRowHeight = 120;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    return self.tableView.rowHeight;
    
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 60;
    
    
}

//底部视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 16)];
    
    view.backgroundColor =  kBgColor;
    
    return view;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
     UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 60)];

    
    QCPersonSelectNodeView* nodeView = [[NSBundle mainBundle] loadNibNamed:@"QCPersonSelectNodeView" owner:self options:nil].firstObject;
    
    [view addSubview:nodeView];
    [nodeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(view);
    }];

    
    return nodeView;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
}
- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath

{
    
    return UITableViewCellEditingStyleDelete & UITableViewCellEditingStyleInsert;
    
}
#pragma mark - 懒加载
-(NSMutableArray *)listArr{
    
    if (!_listArr) {
        
        _listArr = @[].mutableCopy;
    }
    
    return _listArr;
}


-(NSMutableArray *)flagArray{
    
    if (!_flagArray) {
        
        _flagArray = @[].mutableCopy;
    }
    
    return _flagArray;
}


@end
