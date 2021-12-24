class API {
  static const baseUrl = "";

  static const loginPath = "/auth/login";

  // [POST]
  static const register = "/users";

  static const getDriverRoleID = "/roles";

  static const refreshToken = "/auth/refresh";

  static const driver = "/driver";

  static const goods = "/items/demand";
  static const intention = "/items/intention";

  // [GET]
  // 获取用户基础信息
  static const getUserBaseInfo = "/users";

  // [GET]
  // 获取所有我的车辆卡片信息
  static const getCarInfo = "/items/transportation";

  // [GET]
  // 获取我的信息详情
  static const myInfo = "/items/driver";
  // [GET]
  // 搜索车队
  static const searchCarFleets = "/items/company";

  static const joinFleet = "/items/driver_audit";

  // [GET]
  // 车辆联动
  static const getCarTypeList = "/items/md";

  // [GET]
  // 图片
  static const getCurrentPicFoldersStatus = "/folders";
  static const uploadFiles = "/files";

  static const execution = "/items/execution";
  static const order_carrier = "/items/order_carrier";
  static const order_shipper = "/items/order_shipper";

  // 发票
  static const invoice = "/items/invoice_sell";
  // 应收
  static const receivable = "/items/payables";

  static const cafCarrier = "/items/cfa_carrier";
  static const afcCarrier = "/items/afc_carrier";
  static const afcCtgy = "/items/afc_ctgy";
}
