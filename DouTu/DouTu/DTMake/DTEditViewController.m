//
//  DTEditViewController.m
//  DouTu
//
//  Created by 岳鹏飞 on 2017/3/20.
//  Copyright © 2017年 fly. All rights reserved.
//

#import "DTEditViewController.h"
#import "DTEditBtnView.h"
#import "DTEditFontView.h"
#import "MSColorSelectionView.h"

@interface DTEditViewController ()<DTEditBtnViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,MSColorViewDelegate>

{
    UIColor *_color;
}
@property (nonatomic, strong) UIView         *showBackView;
@property (nonatomic, strong) UIImageView    *showView;
@property (nonatomic, strong) UIButton       *qqBtn;
@property (nonatomic, strong) UIButton       *wxBtn;
@property (nonatomic, strong) UIButton       *collectBtn;
@property (nonatomic, strong) UIButton       *saveBtn;
@property (nonatomic, strong) UIView         *lineView;
@property (nonatomic, strong) DTEditBtnView  *editView;
@property (nonatomic, strong) UIScrollView   *editScrollView;
@property (nonatomic, strong) UITableView    *editTab;
@property (nonatomic, strong) UIView         *editFtColorView;
@property (nonatomic, strong) UIView         *editBgColorView;
@property (nonatomic, strong) UIView         *editFtView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@property (nonatomic, strong) UITextView     *wordView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger      pageNum;
@property (nonatomic, strong) NSIndexPath    *seleteIndexPath;
@property (nonatomic, strong) NSData         *picData;
@property (nonatomic, strong) DTBaseModel    *picModel;

@property (nonatomic, strong) MSColorSelectionView *bgColorSectionView;
@property (nonatomic, strong) MSColorSelectionView *ftColorSectionView;

@property (nonatomic, strong) DTEditFontView *fontView;

@end

static NSString *const kDTTagCollectionViewCell = @"kDTTagCollectionViewCell";

@implementation DTEditViewController

- (UIView *)showBackView
{
    if (!_showBackView) {
        _showBackView = [[UIView alloc] init];
        _showBackView.userInteractionEnabled = YES;
        _showBackView.backgroundColor = [UIColor whiteColor];
    }
    return _showBackView;
}
- (UIImageView *)showView
{
    if (!_showView) {
        _showView = [[UIImageView alloc] init];
        _showView.userInteractionEnabled = YES;
        _showView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showView;
}
- (UIButton *)qqBtn
{
    if (!_qqBtn) {
        _qqBtn = [UIButton dtFuncButtonWithTitle:nil image:[UIImage imageNamed:@"dt_logo_qq_black"] target:self action:@selector(sendPicToQQ)];
    }
    return _qqBtn;
}
- (UIButton *)wxBtn
{
    if (!_wxBtn) {
        _wxBtn = [UIButton dtFuncButtonWithTitle:nil image:[UIImage imageNamed:@"dt_logo_wx_black"] target:self action:@selector(sendPicToWx)];
    }
    return _wxBtn;
}
- (UIButton *)collectBtn
{
    if (!_collectBtn) {
        _collectBtn = [UIButton dtFuncButtonWithTitle:nil image:[UIImage imageNamed:@"dt_down_em"] target:self action:@selector(sendPicToWx)];
    }
    return _collectBtn;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton dtFuncButtonWithTitle:nil image:[UIImage imageNamed:@"dt_favor_normal"] target:self action:@selector(sendPicToWx)];
    }
    return _saveBtn;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(220, 220, 220);
    }
    return _lineView;
}
#pragma mark --------- 编辑面板
- (UIScrollView *)editScrollView
{
    if (!_editScrollView) {
        _editScrollView = [[UIScrollView alloc] init];
        _editScrollView.backgroundColor = [UIColor whiteColor];
        _editScrollView.contentSize = CGSizeMake(KSCREEN_WIDTH*4, 0);
    }
    return _editScrollView;
}
- (UITableView *)editTab
{
    if (!_editTab) {
        _editTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _editTab.delegate = self;
        _editTab.dataSource = self;
        [_editTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _editTab.tableFooterView = [[UIView alloc] init];
    }
    return _editTab;
}
- (UITextView *)wordView
{
    if (!_wordView) {
        _wordView = [[UITextView alloc] init];
        _wordView.scrollEnabled = NO;
        _wordView.font = [UIFont systemFontOfSize:20];
        _wordView.layer.cornerRadius = 2;
        _wordView.layer.borderWidth = 1.f;
        _wordView.layer.borderColor = DT_Base_EdgeColor.CGColor;
        _wordView.textContainerInset = UIEdgeInsetsMake(3, 3, 3, 3);
        _wordView.backgroundColor = [UIColor clearColor];
        _wordView.delegate = self;
    }
    return _wordView;
}
- (UIView *)editFtColorView
{
    if (!_editFtColorView) {
        _editFtColorView = [[UIView alloc] init];
    }
    return _editFtColorView;
}
- (UIView *)editBgColorView
{
    if (!_editBgColorView) {
        _editBgColorView = [[UIView alloc] init];
    }
    return _editBgColorView;
}
- (MSColorSelectionView *)bgColorSectionView
{
    if (!_bgColorSectionView) {
        _bgColorSectionView = [[MSColorSelectionView alloc] init];
        _bgColorSectionView.color = self.view.backgroundColor;
        _bgColorSectionView.delegate = self;
        [_bgColorSectionView setSelectedIndex:1 animated:NO];
    }
    return _bgColorSectionView;
}
- (MSColorSelectionView *)ftColorSectionView
{
    if (!_ftColorSectionView) {
        _ftColorSectionView = [[MSColorSelectionView alloc] init];
        _ftColorSectionView.color = self.view.backgroundColor;
        _ftColorSectionView.delegate = self;
        [_ftColorSectionView setSelectedIndex:0 animated:NO];
    }
    return _ftColorSectionView;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];;
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    [self setLeftBackNavItem];
    [self requestData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)setUpSubViews
{
    _color = DT_Base_EdgeColor;
    self.view.backgroundColor = RGB(240, 240, 240);
    _seleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CGFloat imgWidth = 230*DT_Base_Scale;
    CGFloat btnSpace = (KSCREEN_WIDTH-300*DT_Base_Scale-15)/2;
    CGFloat space    = (imgWidth-190)/3;
    self.showBackView.frame = CGRectMake(15, 15, imgWidth, imgWidth);
    self.showView.frame = CGRectMake(0, 0, imgWidth, imgWidth);
    self.qqBtn.frame = CGRectMake(self.showBackView.right+btnSpace, 50, 70*DT_Base_Scale, 35);
    self.wxBtn.frame = CGRectMake(self.qqBtn.left, self.qqBtn.bottom+space, 70*DT_Base_Scale, 35);
    self.collectBtn.frame = CGRectMake(self.qqBtn.left, self.wxBtn.bottom+space, 70*DT_Base_Scale, 35);
    self.saveBtn.frame = CGRectMake(self.qqBtn.left, self.collectBtn.bottom+space, 70*DT_Base_Scale, 35);
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.showBackView addGestureRecognizer:_pan];
    self.editView = [[DTEditBtnView alloc] initWithFrame:CGRectMake(0, self.showBackView.bottom+15, KSCREEN_WIDTH, 40)];
    self.editView.delegate = self;
    
    self.lineView.frame = CGRectMake(0, self.editView.bottom, KSCREEN_WIDTH, 1);
    
    CGFloat scrHeight = KSCREEN_HEIGHT-64-self.lineView.bottom;
    self.editScrollView.frame = CGRectMake(0, self.lineView.bottom, KSCREEN_WIDTH, scrHeight);
    self.editScrollView.delegate = self;
    self.editScrollView.pagingEnabled = YES;
    
    self.editTab.frame = CGRectMake(0, 0, KSCREEN_WIDTH, scrHeight);
    self.editFtColorView.frame = CGRectMake(KSCREEN_WIDTH, 0, KSCREEN_WIDTH, scrHeight);
    self.editBgColorView.frame = CGRectMake(KSCREEN_WIDTH*2, 0, KSCREEN_WIDTH, scrHeight);
    self.ftColorSectionView.frame = CGRectMake(0, 0, KSCREEN_WIDTH, scrHeight);
    self.bgColorSectionView.frame = CGRectMake(0, 0, scrHeight-100, scrHeight-100);
    self.bgColorSectionView.center = CGPointMake((KSCREEN_WIDTH-15-30)/2,scrHeight/2-50);
    CGFloat btnTop    = 20;
    CGFloat btnPace   = 10;
    CGFloat btnHeight = 15;
    CGFloat btnWidth  = 30;
    CGFloat btnLeft   = KSCREEN_WIDTH-15-btnWidth;
    for (int i=0; i<5; i++) {
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(btnLeft, btnTop, btnWidth, btnHeight);
        btnTop = btnTop+btnPace+btnHeight;
        bgBtn.tag = 10000+i;
        bgBtn.layer.masksToBounds = YES;
        bgBtn.layer.cornerRadius  = 5;
        [bgBtn addTarget:self action:@selector(bgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                bgBtn.backgroundColor = [UIColor blackColor];
                break;
            case 1:
                bgBtn.backgroundColor = [UIColor whiteColor];
                bgBtn.layer.borderColor = DT_Base_EdgeColor.CGColor;
                bgBtn.layer.borderWidth = 1;
                break;
            case 2:
                bgBtn.backgroundColor = [UIColor redColor];
                break;
            case 3:
                bgBtn.backgroundColor = [UIColor greenColor];
                break;
            case 4:
                bgBtn.backgroundColor = [UIColor blueColor];
                break;
            default:
                break;
        }
        [self.editBgColorView addSubview:bgBtn];
    }
    
    self.fontView = [[DTEditFontView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH*3, 0, KSCREEN_WIDTH, scrHeight)];
    [self.showBackView addSubview:self.showView];
    [self.showBackView addSubview:self.wordView];
    [self.view addSubview:self.showBackView];
    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.wxBtn];
    [self.view addSubview:self.collectBtn];
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.editView];
    [self.view addSubview:self.editScrollView];
    [self.editScrollView addSubview:self.editTab];
    
    [self.editScrollView addSubview:self.editBgColorView];
    [self.editScrollView addSubview:self.editFtColorView];
    [self.editScrollView addSubview:self.fontView];
    [self.editBgColorView addSubview:self.bgColorSectionView];
    [self.editFtColorView addSubview:self.ftColorSectionView];
}
#pragma mark ----------- setUpShowView
- (void)setUpShowView
{
    
    if ([_model.mediaType isEqualToNumber:@(0)]) {
        [self.showView sd_setImageWithURL:[NSURL safeURLWithString:_model.picPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    } else {
        [self.showView sd_setImageWithURL:[NSURL safeURLWithString:_model.gifPath] placeholderImage:[UIImage imageNamed:@"dt_loadingImg"]];
    }
    [self refreshWithWord:_model.name];
}
- (void)refreshWithWord:(NSString *)word
{
    self.wordView.size = CGSizeMake(self.showBackView.width-10, self.showBackView.height);
    self.wordView.text = word;
    CGSize newSize = [self.wordView sizeThatFits:CGSizeMake(self.showBackView.width-10,MAXFLOAT)];
    self.wordView.size = newSize;
    self.wordView.centerX = self.showBackView.width/2;
    self.wordView.bottom  = self.showBackView.height-5;
}
#pragma mark ----------- request
- (void)requestData
{
    if (!_model.itemId) {
        return;
    }
    [DTNetManger getDetailWithItemId:_model.itemId callBack:^(NSError *error, NSArray *response, DTBaseModel *detailModel) {
        
        if (!kArrayIsEmpty(response)) {
            _model = detailModel;
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:response];
            [self.editTab reloadData];
            [self setUpShowView];
        }
    }];
}
#pragma mark -----------  Tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.font = DT_Base_TitleFont;
    cell.textLabel.textColor = DT_Base_TitleColor;
    DTBaseModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.word;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DTBaseModel *model = self.dataSource[indexPath.row];
    [self refreshWithWord:model.word];
}
#pragma mark -----------  Action
- (void)sendPicToQQ
{
    if ([_model.mediaType isEqual:0]) {
        
    } else {
        NSArray *gifImg = self.showView.image.images;
        CGFloat durtion = [UIImage sd_animatedGifDurationWithData:[[SDImageCache sharedImageCache] diskImageDataBySearchingAllPathsForKey:_model.gifPath]]/gifImg.count;
        NSMutableArray *imgs = [[NSMutableArray alloc] init];
        for (UIImage *image in gifImg) {
            if (!kStringIsEmpty(_wordView.text)) {
                UIImage *img = [image addText:_wordView.text textRect:self.wordView.frame withAttributes:@{NSFontAttributeName:_wordView.font, NSForegroundColorAttributeName:_wordView.textColor, NSBackgroundColorAttributeName:_wordView.backgroundColor}];
                [imgs addObject:img];
            }
        }
        NSString *gifPath = [UIImage pathWithImages:imgs gifPath:_model.gifPath durtion:durtion];
        [DTSendPicManager sendImageMessageToQQ:[NSData dataWithContentsOfFile:gifPath]];
    }
}
- (void)sendPicToWx
{
 
    
    
    
    
}
#pragma mark ---------- EditView delegate
- (void)seleteBtnAtIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.3 animations:^{
       
        [self.editScrollView setContentOffset:CGPointMake(index*KSCREEN_WIDTH, 0)];
    }];
}
#pragma mark --------- Scroll  Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger i  = self.editScrollView.contentOffset.x / KSCREEN_WIDTH;
    [self.editView refreshSeleteBtnAtIndex:i];
}
#pragma mark ---------- PanAction
- (void)panAction:(UIPanGestureRecognizer *)panGes
{
    CGPoint transP = [panGes translationInView:self.showBackView];
    //标签允许的最小位置处x
    CGFloat minX = 0;
    //标签允许的最大位置处x
    CGFloat minY = 0;
    CGFloat maxX = self.showBackView.width-self.wordView.width;
    CGFloat maxY = self.showBackView.height-self.wordView.height;
    switch (panGes.state) {
            
        case UIGestureRecognizerStateChanged: {
            CGRect newFrame = self.wordView.frame;
            if (transP.x > 0 ) {
                newFrame.origin.x = MIN(maxX, transP.x + self.wordView.left);
            } else {
                newFrame.origin.x = MAX(minX, transP.x + self.wordView.left);
            }
            if (transP.y > 0) {
                newFrame.origin.y = MIN(maxY, transP.y + self.wordView.top);
            } else {
                newFrame.origin.y = MAX(minY, transP.y + self.wordView.top);
            }
            self.wordView.frame = newFrame;
            [panGes setTranslation:CGPointZero inView:self.showBackView];
        }
            break;
        default:
            break;
    }
}
#pragma mark ------ textView Delegate
-(void)textViewDidChange:(UITextView *)textView {
    CGSize newSize = [self.wordView sizeThatFits:CGSizeMake(self.showBackView.width-10,MAXFLOAT)];
    self.wordView.size = newSize;
    self.wordView.centerX = self.showBackView.width/2;
    self.wordView.bottom = self.showBackView.height-5;
}
- (void)colorView:(id<MSColorView>)colorView didChangeColor:(UIColor *)color
{
    if (colorView == _bgColorSectionView) {
        self.wordView.backgroundColor = color;
    } else {
        self.wordView.textColor = color;
    }
}
#pragma mark - bgBtnAction:
- (void)bgBtnAction:(UIButton *)sender
{
    switch (sender.tag-10000) {
        case 0:
            self.bgColorSectionView.color = [UIColor blackColor];
            self.wordView.backgroundColor = [UIColor blackColor];
            break;
        case 1:
            self.bgColorSectionView.color = [UIColor whiteColor];
            self.wordView.backgroundColor = [UIColor whiteColor];
            break;
        case 2:
            self.bgColorSectionView.color = [UIColor redColor];
            self.wordView.backgroundColor = [UIColor redColor];
            break;
        case 3:
            self.bgColorSectionView.color = [UIColor greenColor];
            self.wordView.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            self.bgColorSectionView.color = [UIColor blueColor];
            self.wordView.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}
@end
