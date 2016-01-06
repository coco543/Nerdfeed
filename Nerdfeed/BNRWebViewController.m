//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by 郑克明 on 16/1/4.
//  Copyright © 2016年 郑克明. All rights reserved.
//

#import "BNRWebViewController.h"

@interface BNRWebViewController () <UIWebViewDelegate>
@property (nonatomic,strong) UIBarButtonItem *forwardButtonItem;
@property (nonatomic,strong) UIBarButtonItem *backwardButtonItem;
@end

@implementation BNRWebViewController

- (void)loadView{
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
    webView.delegate = self;
    //[self.navigationController setToolbarHidden:NO animated:YES]; 不显示,而且self.navigationController为nil
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.navigationController setToolbarHidden:NO animated:YES]; 不显示,而且self.navigationController为nil
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //添加底部toolbar
    self.forwardButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"->" style:UIBarButtonItemStyleDone target:self action:@selector(forwardPage:)];
    self.backwardButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStylePlain target:self action:@selector(backwardPage:)];
    UIBarButtonItem *flexibleButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleButtonItem.width = 15;
    self.toolbarItems = [NSArray arrayWithObjects:self.backwardButtonItem,flexibleButtonItem,self.forwardButtonItem, nil];
    [self.navigationController setToolbarHidden:NO animated:YES]; // 显示,self.navigationController不为nil
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setURL:(NSURL *)URL{
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

#pragma mark - webView 功能
- (void)forwardPage:(id)sender{
    NSLog(@"%@",sender);
    UIWebView *webView = (UIWebView *)self.view;
    [webView goForward];
    if (!webView.canGoForward) {
        [self.forwardButtonItem setEnabled:NO];
    }
}
-(void)backwardPage:(id)sender{
    NSLog(@"%@",sender);
    UIWebView *webView = (UIWebView *)self.view;
    [webView goBack];
    if (!webView.canGoBack) {
        [self.backwardButtonItem setEnabled:NO];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finish load");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"should start loda");
    if (!webView.canGoForward) {
        [self.forwardButtonItem setEnabled:NO];
    }else{
        [self.forwardButtonItem setEnabled:YES];
    }
    if (!webView.canGoBack) {
        [self.backwardButtonItem setEnabled:NO];
    }else{
        [self.backwardButtonItem setEnabled:YES];
    }
    return YES;
}
@end
