SET NAMES UTF8;
DROP DATABASE IF EXISTS cake;
CREATE DATABASE cake CHARSET=UTF8;
USE cake;

/** 用户表 **/
CREATE TABLE cake_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(50),                                          #用户名
  phone VARCHAR(16),                                          #手机号(登陆的账号)
  upwd VARCHAR(32),                                           #登陆密码
  avatar VARCHAR(128) DEFAULT "默认一张登陆后的头像",           #头像
  integral INT DEFAULT 0                                      #积分(默认开始为0)
);

/** 商家用户表 **/
CREATE TABLE cake_merchant(
  mid INT PRIMARY KEY AUTO_INCREMENT,
  mname VARCHAR(50),                                          #用户名
  phone VARCHAR(16),                                          #手机号(登陆的账号)
  mpwd VARCHAR(32),                                           #登陆密码
  avatar VARCHAR(128) DEFAULT "默认一张登陆后的头像",           #头像
  merchant_name VARCHAR(32),                                  #真实姓名
  gender INT,                                                 #性别  0-女  1-男
  shop VARCHAR(128)                                           #店铺
);

/** 商品表                  已有**/
CREATE TABLE cake_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  cid INT,                                                   #商品分类
  pname VARCHAR(128),                                        #商品名称
  price DECIMAL(10,2)                                        #最低价格
  pic VARCHAR(128),                                          #商品图片
  sales_volume INT,                                          #销售量
  read_num INT DEFAULT 0,                                    #用户阅览数
  shelf_time BIGINT,                                         #上架时间
  sold_out_time BIGINT,                                      #下架时间
  is_Sell_well BOOLEAN,                                      #是否热销(是为1,否为0)
  seq_state BOOLEAN                                          #销售状态(在销:1,下架:0)
);

/** 商品家族(分类)            已有 **/ 
CREATE TABLE cake_catalogue(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(32),                                        #分类的名称
  series VARCHAR(32),                                       #属于的系列
  pic VARCHAR(128)                                          #系列图片
);

/** 商品规格                  已有**/
CREATE TABLE cake_spec(
  sid INT PRIMARY KEY AUTO_INCREMENT,
  pid INT,                                                 #商品的id
  size VARCHAR(16),                                        #尺寸
  price DECIMAL(10,2),                                       #价格
  is_state VARCHAR(3),                                        #状态(预定:0,现货:1) -1:没有状态
  style VARCHAR(32),                                       #商品款式
  fruit VARCHAR(32),                                       #水果
  else_message VARCHAR(36),                                #其他的信息(其他无法归类的)
  repertory INT DEFAULT 0                                  #商品库存(默认0)
);

/** 图片表(商品详情的图片)        已有**/
CREATE TABLE cake_pic(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  pid INT,                                                 #商品的id
  pic VARCHAR(128)                                         #图片
);

/** 购物车表 **/
CREATE TABLE cake_cart(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                                             #用户编号
  product_id INT,                                          #商品编号
  sid INT,                                                 #规格id
  count INT +9                                               #购买数量
);

/**用户订单**/
CREATE TABLE cake_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                                            #用户编号
  address_id INT,                                         #收货地址id
  status INT,                                             #订单状态(1等待付款,2等待发货,3运输中,4已签收,5已取消)
  order_time BIGINT,                                      #下单时间
  pay_time BIGINT,                                        #付款时间
  deliver_time BIGINT,                                    #发货时间
  received_time BIGINT                                    #签收时间
)AUTO_INCREMENT=10000000;                                 #从10000000开始自增

/**用户订单**/
CREATE TABLE cake_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,                                           #订单编号
  product_id INT,                                         #产品编号
  count INT                                               #购买数量
);

/**收货地址信息**/
CREATE TABLE cake_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                                            #用户编号
  receiver VARCHAR(16),                                   #接收人姓名
  province VARCHAR(16),                                   #省
  city VARCHAR(16),                                       #市
  county VARCHAR(16),                                     #县
  address VARCHAR(128),                                   #详细地址
  cellphone VARCHAR(16),                                  #手机
  fixedphone VARCHAR(16),                                 #固定电话
  postcode CHAR(6),                                       #邮编
  tag VARCHAR(16),                                        #标签名
  is_default BOOLEAN                                      #是否为当前用户的默认收货地址
);


/** 录入数据 **/


/*商品表*/
INSERT INTO cake_product VALUE
(1,1,"芒果戚风",108,"images/product/64sd78f5465sda4159.jpg",0,0,NULL,NULL,1),
(2,1,"胡萝卜粗粮戚风",108,"64sd78f5465sda4158.jpg",0,0,NULL,NULL,1),
(3,1,"榴莲戚风",228,"64sd78f5465sda4158.jpg",0,0,NULL,NULL,1),
(4,1,"提拉米苏",188,"64sd78f5465sda4165.jpg",0,0,NULL,NULL,1),
(5,1,"小森林",188,"64sd78f5465sda4156.jpg",0,0,NULL,NULL,1),
(6,1,"泡芙黑森林",108,"64sd78f5465sda4156.jpg",0,0,NULL,NULL,1),
(7,1,"草莓黑森林",108,"64sd78f5465sda4154.jpg",0,0,NULL,NULL,1),
(8,1,"原味切达芝士",208,"64sd78f5465sda4168.jpg",0,0,NULL,NULL,1),
(9,1,"抹茶酸奶芝士",208,"64sd78f5465sda4162.jpg",0,0,NULL,NULL,1),
(10,1,"榛子慕斯",208,"64sd78f5465sda4169.jpg",0,0,NULL,NULL,1),
(11,1,"红茶千层",188,"64sd78f5465sda4155.jpg",0,0,NULL,NULL,1),
(12,1,"抹茶千层",188,"64sd78f5465sda4161.jpg",0,0,NULL,NULL,1),
(13,1,"栗子慕斯",208,"64sd78f5465sda4157.jpg",0,0,NULL,NULL,1),
(14,1,"抹茶白巧慕斯",188,"64sd78f5465sda4160.jpg",0,0,NULL,NULL,1),
(15,1,"巧克力缤纷水果戚风",108,"64sd78f5465sda4164.jpg",0,0,NULL,NULL,1),


(16,2,"紫米奶茶戚风",139,"64sd78f5465sda4144.jpg",0,0,NULL,NULL,0),


(17,2,"春日花花(加高版)",168,"64sd78f5465sda4127.jpg",0,0,NULL,NULL,1),
(18,2,"山海·榛子慕斯",198,"64sd78f5465sda4139.jpg",0,0,NULL,NULL,1),
(19,2,"Pink Dream(加高款)",268,"64sd78f5465sda4123.jpg",0,0,NULL,NULL,1),
(20,2,"树莓荔枝戚风",198,"64sd78f5465sda4140.jpg",0,0,NULL,NULL,1),
(21,2,"芒果百香果戚风",198,"64sd78f5465sda4133.jpg",0,0,NULL,NULL,1),
(22,2,"日和",468,"64sd78f5465sda4137.jpg",0,0,NULL,NULL,1),
(23,2,"暴富",149,"64sd78f5465sda4126.jpg",0,0,NULL,NULL,1),
(24,2,"茉莉千层",149,"64sd78f5465sda4136.jpg",0,0,NULL,NULL,1),
(25,2,"雪天的树",108,"64sd78f5465sda4142.jpg",0,0,NULL,NULL,1),
(26,2,"消夏小盹(加高版)",218,"64sd78f5465sda4141.jpg",0,0,NULL,NULL,1),
(27,2,"加州花园",268,"64sd78f5465sda4131.jpg",0,0,NULL,NULL,1),
(28,2,"蜜桃红茶戚风",158,"64sd78f5465sda4135.jpg",0,0,NULL,NULL,1),
(29,2,"Cupcakes-春天",108,"64sd78f5465sda4122.jpg",0,0,NULL,NULL,1),
(30,2,"花与爱丽丝",168,"64sd78f5465sda4130.jpg",0,0,NULL,NULL,1),
(31,2,"班兰戚风",208,"64sd78f5465sda4125.jpg",0,0,NULL,NULL,1),
(32,2,"芒果夏洛特",218,"64sd78f5465sda4134.jpg",0,0,NULL,NULL,1),
(33,2,"日式红薯戚风",168,"64sd78f5465sda4138.jpg",0,0,NULL,NULL,1),
(34,2,"栗子戚风",118,"64sd78f5465sda4132.jpg",0,0,NULL,NULL,1),
(35,2,"桂花红茶戚风",198,"64sd78f5465sda4128.jpg",0,0,NULL,NULL,1),
(36,2,"班兰芒果戚风",118,"64sd78f5465sda4124.jpg",0,0,NULL,NULL,1),
(37,2,"海盐焦糖戚风",168,"64sd78f5465sda4142.jpg",0,0,NULL,NULL,1),
(38,2,"纸杯蛋糕组合装",198,"64sd78f5465sda4143.jpg",0,0,NULL,NULL,1),
(39,3,"红茶杏仁戚风",139,"64sd78f5465sda411.jpg",0,0,NULL,NULL,1),
(40,3,"迷迭可可戚风",58,"64sd78f5465sda412.jpg",0,0,NULL,NULL,1),


(41,4,"女王大人(加高版)",228,"64sd78f5465sda412.jpg",0,0,NULL,NULL,1),
(42,4,"桔梗",218,"64sd78f5465sda417.jpg",0,0,NULL,NULL,1),
(43,4,"二人",188,"64sd78f5465sda417.jpg",0,0,NULL,NULL,1),
(44,4,"领结",149,"64sd78f5465sda4113.jpg",0,0,NULL,NULL,1),
(45,4,"圣诞树",139,"64sd78f5465sda4117.jpg",0,0,NULL,NULL,1),
(46,4,"皇冠",198,"64sd78f5465sda416.jpg",0,0,NULL,NULL,1),
(47,4,"春天里(加高版)",188,"64sd78f5465sda414.jpg",0,0,NULL,NULL,1),
(48,4,"蓝灰(加高版)",188,"64sd78f5465sda4111.jpg",0,0,NULL,NULL,1),
(49,4,"水泥森林",139,"64sd78f5465sda4119.jpg",0,0,NULL,NULL,1),
(50,4,"蓝粉皇冠",198,"64sd78f5465sda4110.jpg",0,0,NULL,NULL,1),
(51,4,"独角兽世界",258,"64sd78f5465sda4182.jpg",0,0,NULL,NULL,1),
(52,4,"爱心翅膀(加高款)",268,"64sd78f5465sda411.png",0,0,NULL,NULL,1),
(53,4,"森林果实",218,"64sd78f5465sda4116.jpg",0,0,NULL,NULL,1),
(54,4,"羽翼",239,"64sd78f5465sda4120.jpg",0,0,NULL,NULL,1),
(55,4,"寿",239,"64sd78f5465sda4118.jpg",0,0,NULL,NULL,1),
(56,4,"马里奥",158,"64sd78f5465sda4114.jpg",0,0,NULL,NULL,1),
(57,4,"蓝色狂想",218,"64sd78f5465sda4112.jpg",0,0,NULL,NULL,1),
(58,4,"绝地求生",188,"64sd78f5465sda419.jpg",0,0,NULL,NULL,1),
(59,4,"绝地求生(加高版)",218,"64sd78f5465sda418.jpg",0,0,NULL,NULL,1),
(60,7,"曲奇(200g)",48,"64sd78f5465sda4175.jpg",0,0,NULL,NULL,1),
(61,7,"意大利饼干(400g)",78,"64sd78f5465sda41103.jpg",0,0,NULL,NULL,1),
(62,7,"蛋黄酥(六枚装)",48,"64sd78f5465sda4121.jpg",0,0,NULL,NULL,1),
(63,7,"雪花酥(270g)",48,"64sd78f5465sda41105.jpg",0,0,NULL,NULL,1),
(64,7,"蔓越莓软曲奇(300g)",68,"64sd78f5465sda416.png",0,0,NULL,NULL,1),
(65,7,"黑巧软曲奇(300g)",68,"64sd78f5465sda412.png",0,0,NULL,NULL,1),
(66,7,"咖啡曲奇杏仁片(400g)",68,"64sd78f5465sda413.png",0,0,NULL,NULL,1),
(67,7,"蔓越莓牛轧糖饼干(400g)",108,"64sd78f5465sda415.png",0,0,NULL,NULL,1),
(68,7,"蔓越莓曲奇(400g)",88,"64sd78f5465sda4173.jpg",0,0,NULL,NULL,1),
(69,5,"MICKEY",398,"64sd78f5465sda4178.jpg",0,0,NULL,NULL,1),
(70,5,"小飞象",228,"64sd78f5465sda4195.jpg",0,0,NULL,NULL,1),
(71,5,"lron Man",218,"64sd78f5465sda4177.jpg",0,0,NULL,NULL,1),
(72,6,"冰雪奇缘",728,"64sd78f5465sda4145.jpg",0,0,NULL,NULL,1),
(73,6,"漫威世界",668,"64sd78f5465sda4148.jpg",0,0,NULL,NULL,1),
(74,6,"跨越无人区",688,"64sd78f5465sda4147.jpg",0,0,NULL,NULL,1),
(75,8,"和果实",28,"sdfsdf156.jpg",0,0,NULL,NULL,1),
(76,8,"香橙",58,"456456yfgh.jpg",0,0,NULL,NULL,1),
(77,8,"冷卒 300ml",45,"sd456456456.jpg",0,0,NULL,NULL,1),
(78,10,"如山如海·男生礼盒",518,"sd456456456.jpg",0,0,NULL,NULL,1),
(79,10,"奔向自然",45,"sd456456456.jpg",0,0,NULL,NULL,1),
(80,10,"情书",168,"124235345ijij.jpg",0,0,NULL,NULL,1),
(81,11,"数字蜡烛",2,"shzi234234.jpg",0,0,NULL,NULL,1),
(82,11,"生日帽",8,"shrm111.jpg",0,0,NULL,NULL,1),
(83,11,"保温袋",15,"baoxiandai555.jpg",0,0,NULL,NULL,1)





 /*sid INT PRIMARY KEY AUTO_INCREMENT,
  pid INT,                                                 #商品的id
  size VARCHAR(16),                                        #尺寸
  price DECIMAL(10,2),                                       #价格
  is_state BOOLEAN,                                        #状态(预定:0,现货:1)
  style VARCHAR(32),                                       #商品款式
  fruit VARCHAR(32),                                       #水果
  else_message VARCHAR(36),                                #其他的信息(其他无法归类的)
  repertory INT DEFAULT 0                                  #商品库存(默认0)*/


/*商品规格*/
INSERT INTO cake_spec value
(NULL,1,"4寸",108,-1,NULL,"芒果",NULL,97), 
(NULL,1,"5寸",139,-1,NULL,"芒果",NULL,97), 
(NULL,1,"6寸",188,-1,NULL,"芒果",NULL,97),
(NULL,1,"8寸",268,-1,NULL,"芒果",NULL,97),
(NULL,2,"6寸",108,-1,NULL,"芒果",NULL,97),
(NULL,2,"8寸",268,-1,NULL,"芒果",NULL,97),
(NULL,2,"10寸",328,-1,NULL,"芒果",NULL,97),
(NULL,2,"6寸",108,-1,NULL,"水蜜桃",NULL,100),
(NULL,2,"8寸",268,-1,NULL,"水蜜桃",NULL,100),
(NULL,2,"10寸",328,-1,NULL,"水蜜桃",NULL,100),
(NULL,3,"6寸",228,-1,NULL,NULL,NULL,97),
(NULL,3,"8寸",308,-1,NULL,NULL,NULL,97),
(NULL,4,"6寸",188,-1,NULL,NULL,NULL,97),
(NULL,4,"8寸",268,-1,NULL,NULL,NULL,97),
(NULL,5,"5寸",188,-1,NULL,",芒果",NULL,97),
(NULL,5,"8寸",318,-1,NULL,"芒果",NULL,97),
(NULL,5,"5寸",188,-1,NULL,"香蕉",NULL,97),
(NULL,5,"8寸",318,-1,NULL,"香蕉",NULL,97),
(NULL,5,"5寸",188,-1,NULL,"水蜜桃",NULL,97),
(NULL,5,"8寸",318,-1,NULL,"水蜜桃",NULL,97),
(NULL,6,"5寸",158,-1,NULL,"芒果",NULL,97),
(NULL,6,"8寸",288,-1,NULL,"芒果",NULL,97),
(NULL,7,"5寸",139,-1,NULL,"草莓",NULL,97),
(NULL,7,"8寸",268,-1,NULL,"草莓",NULL,97),
(NULL,8,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,8,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,9,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,9,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,10,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,10,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,10,"10寸",358,-1,NULL,NULL,NULL,97),
(NULL,11,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,11,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,12,"6寸",188,-1,NULL,NULL,NULL,97),
(NULL,12,"8寸",268,-1,NULL,NULL,NULL,97),
(NULL,13,"6寸",188,-1,NULL,"芒果",NULL,97),
(NULL,13,"8寸",268,-1,NULL,"芒果",NULL,97),
(NULL,13,"6寸",188,-1,NULL,"水蜜桃",NULL,97),
(NULL,13,"8寸",268,-1,NULL,"水蜜桃",NULL,97),
(NULL,14,"6寸",188,-1,NULL,NULL,NULL,97),
(NULL,14,"8寸",268,-1,NULL,NULL,NULL,97),
(NULL,14,"10寸",328,-1,NULL,NULL,NULL,97),
(NULL,15,"6寸",188,-1,NULL,"芒果",NULL,97),
(NULL,15,"8寸",268,-1,NULL,"芒果",NULL,97),
(NULL,15,"6寸",188,-1,NULL,"水蜜桃",NULL,97),
(NULL,15,"8寸",268,-1,NULL,"水蜜桃",NULL,97),
(NULL,17,"5寸",218,-1,"粉色款","芒果",NULL,97),
(NULL,17,"6寸",268,-1,"粉色款","芒果",NULL,97),
(NULL,17,"5寸",218,-1,"粉色款","荔枝",NULL,97),
(NULL,17,"6寸",268,-1,"粉色款","荔枝",NULL,97),
(NULL,17,"5寸",218,-1,"粉色款","水蜜桃",NULL,97),
(NULL,17,"6寸",268,-1,"粉色款","水蜜桃",NULL,97),
(NULL,17,"5寸",218,-1,"粉色款","香蕉",NULL,97),
(NULL,17,"6寸",268,-1,"粉色款","香蕉",NULL,97),
(NULL,17,"5寸",218,-1,"绿色款","芒果",NULL,97),
(NULL,17,"6寸",268,-1,"绿色款","芒果",NULL,97),
(NULL,17,"5寸",218,-1,"绿色款","荔枝",NULL,97),
(NULL,17,"6寸",268,-1,"绿色款","荔枝",NULL,97),
(NULL,17,"5寸",218,-1,"绿色款","水蜜桃",NULL,97),
(NULL,17,"6寸",268,-1,"绿色款","水蜜桃",NULL,97),
(NULL,17,"5寸",218,-1,"绿色款","香蕉",NULL,97),
(NULL,17,"6寸",268,-1,"绿色款","香蕉",NULL,97),
(NULL,18,"6寸",228,-1,NULL,NULL,NULL,97),
(NULL,19,"6寸",268,-1,NULL,"芒果",NULL,97),
(NULL,19,"8寸",398,-1,NULL,"芒果",NULL,97),
(NULL,19,"6寸",268,-1,NULL,"荔枝",NULL,97),
(NULL,19,"8寸",398,-1,NULL,"荔枝",NULL,97),
(NULL,19,"6寸",268,-1,NULL,"香蕉",NULL,97),
(NULL,19,"8寸",398,-1,NULL,"香蕉",NULL,97),
(NULL,19,"6寸",268,-1,NULL,"水蜜桃",NULL,97),
(NULL,19,"8寸",398,-1,NULL,"水蜜桃",NULL,97),
(NULL,20,"6寸",258,-1,NULL,NULL,NULL,97),
(NULL,20,"8寸",398,-1,NULL,NULL,NULL,97),
(NULL,21,"6寸",198,-1,NULL,NULL,NULL,97),
(NULL,21,"8寸",298,-1,NULL,NULL,NULL,97),
(NULL,22,"5寸",468,-1,NULL,"芒果",NULL,97),
(NULL,22,"5寸",468,-1,NULL,"水蜜桃",NULL,97),
(NULL,22,"5寸",468,-1,NULL,"香蕉",NULL,97),
(NULL,23,"6寸",198,-1,NULL,"芒果",NULL,97),
(NULL,23,"8寸",288,-1,NULL,"芒果",NULL,97),
(NULL,23,"6寸",198,-1,NULL,"水蜜桃",NULL,97),
(NULL,23,"8寸",288,-1,NULL,"水蜜桃",NULL,97),
(NULL,23,"6寸",198,-1,NULL,"香蕉",NULL,97),
(NULL,23,"8寸",288,-1,NULL,"香蕉",NULL,97),
(NULL,24,"6寸",198,-1,NULL,NULL,NULL,97),
(NULL,24,"8寸",278,-1,NULL,NULL,NULL,97),
(NULL,25,"5寸",139,-1,NULL,"芒果",NULL,97),
(NULL,25,"6寸",188,-1,NULL,"芒果",NULL,97),
(NULL,25,"5寸",139,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,25,"6寸",188,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,25,"5寸",139,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,25,"6寸",188,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,26,"5寸",218,-1,NULL,"芒果",NULL,97),
(NULL,26,"6寸",268,-1,NULL,"芒果",NULL,97),
(NULL,26,"5寸",218,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,26,"6寸",268,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,26,"5寸",218,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,26,"6寸",268,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,27,"5寸",268,-1,NULL,"芒果戚风",NULL,97),
(NULL,27,"6寸",318,-1,NULL,"芒果戚风",NULL,97),
(NULL,27,"5寸",268,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,27,"6寸",318,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,27,"5寸",268,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,27,"6寸",318,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,28,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,28,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,29,"六枚装",108,-1,NULL,NULL,NULL,97),
(NULL,30,"6寸",218,-1,NULL,"芒果",NULL,97),
(NULL,30,"8寸",298,-1,NULL,"芒果",NULL,97),
(NULL,30,"6寸",218,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,30,"8寸",298,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,30,"6寸",218,-1,NULL,"香蕉",NULL,97),
(NULL,30,"8寸",298,-1,NULL,"香蕉",NULL,97),
(NULL,31,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,31,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,32,"6寸",218,-1,NULL,NULL,NULL,97),
(NULL,32,"8寸",298,-1,NULL,NULL,NULL,97),
(NULL,33,"6寸",208,-1,NULL,NULL,NULL,97),
(NULL,33,"8寸",288,-1,NULL,NULL,NULL,97),
(NULL,34,"6寸",198,-1,NULL,NULL,NULL,97),
(NULL,34,"8寸",278,-1,NULL,NULL,NULL,97),
(NULL,35,"6寸",198,-1,NULL,NULL,NULL,97),
(NULL,35,"8寸",278,-1,NULL,NULL,NULL,97),
(NULL,36,"6寸",198,-1,NULL,NULL,NULL,97),
(NULL,36,"8寸",278,-1,NULL,NULL,NULL,97),
(NULL,37,"5寸",168,-1,NULL,NULL,NULL,97),
(NULL,38,"如图款",198,-1,NULL,NULL,NULL,97),
(NULL,39,"5寸",139,-1,NULL,NULL,NULL,97),
(NULL,40,"4寸",58,-1,NULL,NULL,NULL,97),
(NULL,41,"6寸",228,-1,NULL,"芒果",NULL,97),
(NULL,41,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,41,"6寸",228,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,41,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,41,"6寸",228,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,41,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,42,"6寸",288,-1,NULL,"芒果",NULL,97),
(NULL,42,"8寸",388,-1,NULL,"芒果",NULL,97),
(NULL,42,"6寸",288,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,42,"8寸",388,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,42,"6寸",288,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,42,"8寸",388,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,43,"6寸",228,-1,NULL,"芒果",NULL,97),
(NULL,43,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,43,"6寸",228,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,43,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,43,"6寸",228,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,43,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,44,"6寸",198,-1,NULL,"芒果",NULL,97),
(NULL,44,"8寸",288,-1,NULL,"芒果",NULL,97),
(NULL,44,"6寸",198,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,44,"8寸",288,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,44,"6寸",198,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,44,"8寸",288,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,45,"5寸",168,-1,NULL,"芒果",NULL,97),
(NULL,45,"6寸",218,-1,NULL,"芒果",NULL,97),
(NULL,45,"5寸",168,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,45,"6寸",218,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,45,"5寸",168,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,45,"6寸",218,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,46,"6寸",239,-1,NULL,"芒果",NULL,97),
(NULL,46,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,46,"6寸",239,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,46,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,46,"6寸",239,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,46,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,47,"6寸",228,-1,NULL,"芒果",NULL,97),
(NULL,47,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,47,"6寸",228,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,47,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,47,"6寸",228,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,47,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,48,"6寸",228,-1,NULL,"芒果",NULL,97),
(NULL,48,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,48,"6寸",228,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,48,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,48,"6寸",228,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,48,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,49,"6寸",198,-1,NULL,"芒果",NULL,97),
(NULL,49,"8寸",288,-1,NULL,"芒果",NULL,97),
(NULL,49,"6寸",198,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,49,"8寸",288,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,49,"6寸",198,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,49,"8寸",288,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,50,"6寸",239,-1,NULL,"芒果",NULL,97),
(NULL,50,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,50,"6寸",239,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,50,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,50,"6寸",239,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,50,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,51,"6寸",258,-1,NULL,"芒果",NULL,97),
(NULL,51,"8寸",339,-1,NULL,"芒果",NULL,97),
(NULL,51,"6寸",258,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,51,"8寸",339,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,51,"6寸",258,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,51,"8寸",339,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,52,"6寸",268,-1,NULL,"芒果",NULL,97),
(NULL,52,"8寸",339,-1,NULL,"芒果",NULL,97),
(NULL,52,"6寸",268,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,52,"8寸",339,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,52,"6寸",268,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,52,"8寸",339,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,53,"6寸",218,-1,NULL,"芒果",NULL,97),
(NULL,53,"8寸",298,-1,NULL,"芒果",NULL,97),
(NULL,53,"6寸",218,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,53,"8寸",298,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,53,"6寸",218,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,53,"8寸",298,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,54,"5寸",239,-1,NULL,"芒果",NULL,97),
(NULL,54,"6寸",308,-1,NULL,"芒果",NULL,97),
(NULL,54,"5寸",239,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,54,"6寸",308,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,54,"5寸",239,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,54,"6寸",308,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,55,"6寸",239,-1,NULL,"芒果",NULL,97),
(NULL,55,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,55,"6寸",239,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,55,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,55,"6寸",239,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,55,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,56,"6寸",208,-1,NULL,"芒果",NULL,97),
(NULL,56,"8寸",288,-1,NULL,"芒果",NULL,97),
(NULL,56,"6寸",208,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,56,"8寸",288,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,56,"6寸",208,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,56,"8寸",288,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,57,"5寸",218,-1,NULL,"芒果",NULL,97),
(NULL,57,"6寸",268,-1,NULL,"芒果",NULL,97),
(NULL,57,"5寸",218,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,57,"6寸",268,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,57,"5寸",218,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,57,"6寸",268,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,58,"6寸",239,-1,NULL,"芒果",NULL,97),
(NULL,58,"8寸",328,-1,NULL,"芒果",NULL,97),
(NULL,58,"6寸",239,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,58,"8寸",328,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,58,"6寸",239,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,58,"8寸",328,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,59,"6寸",258,-1,NULL,"芒果",NULL,97),
(NULL,59,"8寸",349,-1,NULL,"芒果",NULL,97),
(NULL,59,"6寸",258,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,59,"8寸",349,-1,NULL,"澳洲水蜜桃",NULL,97),
(NULL,59,"6寸",258,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,59,"8寸",349,-1,NULL,"菲律宾香蕉",NULL,97),
(NULL,60,"原味",48,0,NULL,NULL,NULL,97),
(NULL,60,"原味",48,1,NULL,NULL,NULL,97),
(NULL,60,"咖啡",48,0,NULL,NULL,NULL,97),
(NULL,60,"咖啡",48,1,NULL,NULL,NULL,97),
(NULL,60,"抹茶",48,0,NULL,NULL,NULL,97),
(NULL,60,"抹茶",48,1,NULL,NULL,NULL,97),
(NULL,61,NULL,48,0,NULL,NULL,NULL,97),
(NULL,61,NULL,48,1,NULL,NULL,NULL,97),
(NULL,62,NULL,85,0,NULL,NULL,NULL,97),
(NULL,62,NULL,85,1,NULL,NULL,NULL,97),
(NULL,63,"三种口味混合装",48,0,NULL,NULL,NULL,97),
(NULL,63,"三种口味混合装",48,1,NULL,NULL,NULL,97),
(NULL,63,"原味",48,0,NULL,NULL,NULL,97),
(NULL,63,"原味",48,1,NULL,NULL,NULL,97),
(NULL,63,"抹茶",58,0,NULL,NULL,NULL,97),
(NULL,63,"抹茶",58,1,NULL,NULL,NULL,97),
(NULL,63,"可可",48,0,NULL,NULL,NULL,97),
(NULL,63,"可可",48,1,NULL,NULL,NULL,97),
(NULL,64,NULL,68,0,NULL,NULL,NULL,97),
(NULL,64,NULL,68,1,NULL,NULL,NULL,97),
(NULL,65,NULL,68,0,NULL,NULL,NULL,97),
(NULL,65,NULL,68,1,NULL,NULL,NULL,97),
(NULL,66,NULL,68,0,NULL,NULL,NULL,97),
(NULL,66,NULL,68,1,NULL,NULL,NULL,97),
(NULL,67,NULL,108,0,NULL,NULL,NULL,97),
(NULL,67,NULL,108,1,NULL,NULL,NULL,97),
(NULL,68,NULL,88,0,NULL,NULL,NULL,97),
(NULL,68,NULL,88,1,NULL,NULL,NULL,97),
(NULL,69,"8寸",398,-1,NULL,"芒果",NULL,97),
(NULL,69,"8寸",398,-1,NULL,"水蜜桃",NULL,97),
(NULL,69,"8寸",398,-1,NULL,"香蕉",NULL,97),
(NULL,69,"8寸",398,-1,NULL,"荔枝",NULL,97),
(NULL,70,"6寸",288,-1,NULL,"芒果",NULL,97),
(NULL,70,"8寸",388,-1,NULL,"芒果",NULL,97),
(NULL,70,"6寸",288,-1,NULL,"荔枝",NULL,97),
(NULL,70,"8寸",388,-1,NULL,"荔枝",NULL,97),
(NULL,70,"6寸",288,-1,NULL,"水蜜桃",NULL,97),
(NULL,70,"8寸",388,-1,NULL,"水蜜桃",NULL,97),
(NULL,71,"6寸",268,-1,NULL,"芒果",NULL,97),
(NULL,71,"8寸",368,-1,NULL,"芒果",NULL,97),
(NULL,71,"6寸",268,-1,NULL,"香蕉",NULL,97),
(NULL,71,"8寸",368,-1,NULL,"香蕉",NULL,97),
(NULL,71,"6寸",268,-1,NULL,"水蜜桃",NULL,97),
(NULL,71,"8寸",368,-1,NULL,"水蜜桃",NULL,97),
(NULL,72,"8+6寸",728,-1,NULL,"芒果",NULL,97),
(NULL,72,"8+6寸",728,-1,NULL,"水蜜桃",NULL,97),
(NULL,72,"8+6寸",728,-1,NULL,"香蕉",NULL,97),
(NULL,73,"8+6寸",668,-1,NULL,"芒果",NULL,97),
(NULL,73,"8+6寸",668,-1,NULL,"香蕉",NULL,97),
(NULL,73,"8+6寸",668,-1,NULL,"水蜜桃",NULL,97),
(NULL,74,"8+6寸",668,-1,NULL,"芒果",NULL,97),
(NULL,74,"8+6寸",668,-1,NULL,"水蜜桃",NULL,97),
(NULL,74,"8+6寸",668,-1,NULL,"香蕉",NULL,97),
(NULL,75,NULL,28,-1,NULL,NULL,"山野客(薄荷蔓越莓)",97),
(NULL,75,NULL,28,-1,NULL,NULL,"三生(风情椰香)",97),
(NULL,75,NULL,28,-1,NULL,NULL,"柿子(生巧奥利奥)",97),
(NULL,75,NULL,28,-1,NULL,NULL,"蜜桃(蜜桃乌龙)",97),
(NULL,76,"4寸",58,-1,NULL,NULL,NULL,97),
(NULL,77,"默认",45,-1,NULL,NULL,NULL,97),
(NULL,78,"六寸山海蛋糕+红葡萄酒",518,-1,NULL,NULL,NULL,97),
(NULL,79,"A:5寸树荔枝戚风",218,-1,NULL,NULL,NULL,97),
(NULL,79,"B:迷你甜甜圈礼盒",128,-1,NULL,NULL,NULL,97),
(NULL,80,"默认",168,-1,NULL,NULL,NULL,97),
(NULL,81,"1",2,-1,NULL,NULL,NULL,97),
(NULL,81,"2",2,-1,NULL,NULL,NULL,97),
(NULL,81,"3",2,-1,NULL,NULL,NULL,97),
(NULL,81,"4",2,-1,NULL,NULL,NULL,97),
(NULL,81,"5",2,-1,NULL,NULL,NULL,97),
(NULL,81,"6",2,-1,NULL,NULL,NULL,97),
(NULL,81,"7",2,-1,NULL,NULL,NULL,97),
(NULL,81,"8",2,-1,NULL,NULL,NULL,97),
(NULL,81,"9",2,-1,NULL,NULL,NULL,97),
(NULL,81,"0",2,-1,NULL,NULL,NULL,97),
(NULL,82,"A款皇冠",8,-1,NULL,NULL,NULL,97),
(NULL,82,"B款红色小熊",12,-1,NULL,NULL,NULL,97),
(NULL,82,"C款蓝色松鼠",12,-1,NULL,NULL,NULL,97),
(NULL,83,"4寸",15,-1,NULL,NULL,NULL,97),
(NULL,83,"6寸",18,-1,NULL,NULL,NULL,97),
(NULL,83,"8寸",20,-1,NULL,NULL,NULL,97),
(NULL,83,"10寸",22,-1,NULL,NULL,NULL,97)















/** 商品家族(分类) **/
INSERT INTO cake_catalogue VALUE
(1,"蛋糕","经典系列",NULL),
(2,"蛋糕","当季新款",NULL),
(3,"蛋糕","MINI系列",NULL),
(4,"蛋糕","成人系列",NULL),
(5,"蛋糕","童真系列",NULL),
(6,"蛋糕","多重蛋糕",NULL),
(7,"小食","饼干小食",NULL),
(8,"甜点","当日甜点",NULL),
(9,"甜点","蛋糕卷",NULL),
(10,"礼盒","节日礼盒",NULL),
(11,"生日配件","生日配件",NULL),
(12,"积分换购","NULL",NULL),
(13,"甜品台布置","NULL",NULL),
(14,"周末半价日","周末半价",NULL);














/** 图片表(详情表) **/
INSERT INTO cake_pic VALUE
(NULL,1,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,2,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,3,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,4,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,5,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,6,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,7,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,8,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,9,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,10,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,11,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,12,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,13,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,14,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,15,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,16,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,17,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,18,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,19,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,20,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,21,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,22,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,23,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,24,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,25,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,26,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,27,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,28,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,29,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,30,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,31,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,32,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,33,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,34,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,35,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,36,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,37,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,38,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,39,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,40,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,41,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,42,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,43,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,44,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,45,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,46,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,47,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,48,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,49,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,50,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,51,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,52,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,53,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,54,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,55,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,56,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,57,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,58,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,59,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,60,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,61,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,62,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,63,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,64,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,65,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,66,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,67,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,68,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,69,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,70,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,71,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,72,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,73,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,74,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,75,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,76,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,77,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,78,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,79,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,80,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,81,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,82,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,83,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,84,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,85,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,86,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,87,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,88,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,89,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,90,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,91,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,92,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,93,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,94,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,95,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,96,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,97,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,98,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,99,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,100,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,101,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,102,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,103,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,104,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,105,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,106,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,107,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,108,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,109,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,110,"images/product/64sd78f5465sda4aa1.jpg"),
(NULL,111,"images/product/64sd78f5465sda4aa1.jpg");
