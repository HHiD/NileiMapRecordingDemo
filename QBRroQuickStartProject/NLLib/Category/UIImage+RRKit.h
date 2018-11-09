

#import <UIKit/UIKit.h>

@interface UIImage (RRKit)

// 颜色创建图
+ (UIImage *)imageWithColor:(UIColor *)color;

// 等比创建缩略图
- (UIImage *)thumbnail:(CGSize)targetSize;

//缩放到指定大小尺寸
+ (UIImage *)imageScale:(UIImage *)image size:(CGSize)size;

//等比列压缩缩放 maxsize : 同比缩放的最大尺寸
+ (UIImage *)imageFitScale:(UIImage *)image maxsize:(CGSize)maxsize;


//尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image size:(CGSize)size;

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;
@end
