<!--产品，加购，心愿单详情-->
<template>
  <div>
    <el-card>
      <ul class="detailbox detailbox1">
        <h4>订单信息</h4>
        <li>
          <span>单号：</span>
          <p v-text="infoDetail.orderCode"></p>
        </li>
        <li>
          <span>下单人：</span>
          <p v-text="infoDetail.username"></p>
        </li>
        <li>
          <span>订单状态：</span>
          <p>{{infoDetail.orderStatus|orderStatusFn }}</p>
        </li>
        <li>
          <span>下单时间：</span>
          <p v-text="infoDetail.createTime"></p>
        </li>
        <li style="width:100%;">
          <span>产品名称：</span>
          <p v-text="infoDetail.productName"></p>
        </li>
        <li>
          <span>产品规格：</span>
          <p v-text="infoDetail.productPara"></p>
        </li>
		 <li>
          <span>下单数量：</span>
          <p v-text="infoDetail.totalNum"></p>
        </li>
        <li>
          <span>优惠金额：</span>
          <p v-text="'￥'+infoDetail.preMoney"></p>
        </li>
        <li>
          <span>金额合计：</span>
          <p v-text="infoDetail.totalMoney"></p>
        </li>
       
        <li>
          <span>交易完成时间：</span>
          <p v-text="infoDetail.endTime"></p>
        </li>
      </ul>
	  <ul class="detailbox detailbox1">
        <h4>支付信息</h4>
        <li>
          <span>支付状态：</span>
          <p>{{infoDetail.payStatus|payStatusFn }}</p>
        </li>
        <li>
          <span>付款时间：</span>
          <p v-text="infoDetail.payTime"></p>
        </li>
        <li>
          <span>支付类型：</span>
          <p>{{infoDetail.payType | payTypeFn }}</p>
        </li>
        <li>
          <span>交易流水号：</span>
          <p v-text="infoDetail.transactionId"></p>
        </li>
        <li>
          <span>实付金额：</span>
          <p v-text="'￥'+infoDetail.payMoney"></p>
        </li>
      </ul>
      <ul class="detailbox detailbox1">
        <h4>物流信息</h4>

        <li>
          <span>收货人：</span>
          <p v-text="infoDetail.receiverContact"></p>
        </li>
        <li>
          <span>收货人手机：</span>
          <p v-text="infoDetail.receiverMobile"></p>
        </li>
        <li>
          <span>收货人地址：</span>
          <p v-text="infoDetail.receiverAddress"></p>
        </li>
        <li>
          <span>物流名称：</span>
          <p v-text="infoDetail.shippingName"></p>
        </li>
        <li>
          <span>物流单号：</span>
          <p v-text="infoDetail.shippingCode"></p>
        </li>
        <li>
          <span>邮费：</span>
          <p v-text="'￥'+infoDetail.postFee"></p>
        </li>
      </ul>
      

      <ul class="detailbox" v-if="infoDetail.buyerRate">
        <h4>评价信息</h4>
        <li>
          <span>买家留言：</span>
          <p v-text="infoDetail.buyerMessage"></p>
        </li>
      </ul>
    </el-card>

    <el-button @click="onBack" class="back">返回</el-button>
  </div>
</template>

<script>
import data from "./data";
export default {
  data() {
    return {
      infoDetail: {}
    };
  },
  created() {
    let { id } = this.$route.query;
    for (let i = 0; i < data.length; i++) {
		console.log(data[i].id)
      if (data[i].id == id) {
		  console.log(i)
		this.infoDetail = data[i];
		console.log(this.infoDetail)
        break;
      }
    }
  },
  filters: {
    orderStatusFn(value) {
      switch (value) {
        case "0":
          return "未完成";
          break;
        case "1":
          return "已完成";
          break;
        case "2":
          return "已退货";
          break;
        default:
          return "";
      }
    },
    orderStatusFn(value) {
      switch (value) {
        case "0":
          return "未完成";
          break;
        case "1":
          return "已完成";
          break;
        case "2":
          return "已退货";
          break;
        default:
          return "";
      }
    },
    payStatusFn(value) {
      switch (value) {
        case "0":
          return "未支付";
          break;
        case "1":
          return "已支付";
          break;
        case "2":
          return "支付失败";
          break;
        default:
          return "";
      }
    },
    payTypeFn(value) {
      switch (value) {
        case "0":
          return "货到付款";
          break;
        case "1":
          return "在线支付";
          break;
        default:
          return "";
      }
    }
  },
  methods: {
    onBack() {
      this.$router.push({
        path: "/order_orderlist"
      });
    }
  }
};
</script>
<style scoped lang="scss">
/*产品详情*/

.detailbox {
  padding: 0;
  margin: 0 0 10px;
  overflow: hidden;
  h4 {
    font-weight: normal;
    font-size: 16px;
    clear: both;
    line-height: 40px;
    margin-bottom: 10px;
    border-bottom: 1px solid #f5f5f5;
  }
  li {
    list-style: none;
    line-height: 36px;
    overflow: hidden;
    font-size: 14px;
    margin-bottom: 8px;
    span {
      float: left;
    }
    p {
      margin: 0;
      display: inline-block;
      width: calc(100% - 150px);
    }
  }
  &.detailbox1 li {
    width: 49%;
    float: left;
  }
  &.detailbox2 li {
    width: 24%;
    float: left;
  }
}
.back {
  margin-top: 20px;
}
</style>