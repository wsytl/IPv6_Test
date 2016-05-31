//
//  ViewController.m
//  IPv6Test
//
//  Created by YLWX on 16/5/11.
//  Copyright © 2016年 杨天礼. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <SDWebImage+ExtensionSupport/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>  
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *testImage;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

}

- (IBAction)setPictrue:(id)sender {
    
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationZoom;
    hud.labelText=@"loading";
    
    NSString*url=@"http://110.249.209.151:5005/YLImages/2015/11/26/img20151126101719998.jpg";
    
    [_testImage sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
           
        }else{
            
         ALERT(url)
            
        }
    }];

}


- (IBAction)sendRequest:(id)sender {
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationZoom;
    hud.labelText=@"loading";
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSMutableDictionary *parmas=[NSMutableDictionary dictionary];
    parmas[@"saystype"]=@(2);
    NSString *url=[NSString stringWithFormat:@"http://www.ylwxoto.com:4989/Personal/GetSays.ashx"];
    
    [manager GET:url parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject!=nil) {
            
            NSArray *agentArray=responseObject;
            
            NSDictionary *dictArgement=agentArray[0];
            
            if (dictArgement[@"FldContent"]!=nil) {
                
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [self.webView loadHTMLString:dictArgement[@"FldContent"] baseURL:nil];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        ALERT(url)
    }];
    

}

- (IBAction)clean:(id)sender {
    
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.testImage setImage:[UIImage imageNamed:@""]];
    
    
}



@end
