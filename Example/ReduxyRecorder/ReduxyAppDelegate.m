//
//  ReduxyAppDelegate.m
//  ReduxyRecorder
//
//  Created by skyofdwarf on 12/22/2018.
//  Copyright (c) 2018 skyofdwarf. All rights reserved.
//

#import "ReduxyAppDelegate.h"
#import "Store.h"

@interface ReduxyAppDelegate ()
@property (strong, nonatomic) UIWindow *recorderWindow;

@property (strong, nonatomic) UIBarButtonItem *recoderStartButton;
@property (strong, nonatomic) UIBarButtonItem *recoderStopButton;
@property (strong, nonatomic) UIBarButtonItem *recoderSaveButton;
@property (strong, nonatomic) UIBarButtonItem *recoderLoadButton;
@property (strong, nonatomic) UIBarButtonItem *playerPrevButton;
@property (strong, nonatomic) UIBarButtonItem *playerNextButton;


@end


@implementation ReduxyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self attachRecorderUI];
    
    return YES;
}

#pragma mark - helper

+ (instancetype)shared {
    return (ReduxyAppDelegate *)UIApplication.sharedApplication.delegate;
}


#pragma mark - recorder window

- (void)attachRecorderUI {
    // window
    CGRect windowFrame = UIScreen.mainScreen.bounds;
    windowFrame.origin.y = windowFrame.size.height - 44;
    windowFrame.size.height = 44;
    
    NSLog(@"window: %@", NSStringFromCGRect(windowFrame));
    
    self.recorderWindow = [[UIWindow alloc] initWithFrame:windowFrame];
    self.recorderWindow.windowLevel = UIWindowLevelNormal + 1;
    self.recorderWindow.backgroundColor = UIColor.redColor;
    self.recorderWindow.rootViewController = [UIViewController new];
    
    [self.recorderWindow makeKeyAndVisible];
    [self.recorderWindow resignKeyWindow];
    
    // toolbar
    CGRect toolbarFrame = windowFrame;
    toolbarFrame.origin.y = 0;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    toolbar.items = [self toolbarItems];
    
    [self.recorderWindow.rootViewController.view addSubview:toolbar];
}

- (NSArray *)toolbarItems {
    self.recoderStartButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                            target:self
                                                                            action:@selector(recordeStartButtonClicked:)];
    
    self.recoderStopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                           target:self
                                                                           action:@selector(recordeStopButtonClicked:)];
    
    self.recoderSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(recordeSaveButtonClicked:)];
    self.recoderLoadButton = [[UIBarButtonItem alloc] initWithTitle:@"Load"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(recordeLoadButtonClicked:)];
    
    self.playerPrevButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                                          target:self
                                                                          action:@selector(recordePrevButtonClicked:)];
    
    self.playerNextButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                          target:self
                                                                          action:@selector(recordeNextButtonClicked:)];
    
    self.recoderStartButton.enabled = YES;
    self.recoderStopButton.enabled = NO;
    
    self.recoderSaveButton.enabled = NO;
    self.recoderLoadButton.enabled = YES;
    self.playerPrevButton.enabled = NO;
    self.playerNextButton.enabled = NO;
    
    
    return @[
             self.recoderStartButton,
             
             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                           target:nil
                                                           action:nil],
             self.recoderStopButton,
             self.recoderSaveButton,

             [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                           target:nil
                                                           action:nil],
             self.recoderLoadButton,
             self.playerPrevButton,
             self.playerNextButton,
             ];
}

#pragma mark - recorder window action

- (void)recordeStartButtonClicked:(id)sender {
    if (!Store.shared.recorder.recording) {
        [Store.shared.recorder start];
        
        self.recoderStartButton.enabled = NO;
        self.recoderStopButton.enabled = YES;
        
        self.recoderSaveButton.enabled = NO;
        self.recoderLoadButton.enabled = NO;
        self.playerPrevButton.enabled = NO;
        self.playerNextButton.enabled = NO;
        
    }
}

- (void)recordeStopButtonClicked:(id)sender {
    if (Store.shared.recorder.recording) {
        [Store.shared.recorder stop];
        
        self.recoderStartButton.enabled = YES;
        self.recoderStopButton.enabled = NO;
        
        self.recoderSaveButton.enabled = YES;
        self.recoderLoadButton.enabled = YES;
        self.playerPrevButton.enabled = NO;
        self.playerNextButton.enabled = NO;
    }
}

- (void)recordeSaveButtonClicked:(id)sender {
    [Store.shared.recorder stop];
    [Store.shared.recorder save];
    
    self.recoderStartButton.enabled = YES;
    self.recoderStopButton.enabled = NO;
    
    self.recoderSaveButton.enabled = NO;
    self.recoderLoadButton.enabled = YES;
    self.playerPrevButton.enabled = NO;
    self.playerNextButton.enabled = NO;
}

- (void)recordeLoadButtonClicked:(id)sender {
    [Store.shared.recorder stop];
    [Store.shared.recorder load];
    
    [Store.shared.player load:Store.shared.recorder.items
                     dispatch:^ReduxyAction(ReduxyAction action) {
                         return [Store.shared dispatch:action];
                     }];
    
    self.recoderStartButton.enabled = YES;
    self.recoderStopButton.enabled = NO;
    
    self.recoderSaveButton.enabled = NO;
    self.recoderLoadButton.enabled = YES;
    self.playerPrevButton.enabled = YES;
    self.playerNextButton.enabled = YES;
}


- (void)recordePrevButtonClicked:(id)sender {
    self.playerPrevButton.enabled = ([Store.shared.player prev] != nil);
}


- (void)recordeNextButtonClicked:(id)sender {
    self.playerNextButton.enabled = ([Store.shared.player next] != nil);
}



@end
