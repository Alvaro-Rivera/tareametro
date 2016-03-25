//
//  ViewController.h
//  TareaMetro
//
//  Created by Álvaro Rivera on 24-03-16.
//  Copyright © 2016 Álvaro Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SafariServices;
@interface ViewController : UIViewController <UITextViewDelegate, SFSafariViewControllerDelegate>
@property (nonatomic,strong) IBOutlet UITextView *contenido;
@property(nonatomic, weak) id< SFSafariViewControllerDelegate, SFSafariViewControllerDelegate > delegate;

@end

