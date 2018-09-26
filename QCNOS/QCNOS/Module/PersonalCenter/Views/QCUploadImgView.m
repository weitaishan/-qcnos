//
//  QCUploadImgView.m
//  honeyKnow
//
//  Created by AlbertWei on 2018/5/24.
//  Copyright © 2018年 AlexiChen. All rights reserved.
//

#import "QCUploadImgView.h"
#import "QCUploadImgCell.h"
#import "QCUploadDefalutCell.h"
@interface QCUploadImgView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TZImagePickerControllerDelegate>


@end

static NSString * const QCUploadImgCellId = @"QCUploadImgCellId";
static NSString * const QCUploadDefalutCellId = @"QCUploadDefalutCellId";

@implementation QCUploadImgView{
    
    BOOL _isVideo;
}


- (instancetype)initWithImgArr:(NSMutableArray *)imgArr assets:(NSArray *)assets isVideo:(BOOL)isVideo
{
    self = [super init];
    if (self) {
        self.imgArr = imgArr;
        _isVideo= isVideo;
        if (self.imgArr.count == 0) {

            self.imgArr = @[].mutableCopy;
//            [self.imgArr addObject:[UIImage imageNamed:@"btn_add_edit"]];

        }
        self.assets = assets;
        [self initView];
    }
    return self;
}


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initView];
//    }
//    return self;
//}

- (void)initView{
    
    
    [self addSubview:self.collectionView];
    
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.minimumInteritemSpacing = 0;//列距
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QCUploadImgCell class]) bundle:nil] forCellWithReuseIdentifier:QCUploadImgCellId];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QCUploadDefalutCell class]) bundle:nil] forCellWithReuseIdentifier:QCUploadDefalutCellId];

        
    }
    
    return _collectionView;
    
}


#pragma mark - UICollectionViewDelegate/DataSource/FlowLayout

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imgArr.count + (_isVideo ? 2 : 1);

}


//元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (SCREEN_WIDTH - 60) / 3.f;
    
    return CGSizeMake( width,width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 20, 10, 20);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.imgArr.count) {
        
        
        QCUploadDefalutCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:QCUploadDefalutCellId forIndexPath:indexPath];
        
        cell.userInteractionEnabled = YES;
        
        return cell;
        
    }
    
    
    QCUploadImgCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:QCUploadImgCellId forIndexPath:indexPath];
    
    cell.userInteractionEnabled = YES;
    
    cell.imgView.image = self.imgArr[indexPath.row];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

            //上传图片
//    if (8 - self.imgArr.count) {
//
//        [[WTSAlertViewTools shareInstance] showAlert:@"提示" message:@"您最多只能上传9张照片哦~" cancelTitle:nil titleArray:nil viewController:self confirm:^(NSInteger buttonTag){
//
//
//        }];
//
//    }else{
    
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//        imagePickerVc.naviBgColor = [UIColor whiteColor];
//        imagePickerVc.naviTitleColor = kNormalTextOneColor;
//        imagePickerVc.barItemTextColor = kTextNorColor;
//        imagePickerVc.isStatusBarDefault = YES;
//        imagePickerVc.takePictureImageName = @"takePicture.png";
//        imagePickerVc.photoSelImageName = @"customer_yixuan";
//        imagePickerVc.photoDefImageName = @"pro_sch_manger_gouxuankuang";
//        imagePickerVc.photoNumberIconImageName = @"photo_number_icon.png";
//        imagePickerVc.photoPreviewOriginDefImageName = @"preview_original_def.png";
//        imagePickerVc.photoOriginDefImageName = @"photo_original_def.png";
//        imagePickerVc.photoOriginSelImageName = @"photo_original_sel.png";
//        imagePickerVc.doneBtnTitleStr = @"上传";
//        imagePickerVc.oKButtonTitleColorNormal = [UIColor whiteColor];
//        imagePickerVc.oKButtonTitleColorDisabled = [UIColor whiteColor];
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
    
        imagePickerVc.selectedAssets = self.assets.mutableCopy;

    
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            
            self.assets = assets;
            [self.imgArr removeAllObjects];
            [self.imgArr addObjectsFromArray:photos];
            
//            if (self.imgArr.count < 8) {
//
//                [self.imgArr addObject:[UIImage imageNamed:@"btn_add_edit"]];
//            }
            
            if (_reloadBlock) {
                
                _reloadBlock(self.imgArr, self.assets);
            }
            
            
        }];
        
        [APP_DELEGATE().getCurrentVC presentViewController:imagePickerVc animated:YES completion:nil];
        
//    }
    
}


-(void)layoutSubviews{
    
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.left.bottom.right.equalTo(self);

        
    }];
}

@end
