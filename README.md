# ttm

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


高德SDK 配置：
1. pubspec.yaml 添加
  高德地图
  amap_flutter_location: ^2.0.0
  amap_flutter_map: ^2.0.2 
  版本去 pub dev 查
  
2.iOS：
    在info.plist文件里添加定位相关授权
    在info.plist文件添加 ATS 相关授权， ⚠️ 有可能导致 APPStore 审核失败 苹果已禁用 HTTP链接，具体可Google

3.Android：
高德官方： https://developer.amap.com/api/android-sdk/guide/create-project/android-studio-create-project

        最后的 dependencies 更改成
        
            implementation fileTree(dir: 'libs', include: ['*.jar'])
            //3D地图so及jar
            implementation('com.amap.api:3dmap:latest.integration')
            //定位功能
            implementation('com.amap.api:location:latest.integration')

4.如何查看apk对应KeyStore的SHA1值(Mac下):
      1).Debug对应的SHA1：打开terminal -> cd .android -> keytool -list -v -keystore debug.keystore (默认密码是android或空) （拿到的SHA1放到高德控制面板对应的Debug SHA1下）
      2).Release版本对应的SHA1：打开termianl -> keytool -list -v -keystore < /TTM所在的路径/android/app/key/upload-keystore.jks > (例如/Users/rick/Documents/Work/TTM/ttmmobile/android/app/key/upload-keystore.jks) -> （输入密码为12345678） （拿到的SHA1放到高德控制面板对应的 Release SHA1下）
      3).通过build出来的APK来查看： 先将要查看的APK重命名为.rar后缀的文件，然后解压，找到 META-INF 文件夹下的 CERT.RSA 文件，然后执行 keytool -printcert -file < CERT.RSA 路径 >

5. 如何构建和发布Android APK（打包）官方教程 https://docs.flutter.dev/deployment/android#signing-the-app
                                 中文教程  https://flutterchina.club/android-release/
6. 如何构建和发布iOS 应用（打包）官方教程  https://docs.flutter.dev/deployment/ios
                            中文教程 https://flutterchina.club/ios-release/
