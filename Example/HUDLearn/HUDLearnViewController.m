//
//  HUDLearnViewController.m
//  HUDLearn
//
//  Created by silence-majority on 08/08/2017.
//  Copyright (c) 2017 silence-majority. All rights reserved.
//

#import "HUDLearnViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define XY_UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define XY_UIScreenHeight  [UIScreen mainScreen].bounds.size.height


@implementation ImageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.activityIndicator];
        
        [self.activityIndicator startAnimating];
        
        self.backgroundColor = [UIColor purpleColor];
    }
    
    return self;
}

- (UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityIndicator{
    
    if (!_activityIndicator) {
        
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(35, 15, 30, 30)];
    }
    
    return _activityIndicator;
}

@end

@interface HUDLearnViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSArray <NSString *> *urlArray;

@property (nonatomic,strong)NSMutableArray *imageArray;

@property (nonatomic,strong) MBProgressHUD *HUD;

@end

@implementation HUDLearnViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSTimeInterval ti = [[NSDate date] timeIntervalSince1970];
//    
//    NSLog(@"%f",ti);
    
    _urlArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354703082&di=01e5ca47960549ba636d12b4738ef0bb&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1108%2F30%2Fc7%2F8817683_8817683_1314688554399.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354797049&di=8eef7521dfdc350602544555a416d22b&imgtype=0&src=http%3A%2F%2Fimg2.niutuku.com%2Fdesk%2F1207%2F0846%2Fntk60825.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354863456&di=cf2fcbdd9dba5a1a82a35af2cc8c963f&imgtype=0&src=http%3A%2F%2Fwww.deskcar.com%2Fdesktop%2Ffengjing%2F201342152514%2F16.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354918358&di=8fa95f6055f5fd18d504d662e2a77930&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D1866295247%2C1744447099%26fm%3D214%26gp%3D0.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354863451&di=2e3afd85ce7eefbcc8e44fc1f5c8f0ff&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1410%2F07%2Fc0%2F39337355_39337355_1412677924703.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354996992&di=1ba7230b1fc3b484633fcaeac7da20e9&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D3784626596%2C862817364%26fm%3D214%26gp%3D0.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354863449&di=c2504ad1e8a1eb2ad337fada6a05117f&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ffd%2Ftg%2Fg1%2FM06%2F1F%2F51%2FCghzflUd9fuAakuSABFowwQKBbc035.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354994120&di=f52b8d55c7cced6d393adb0bc0fe7ac2&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F641%2F547%2F151%2Fad9dad845dc7406a9ac131715183c905.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354994120&di=9f7e2d315591dfb185dddc0a109f7252&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F941%2F763%2F181%2Fc3a0693430264494957f70e15dfe4928.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355058995&di=6efedba92a66d598ee6aca597d4665d7&imgtype=jpg&src=http%3A%2F%2Fimg2.imgtn.bdimg.com%2Fit%2Fu%3D751482411%2C4096702592%26fm%3D214%26gp%3D0.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502354994119&di=2e40331d591e2a6eabffc12594345976&imgtype=0&src=http%3A%2F%2Fp5.image.hiapk.com%2Fuploads%2Fallimg%2F150619%2F7730-1506191I617.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355126119&di=34f3deff66c93e768e7bfd9cd3e8998a&imgtype=0&src=http%3A%2F%2Fstatic.hdw.eweb4.com%2Fmedia%2Fwallpapers_2560x1440%2Fbeaches%2F1%2F2%2Fpurple-sunset-beach-hd-wallpaper-2560x1440-13127.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355168472&di=e70dbe26888dce13f7b6e6b36fc1cf73&imgtype=0&src=http%3A%2F%2Fwww.sucaitianxia.com%2FPhoto%2Fpic%2F201003%2Ffenggs13.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355168472&di=3cff1db0bdc360f874ecd6071d7e59d3&imgtype=0&src=http%3A%2F%2Fbizhi.zhuoku.com%2F2010%2F03%2F20%2FNature%2Ffengguang10.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355168471&di=07bb6b2f43b7c047ddd3d97cc3cf82a5&imgtype=0&src=http%3A%2F%2Fbizhi.zhuoku.com%2F2010%2F12%2F22%2Fsheying%2FKuanping06.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355168470&di=e6b06aeabde7aeb6d7de4300d017fe1e&imgtype=0&src=http%3A%2F%2Fpic.5442.com%2F2014%2F1119%2F04%2F05.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355168469&di=8c5d74b49aaadcb8237f179468312ade&imgtype=0&src=http%3A%2F%2Fwww.wallcoo.com%2Fnature%2FAmazing_Color_Landscape_2560x1600%2Fwallpapers%2F2560x1600%2FAmazing_Landscape_101.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502949991&di=426f0730dfc30657146a6792ca440950&imgtype=jpg&er=1&src=http%3A%2F%2Fzentalk.asus.com.cn%2Fdata%2Fattachment%2Fforum%2F201608%2F30%2F083919habfqi44a4mm7q7p.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355304978&di=f83112008fdf6484de925af3accbad46&imgtype=0&src=http%3A%2F%2Fbizhi.zhuoku.com%2F2015%2F08%2F06%2F4k%2Fkuanpin115.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355332031&di=defedff0b54627d047998417791f41a7&imgtype=0&src=http%3A%2F%2Fbizhi.zhuoku.com%2F2015%2F08%2F06%2F4k%2Fkuanpin075.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355412959&di=965e35c68cc26bc44ac09fb161d414a7&imgtype=0&src=http%3A%2F%2Fstatic01.coloros.com%2Fbbs%2Fdata%2Fattachment%2Fforum%2F201505%2F17%2F215535vmjosmo7sh7eagfa.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355442760&di=234a1ce6961fdbe0880757def5067b91&imgtype=0&src=http%3A%2F%2Fbizhi.zhuoku.com%2F2015%2F08%2F06%2F4k%2Fkuanpin012.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355442760&di=d68806b669db7f94d890575fc539685d&imgtype=0&src=http%3A%2F%2Fbizhi.zhuoku.com%2F2015%2F08%2F06%2F4k%2Fkuanpin064.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355495807&di=241472bdeb95fa6cd1a8a7cb5200c770&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2Fb%2F573c2ccc449e1.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355534110&di=e4db6c565b98c0f2efffaf86bee60d0c&imgtype=0&src=http%3A%2F%2Fimg.tuku.cn%2Ffile_big%2F201501%2F2417106ac03e4340a37514a520d6a9a6.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355554374&di=1a11ab59ade2020712d9e43aa23c54a4&imgtype=0&src=http%3A%2F%2Fimg-download.pchome.net%2Fdownload%2F1k0%2Fpk%2F3y%2Fo9mhpq-129q.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355581301&di=6171dbce0613d8d4531b9e4436023786&imgtype=0&src=http%3A%2F%2Fimg.tuku.cn%2Ffile_big%2F201501%2Fa9c40c9605844d4d94f58af492d0ae31.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355628548&di=2162241d231bb3669bb9f8ce1c275578&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F045201f1295b98c908c0bbdcdb486d0a77fdd5fe.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355670744&di=0e5b8d2787e8672152864528275e587e&imgtype=0&src=http%3A%2F%2Fi0.wp.com%2Fwww.street-pics.net%2Fwp-content%2Fuploads%2F2014%2F04%2FIBA_4K_4096_Gunkanjima_buildings_1.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355688766&di=4cf57809cf3ece97fcd5dc0a54173f4e&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2F12280ad186edb2c9b3f635561731d7ca35d0aa6f.jpg"];
    
    _imageArray = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.collectionView];
    
    [self loadImage];
	// Do any additional setup after loading the view, typically from a nib.
}

- (MBProgressHUD *)HUD{
    
    if (!_HUD) {
        
        _HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        
        _HUD.center = self.view.center;
        
        _HUD.mode = MBProgressHUDModeIndeterminate;
        
        _HUD.animationType = MBProgressHUDAnimationZoom;
        
        _HUD.graceTime = 0;
        
        _HUD.minShowTime = 1;
        
//        _HUD.label.text = @"图片加载中...";
        _HUD.labelText = @"图片加载中...";
        
        [self.view addSubview:_HUD];
    }
    
    return _HUD;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(100, 57);
        
        layout.minimumLineSpacing = 5;
        
        layout.minimumInteritemSpacing = 5;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, XY_UIScreenWidth, XY_UIScreenHeight - 20) collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor cyanColor];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 30;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)loadImage{
    
//    [self.HUD showAnimated:true];
    [self.HUD show:true];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger index = 0 ; index < self.urlArray.count; index++){
    
        dispatch_group_async(group, queue, ^{
            
            dispatch_group_enter(group);
            
            [self getImageWithIndex:index group:group];
        });
        
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        NSLog(@"图片组加载完成！--%@", [NSThread currentThread]);
        
        self.HUD.mode = MBProgressHUDModeCustomView;
        
        UIImage *image = [UIImage imageNamed:@"Checkmark"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        self.HUD.customView = imageView;
        
//        self.HUD.label.text = @"图片加载成功！";
        
//        [self.HUD hideAnimated:true afterDelay:2];
        self.HUD.labelText = @"图片加载成功！";
        [self.HUD hide:true afterDelay:2];
        
    });
}

- (void)getImageWithIndex:(NSInteger)index group:(dispatch_group_t)group{
    
    NSURL *url = [NSURL URLWithString:self.urlArray[index]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            
            NSLog(@"我是error--%@",error);
        
        }else{
            
            UIImage *image = [UIImage imageWithData:data];
            
            [_imageArray addObject:image];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                cell.imageView.image = image;
                
                [cell.activityIndicator stopAnimating];
            });
            
            NSLog(@"已加载第 %ld 张图片",index+1);
            
            dispatch_group_leave(group);
        }
    }];
    
    [task resume];
}

- (void)downLoadImaegWithUrlStr:(NSString *)urlstr group:(dispatch_group_t)group{
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    
    [downLoadTask resume];
}


@end
