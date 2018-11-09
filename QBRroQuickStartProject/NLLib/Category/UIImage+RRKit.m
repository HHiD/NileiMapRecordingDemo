

#import "UIImage+RRKit.h"

@implementation UIImage (RRKit)
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    context = nil;
    return image;
}



- (UIImage *)thumbnail:(CGSize)targetSize{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width,
    height = imageSize.height,
    targetWidth = targetSize.width,
    targetHeight = targetSize.height,
    scaleFactor = 0.0,
    scaledWidth = targetWidth,
    scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat widthFactor = targetWidth / width,
        heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(thumbnail == nil) NSLog(@"could not scale image");
    return thumbnail ;
}


//缩放到指定大小尺寸
+ (UIImage *)imageScale:(UIImage *)image size:(CGSize)size
{
    //创建一个bitmap的context 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    //绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    //使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


//尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image size:(CGSize)size{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//等比列压缩缩放 maxsize : 同比缩放的最大尺寸
+ (UIImage *)imageFitScale:(UIImage *)image maxsize:(CGSize)maxsize
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    CGSize size = maxsize;
    
    float w = 0.0f;
    float h = 0.0f;
    float or = width * 1.0 / height;
    float nr = size.width * 1.0 / size.height;
    if(or < nr) {
        w = size.width;
        h = w * height / width;
    } else {
        h = size.height;
        w = h * width / height;
    }
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake((size.width - w)/2, (size.height - h)/2, w, h)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
