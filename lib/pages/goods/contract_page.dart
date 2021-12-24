import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:ttm/common/ttm_colors.dart';
import 'package:ttm/common/ttm_constants.dart';
import 'package:ttm/common/ttm_icons.dart';
import 'package:ttm/common/ttm_size.dart';
import 'package:ttm/common/ttm_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:ttm/model/goods_models/all_goods_model.dart';
import 'package:ttm/model/intention_models/all_intention_model.dart';
import 'package:ttm/status/main_status_model.dart';
import 'package:ttm/widgets/app_bar.dart';
import 'package:ttm/widgets/colorful_safe_area/colorful_safe_area.dart';

enum GoodContractPageType { good, intention }

class GoodContractPage extends StatefulWidget {
  GoodContractPage({
    Key? key,
    required this.type,
    this.goodModel,
    this.intentionModel,
    required this.userName,
    required this.userTel,
  }) : super(key: key);

  final GoodContractPageType type;
  final GoodModel? goodModel;
  final IntentionModel? intentionModel;
  final String userName;
  final String userTel;

  @override
  _GoodContractPageState createState() => _GoodContractPageState();
}

class _GoodContractPageState extends State<GoodContractPage> {
  final goodContractPageKey = GlobalKey<ScaffoldState>();
  late MainStatusModel _model;
  @override
  void initState() {
    super.initState();
    _model = ScopedModel.of<MainStatusModel>(context);
    _model.getContractInfo();
  }

  List<Widget> buildGoods() {
    if (widget.type == GoodContractPageType.good) {
      if (widget.goodModel == null) {
        return [
          Container(
            child: Text("暂无货品信息"),
          )
        ];
      } else if (widget.goodModel!.goods.isEmpty) {
        return [
          Container(
            child: Text("暂无货品信息"),
          )
        ];
      }
    } else {
      if (widget.intentionModel == null) {
        return [
          Container(
            child: Text("暂无货品信息"),
          )
        ];
      } else if (widget.intentionModel!.demand == null) {
        return [
          Container(
            child: Text("暂无货品信息"),
          )
        ];
      } else if (widget.intentionModel!.demand.goods.isEmpty) {
        return [
          Container(
            child: Text("暂无货品信息"),
          )
        ];
      }
    }

    List<Widget> goodList = [];
    for (var item in widget.type == GoodContractPageType.good
        ? widget.goodModel!.goods
        : widget.intentionModel!.demand.goods) {
      goodList.add(
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          width: TTMSize.screenWidth - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: TTMColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 20.0,
                spreadRadius: -5,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "货品名称",
                      style: TTMTextStyle.goodsDetailPageLabel,
                    ),
                    Expanded(
                      child: Text(
                        item.name ?? "",
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "货品数量",
                      style: TTMTextStyle.goodsDetailPageLabel,
                    ),
                    Expanded(
                      child: Text(
                        item.count.toString(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "单位重量（吨）",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        item.weight.toString(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "单位体积（立方米）",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        item.volume.toString(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Container(height: 1, color: TTMColors.cellLineColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "产品类别",
                      style: TTMTextStyle.thirdTitle,
                    ),
                    Expanded(
                      child: Text(
                        item.classification.name.toString(),
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TTMTextStyle.goodsDetailPageSecondTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return goodList;
  }

  Widget buildAppBar() {
    return Container(
        width: TTMSize.screenHeight,
        height: 60,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Stack(
            children: [
              Positioned(
                left: 20,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: commonBack1(
                    size: 26,
                    color: TTMColors.titleColor,
                  ),
                ),
              ),
              const Center(
                  child: Text(
                "道路运输合同书",
                style: TextStyle(
                    color: TTMColors.titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ))
            ],
          ),
        ));
  }

  Widget buildBody(MainStatusModel statusModel) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 40, bottom: 10),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // buildCarInfo(),

                Wrap(runSpacing: 5, children: [
                  Text(
                    "托运人：",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Text(
                    "    ${statusModel.contractInfoModel.companyName}    ;",
                    style: TTMTextStyle.contractRuntimeValueTitle,
                  ),
                  Text(
                    "（简称甲方）",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Container(
                    width: 1000,
                    height: 10,
                  ),
                  Text(
                    "委托代表人",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Text(
                    "    ${statusModel.contractInfoModel.contactName}    ;",
                    style: TTMTextStyle.contractRuntimeValueTitle,
                  ),
                  Container(
                    width: 1000,
                    height: 10,
                  ),
                  Text(
                    "电话",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Text(
                    "    ${statusModel.contractInfoModel.contactTel}    ;",
                    style: TTMTextStyle.contractRuntimeValueTitle,
                  ),
                  Container(
                    width: 1000,
                    height: 10,
                  ),
                  Text(
                    "地址",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Text(
                    "    ${statusModel.contractInfoModel.contactAddress}    ;",
                    style: TTMTextStyle.contractRuntimeValueTitle,
                  ),
                  Container(
                    width: 1000,
                    height: 20,
                  ),
                  Text(
                    "承运人：",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Text(
                    "    ${widget.userName}    ;",
                    style: TTMTextStyle.contractRuntimeValueTitle,
                  ),
                  Text(
                    "（简称乙方）",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Container(
                    width: 1000,
                    height: 10,
                  ),
                  Text(
                    "联系电话",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                  Text(
                    "    ${widget.userTel}    ;",
                    style: TTMTextStyle.contractRuntimeValueTitle,
                  ),
                  Container(
                    width: 1000,
                    height: 20,
                  ),
                  Text(
                    "根据国家有关运输规定，经双方友好协商，特订立本合同，以便双方共同遵守：\n\n第一条、货运范围及包装要求\n1.包装要求：托运方必须按照国家主管机关规定的标准包装;没有统一规定包装标准的，应根据保证货物运输安全的原则进行包装，否则承运方有权拒绝承运。\n\n第二条、货物名称，类别，数量，重量，体积，装车数量若有误或不祥的，实数以清单为准。",
                    style: TTMTextStyle.contractConstTitle,
                  ),
                ]),
                Container(
                  height: 10,
                ),
                Text(
                  "价款：${widget.goodModel?.price} 元",
                  style: TTMTextStyle.contractConstTitle,
                ),
                Container(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    height: 360,
                    decoration: BoxDecoration(
                        color: TTMColors.cellLineColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListView(
                      children: buildGoods(),
                    )),

                Container(
                  width: 1000,
                  height: 20,
                ),
                Text(
                  "第三条、运输地点及收货单位",
                  style: TTMTextStyle.contractConstTitle,
                ),
                Container(
                  width: 1000,
                  height: 20,
                ),
                Text(
                  "提货详细地址",
                  style: TTMTextStyle.contractConstTitle,
                ),
                Text(
                  widget.type == GoodContractPageType.good
                      ? "    ${widget.goodModel!.pickupProvince.name}-${widget.goodModel!.pickupCity.name}-${widget.goodModel!.pickupArea.name}-${widget.goodModel!.pickupAddress}    ;"
                      : "    ${widget.intentionModel!.demand.pickupProvince.name}-${widget.intentionModel!.demand.pickupCity.name}-${widget.intentionModel!.demand.pickupArea.name}-${widget.intentionModel!.demand.pickupAddress}    ;",
                  style: TTMTextStyle.contractRuntimeValueTitle,
                ),
                Container(
                  width: 1000,
                  height: 20,
                ),
                Text(
                  "送货详细地址",
                  style: TTMTextStyle.contractConstTitle,
                ),
                Text(
                  widget.type == GoodContractPageType.good
                      ? "    ${widget.goodModel!.receivingProvince.name}-${widget.goodModel!.receivingCity.name}-${widget.goodModel!.receivingArea.name}-${widget.goodModel!.receiving_address}    ;"
                      : "    ${widget.intentionModel!.demand.receivingProvince.name}-${widget.intentionModel!.demand.receivingCity.name}-${widget.intentionModel!.demand.receivingArea.name}-${widget.intentionModel!.demand.receivingAddress}    ;",
                  style: TTMTextStyle.contractRuntimeValueTitle,
                ),
                Container(
                  width: 1000,
                  height: 20,
                ),
                Text(
                  "第四条、托运方的权利义务与责任\n\n1.每次托运的托运地点、装货地点、联系人、装货/托运时间、货物数据包括货品名称、包装、数量、重量、价值、费用等详细数据见依每次的有效托运单为准，本合同不再另立明，但托运运单上的信息一经双方签字确定后与本合同具有同等的法律效力。\n\n2.托运方对托运单上相关信息之准确性负责，但其托运单需经双方正式签核确定方可生效。\n\n3.本合同原则上具有长期合作关系，双方需履行本合同中规定的权利、义务和责任，而本合同中未列明的事项，可另外口头说明，双方口头作出认可，亦可另文立字说明。\n\n4.承运方需按照合同规定的时间、地点、把货物运输到目的地。货物托运后，托运方需要变更到货地点或收货人，或者取消托运时，有权向承运方提出变更合同的内容或解除合同的要求。但必须在货物未运到目的地之前通知承运方，并应按有关规定付给承运方所需费用。\n\n5. 托运方需在装车前将出口文件、托运货品相关信息交由承运方确定。\n\n6.托运方若因提供的托运信息如所报货品名、数量、重量等不符，而导致当地政府扣留或处罚时，该责任均由托运方负责，同时承运方车辆依上述原因被阻，暂时不能营业所造成的损失均由托运方依实际时间赔偿给承运方。\n\n7.托运方应依照约定时间装卸货物，承运方车辆到达托运方两小时内需装卸完毕，若超时或多地点装卸按照承运方订定的价目另计附加费，所以随道费、过渡、过桥费用均由托运方支付。\n\n8.运输途中，一些自然灾害如风水火险、机件故障等意外均由托运方负责;但因车辆故障或司机驾驶所造成的意外需由承运方负责。\n\n9.若因报关文件不齐备、逾期、装卸超时，托运方必须按实际时间支付承运方运货及过夜费，关场停车费。\n\n10.若因在普通货物中夹带匿名危险货物，错报重货物重量等招致吊具断裂、货物摔损、吊机倾翻、爆炸、腐烛等事故，托运方应承担赔偿责任。\n\n11.由于货物包装缺陷产生破损，致使其它货物或运输工具、机械设备被污染腐蚀、损坏，造成人身伤亡的，托运方应承担赔偿责任。 在托运方专用线或在港、站公用线、专用线自装的货物，在到站卸货时，发现货物损坏、缺少，在车辆施封完好或无异状的情况下，托运方应赔偿收货人的损失。 若因托运方携带违禁品，违反当地法规，而引致车辆及司机被扣留或处罚时，托运人必须赔偿一切损失，直至该事件完满解决为止。 凤岗→盐田海关)和时间(全程约1~1.5小时)安全抵达，特殊情况需绕道而行及延长运输时间的，需得到托运方跟车员的同意方可，否则承运方需承担因此带来的全部风险。\n\n第五条、承运方的权利义务与责任\n\n1.向托运方、收货方收取运杂费用。如果收货方不交或不按时交纳规定的各种运杂费用，承运方对其货物有扣压权。查不到收货人或收货人拒绝提取货物，承运方应及时与托运方联系，在规定期限内负责保管并有权收取保管费用，对于超过规定期限仍无法交付的货物，承运方有权按有关规定予以处理。\n\n2.在合同规定的期限内，将货物运到指定的地点，按时向收货人发出货物到达的通知。对托运的货物要负责安全，保证货物无短缺、无损坏、无人为的变质、无非法品的混入、无掉包、无货物被盗窃等，如有上述问题，应承担赔偿义务。在货物到达以后，按规定的期限，负责保管。承运方要确保货运到时包装完好，除海关查车之外，不可拆开所承运的物品，如有违背本协议后果由承运方负全部责任。货物数量由双方当面点清，交承运方后由承运方负责。承运方必须按托运方之要求，按时将货物交给托运方所指定的收货人，并办好交接手续及签回具有收货人签章的收货单据并交回给托运方。若承运方不按合同规定的时间和要求配车、发运的，应赔偿付托运方40%的违约金。承运方如将货物错运到收货地点或接货人，应无偿运至合同规定的收货地点或接货人。如果货物逾期达到、承运方应偿付逾期交货的违约金。\n\n运输过程中货物遗失、短缺、变质、污染、损坏、被掉包、被盗窃、混入非法品或误时等，承运方应按货物的实际损失(包括包装费、运杂费)赔偿托运方。\n\n在全程运输中，除①不可抗力;②货物本身的自然属性; ③货物的合理损耗;④托运方或收货方本身的过错四项原因造成货物破损、误时、受潮、短缺、折痕等不良之经济损失，承运方不承担违约责任外，其它因素均由承运方负责赔偿，并以此车作为抵押。\n\n3.承运期间除自然灾难之外，其它的因车辆故障、司机驾驶等因素而造成的交通事故以及其意外事故所造成的损失，均由承运方承担，与托运方无关。\n\n4. 承运方必须符合C-TPAT最低保安要求。\n\n5.承运方须对所聘请的雇员做出背景调查与核实，确保所聘请的雇员具有高诚信度，与罪犯或其它不良分子无任何联系。\n\n6.承运方司机在入厂前，必须配合工厂对其身份、车辆、相关文件的检查，若有任何疑问，托运方有权盘问、拒绝入内，或公安机关部门处理。\n\n7.承运方必须给予司机相关保安安全方面的知识培训，在运输途间不得无故停顿、逗留或向外界人员接触;务必确保货物自出发点到抵达点期间无任何短缺、损坏、非法品的混入、掉包、被盗窃等情况的发生，否则依运输合同规定追究责任。\n\n8. 承运方司机在运输前及运输途中，不得有任何不良行为，如喝酒、斗殴等情况。\n\n9. 字楼一楼业务办公室，休息时间大约：1-3小时，就餐地点：工厂职员餐厅。\n\n10.承运方在承运期间，若发现有任何可疑情况，要及时通报承运方与托运方公司负责人。\n\n11.承运方依托运方柜纸负责取柜和取船务封条，并负责核实与保管船务封条直至香港码头结关封条交柜。\n\n第六条、本合同一式二份，自双方签字后生效;由托运方和承运方各执一份。",
                  style: TTMTextStyle.contractConstTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Container(
      color: TTMColors.backgroundColor,
      height: 75,
      width: TTMSize.screenWidth,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.copyright_outlined,
                  size: 15,
                  color: TTMColors.copyrightTitle,
                ),
                Container(
                  width: 5,
                ),
                const Text(
                  'Copyright 畅图慧通网络货运平台',
                  style:
                      TextStyle(fontSize: 12, color: TTMColors.copyrightTitle),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStatusModel>(
        builder: (context, child, model) {
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          key: goodContractPageKey,
          backgroundColor: TTMColors.backgroundColor,
          resizeToAvoidBottomInset: true,
          body: ColorfulSafeArea(
            topColor: TTMColors.backgroundColor,
            bottomColor: TTMColors.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildAppBar(),
                buildBody(model),
                buildBottom(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
