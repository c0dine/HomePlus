#import "HPEditorWindow.h"
#import "HPEditorViewController.h"
@interface EditorManager : NSObject 

+ (instancetype)sharedManager;
@property (nonatomic, retain) NSString *editingLocation;
@property (nonatomic, readonly, strong) HPEditorWindow *editorView;
@property (nonatomic, readonly, strong) HPEditorViewController *editorViewController;

@property (nonatomic, retain) UIImage *wallpaper;
@property (nonatomic, retain) UIImage *dynamicallyGeneratedSettingsHeaderImage;
@property (nonatomic, retain) UIImage *blurredAndDarkenedWallpaper;
@property (nonatomic, retain) UIImage *blurredMoreBackgroundImage;
-(UIImage *)bdBackgroundImage;
-(UIImage *)blurredMoreBGImage;

-(void)loadUpImagesFromWallpaper:(UIImage *)image;
-(HPEditorWindow *)editorView;
-(HPEditorViewController *)editorViewController;
-(void)resetAllValuesToDefaults;
-(void)showEditorView;
-(void)hideEditorView;
-(void)toggleEditorView;

@end