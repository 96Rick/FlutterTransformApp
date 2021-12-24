import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';

class TTMConstants {
  static const String accessToken = "ACCESS-TOKEN";
  static const String refreshToken = "REFRESH-TOKEN";
  static const String tokenExpiresTime = "TOKEN_EXPIRES_TIME";
  static const String isRememberMe = "IS_REMBER_ME";
  static const String savedUserName = "SAVED-USER-NAME";
  static const String savedUserEmail = "SAVED-USER-EMAIL";

  static const String gaodeMapiOSKey = "0ff28aa73ae4beaec671b00452154c6a";
  static const String gaodeMapAndroidKey = "16816a8495fc23f47db142a52b1a8eb3";
  static const AMapApiKey amapApiKeys =
      AMapApiKey(androidKey: gaodeMapAndroidKey, iosKey: gaodeMapiOSKey);
  static const String warningUrl =
      "https://www.mem.gov.cn/fw/cxfw/201804/P020190328517303531736.pdf";
  static const String driverRoleId = "53d922ef-1cb5-447f-9fa9-9eabc52c629b";

  static const String policyStr =
      "本应用非常重视用户隐私政策并严格遵守相关的法律规定。请您仔细阅读《隐私政策》后再继续使用。如果您继续使用我们的服务，表示您已经充分阅读和理解我们协议的全部内容。\n\n本app尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更优质的服务，本应用会按照本隐私权政策的规定使用和披露您的个人信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本应用不会将这些信息对外披露或向第三方提供。本应用会不时更新本隐私权政策。 您在同意本应用服务使用协议之时，即视为您已经同意本隐私权政策全部内容。\n\n1. 适用范围\n(a) 在您注册本应用app帐号时，您根据app要求提供的个人注册信息；\n(b) 在您使用本应用网络服务，或访问本应用平台网页时，本应用自动接收并记录的您的浏览器和计算机上的信息，包括但不限于您的IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；\n(c) 本应用通过合法途径从商业伙伴处取得的用户个人数据。\n(d)本应用严禁用户发布不良信息，如裸露、色情和亵渎内容，发布的内容我们会进行审核，一经发现不良信息，会禁用该用户的所有权限，予以封号处理。\n\n2. 信息使用\n(a)本应用不会向任何无关第三方提供、出售、出租、分享或交易您的个人登录信息。如果我们存储发生维修或升级，我们会事先发出推送消息来通知您，请您提前允许本应用消息通知。\n(b) 本应用亦不允许任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。任何本应用平台用户如从事上述活动，一经发现，本应用有权立即终止与该用户的服务协议。\n(c) 为服务用户的目的，本应用可能通过使用您的个人信息，向您提供您感兴趣的信息，包括但不限于向您发出产品和服务信息，或者与本应用合作伙伴共享信息以便他们向您发送有关其产品和服务的信息（后者需要您的事先同意）。\n\n3. 信息披露\n在如下情况下，本应用将依据您的个人意愿或法律的规定全部或部分的披露您的个人信息：\n(a) 未经您事先同意，我们不会向第三方披露；\n(b)为提供您所要求的产品和服务，而必须和第三方分享您的个人信息；\n(c) 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\n(d) 如您出现违反中国有关法律、法规或者本应用服务协议或相关规则的情况，需要向第三方披露；\n(e) 如您是适格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷；\n\n4. 信息存储和交换\n本应用收集的有关您的信息和资料将保存在本应用及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或本应用收集信息和资料所在地的境外并在境外被访问、存储和展示。\n\n5. Cookie的使用\n(a) 在您未拒绝接受cookies的情况下，本应用会在您的计算机上设定或取用cookies ，以便您能登录或使用依赖于cookies的本应用平台服务或功能。本应用使用cookies可为您提供更加周到的个性化服务，包括推广服务。\n(b) 您有权选择接受或拒绝接受cookies。您可以通过修改浏览器设置的方式拒绝接受cookies。但如果您选择拒绝接受cookies，则您可能无法登录或使用依赖于cookies的本应用网络服务或功能。\n(c) 通过本应用所设cookies所取得的有关信息，将适用本政策。\n\n6.本隐私政策的更改\n(a)如果决定更改隐私政策，我们会在本政策中、本公司网站中以及我们认为适当的位置发布这些更改，以便您了解我们如何收集、使用您的个人信息，哪些人可以访问这些信息，以及在什么情况下我们会透露这些信息。\n(b)本公司保留随时修改本政策的权利，因此请经常查看。如对本政策作出重大更改，本公司会通过网站通知的形式告知。\n方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，尤其是本应用用户名及密码发生泄露，请您立即联络本应用客服，以便本应用采取相应措施。\n感谢您花时间了解我们的隐私政策！我们将尽全力保护您的个人信息和合法权益，再次感谢您的信任！\n";

  static const String imageAssetsUrl =
      "https://ttm-directus.fabhub.top/assets/";
  static const String platformProtocol =
      "关于注册畅途慧通承运人或者实际承运人的说明\n为了规范畅途慧通物流科技（辽宁）有限公司（以下简称“畅途慧通”）的承运人或者实际承运人准入要求，现对承运任或者实际承运人的注册办法做出具体说明。请承运人或者实际承运人认真阅读，按要求提供完整资料。\n注册畅途慧通的承运任或者实际承运人主要分为两个步骤：网上注册和现场审核。\n一、网上注册\n登录畅途慧通官方网站（https://ttm.wistraff.com/#/index）进行网上注册，按要求填写内容，所提供的资料需真实有效，注册成功后，畅途慧通将在一周内进行初步审核。\n二、现场审核\n网上注册经初审合格后，畅途慧通将在一个月内进行现场审核或者线上审核，同时请承运人或者实际承运人准备以下材料接受审核。\n（一） 企业资质。\n承运人需提供企业资质的复印件并加盖公章，其中包括：\n（1） 营业执照税、税务登记证、组织机构代码证(新版的三证合一)；\n（2） 道路运输经营许可证；\n（3） 开户银行许可及账号；\n实际承运人需提供驾驶证、身份证、从业资格证（4.5吨以上）。\n\n（二） 企业年度报告。\n承运人登陆国家企业信用信息公示系统（www.gsxt.gov.cn），打印最新的企业年度报告并加盖公章。实际承运人提供个人征信报告。\n（三） 承运人简介。\n承运商的概况简介和业绩证明，业绩材料需提供相关合同和发票原件及复印件，复印件需加盖公章。\n（四） 工商局的出资证明。\n承运人出资证明需要由当地工商局证明，名称为《企业机读档案登记资料》，并加盖工商局印章。不能开出出资证明的有验资报告也可。\n（五） 车辆及驾驶员资质。\n（1） 《中华人民共和国机动车行驶证》正副证复印件；\n（2） 《机动车交通事故责任强制保险单》复印件；\n（3） 《中华人民共和国道路运输证》正副证复印件；\n（4） 《道路运输从业资格证》复印件；\n（5） 《自有车辆明细表》（自制）；\n行驶证、保险单、营运证及从业资格证要隶属本单位，提供的复印件要与车辆明细表对应。\n（六） 经营场所证明。\n承运人需出示经营场所的土地使用证和房产证，租用场所的需出示租赁合同进行查验。\n以上说明最终解释权归畅途慧通所有，如有异议请联系咨询。\n畅途慧通物流科技（辽宁）有限公司";

  static const List<Map<String, dynamic>> fakePosition = [
    {
      "latitude": 39.909187,
      "longitude": 116.397451,
    },
    {
      "latitude": 30.909187,
      "longitude": 96.397451,
    }
  ];
}