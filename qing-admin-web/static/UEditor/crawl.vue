<template>
	<div >


		<el-form :model="crawlForm" :rules="rules" ref="crawlForm" label-min-width="100px" class="crawlFormbox">
			<p style="text-align:right;color:#999;font-size:12px;padding-right:5px;">已输入<span style="color:#666;">{{imUrlNum}}</span>条,一次最多采集200条数据</p>
			<el-form-item prop="imUrl" style="margin-bottom:12px;">
				<el-input type="textarea" v-model="crawlForm.imUrl" prop="imUrl" placeholder="温馨提示：一次最多采集200条数据"></el-input>
			</el-form-item>
			
			<div style="margin-top:10px;overflow:hidden;">
				<span style="color:#666;font-size:12px;padding:10px 0;display:inline-block;">温馨提示：支持淘宝，天猫，京东，速卖通，1688，多个url用【Enter】键隔开，分类采集，请<a href="http://amzerp.oss-cn-hongkong.aliyuncs.com/collectionPlug/datacrawl.zip?Expires=1873278894&OSSAccessKeyId=LTAIXRQdF1zxVJls&Signature=fFBqbXyOxqtmD42BPxYAIliSbpM%3D">下载插件</a>
					<!-- 多个url用<b class="red">【Enter键】</b>隔开 -->
				</span>
				<span style="float:right;">
					<el-button v-if="isLevelBtn('pro_btn_crawl')"  :disabled="!isAuthority('pro_btn_crawl')" type="primary" @click="submitForm(crawlForm.imUrl)" size="medium">开始采集</el-button>
					<el-button @click="resetForm()" size="medium">清空</el-button>
				</span>

			</div>

		</el-form>
		<seach-form :search-type-data="searchTypeData" @on-search="onSearch"></seach-form>

		<div class="table_btnbox">
			
			<el-button type="primary" size="medium" class="primary_box" @click="batchclaimProductFn()" :disabled="!isAuthority('pro_btn_rl')"  v-if="isLevelBtn('pro_btn_rl')">批量认领</el-button>
			<el-button size="medium" type="primary" @click="batchEditFn" v-if="isLevelBtn('pro_btn_edit')" :disabled="!isAuthority('pro_btn_edit')">批量编辑</el-button>
			<el-button size="medium" @click="batchdelFn" v-if="isLevelBtn('pro_btn_del')" :disabled="!isAuthority('pro_btn_del')">批量删除</el-button>
			<!-- v-if="isLevelBtn('pro_amz_export')" :disabled="!isAuthority('pro_amz_export')" -->
			<div class="table_btn">
				<el-dropdown>
					<span class="el-dropdown-link">
					<el-button size="medium" type="primary" plain>导出<i class="el-icon-arrow-down el-icon--right"></i></el-button>
				</span>
					<el-dropdown-menu slot="dropdown"> 
						<el-dropdown-item  @click.native="formexportFn(item.id)" v-for="item in epagelist" :key="item.id" >{{item.name}}</el-dropdown-item>
					</el-dropdown-menu>
				</el-dropdown>
			</div>

		</div>
		<el-form :model="formSearch" ref="formSearch" :action="exportUrl" id="formexport" method="post">
			<input name="token" v-model="formSearch.token" style="display:none;" />
			<input name="productIds" v-model="multipleSelection" style="display:none;" />
			<input name="status" v-model="formSearch.status" style="display:none;" />
			<input name="keyword" v-model="formSearch.keyword" style="display:none;" />
			<input name="pageSize" v-model="epageSize" style="display:none;" />
			<input name="pageNum" v-model="epageNum" style="display:none;" />
		</el-form>
		</div>

		<el-col :span="24">
			<el-tabs v-model="formSearch.status" @tab-click="handleClick">
				<el-tab-pane name="" :label="'全部'+'('+ statusCount +')'"></el-tab-pane>
				<el-tab-pane v-for="item in statusList" :key="item.value" :name="item.value" :label="item.label+'('+ item.count +')'"></el-tab-pane>
			</el-tabs>
		</el-col>

		<el-table class="tablebox" ref="multipleTable" :data="tableData" tooltip-effect="dark" @selection-change="handleSelectionChange">
			<el-table-column type="selection" min-width="30%">
			</el-table-column>
			<el-table-column prop="imgSku1" label="图片" min-width="80%">
				<template slot-scope="scope">
					<thumbnails :thumbnail-img="scope.row.imgSku1" :thumbnail-id="scope.row.productId" :img-index="imgIndex" @get-index="getIndexFn"></thumbnails>
					<p style="margin-top:5px;text-align:center;">
						<a :href="scope.row.sourceUrl" target="_blank" style="cursor:pointer;">{{scope.row.sourceName}}</a>
					</p>
				</template>
			</el-table-column>
			<el-table-column prop="productTitle" label="标题" min-width="160%">
				<template slot-scope="scope">
					<p style="margin-top:5px;">
						<a :href="scope.row.sourceUrl" target="_blank" style="cursor:pointer;">{{scope.row.productTitle}}</a>
					</p>
				</template>
			</el-table-column>
			<el-table-column prop="productDesc" label="描述" min-width="260%">
				<template slot-scope="scope">
					<div class="outer4">{{scope.row.productDesc}}</div>
				</template>
			</el-table-column>
			<el-table-column prop="productPrice" label="售价" min-width="80%">
				<template slot-scope="scope">
					<div>{{scope.row.productPrice!==""&&Number(scope.row.productPrice)!==0?'$'+scope.row.productPrice.toFixed(2):'0'}}</div>
				</template>
			</el-table-column>
			<el-table-column prop="claimRecord" label="记录状态" min-width="120%" v-if="tabIndex!=='1'?true:false">
				<template slot-scope="scope">
					<div>
						<el-tag type="success" v-if="scope.row.claimRecord!==''">已认领</el-tag>
						<el-tag type="info" v-if="scope.row.claimRecord==''">未认领</el-tag>
					</div>
				</template>
			</el-table-column>

			<el-table-column label="操作" min-width="140%">
				<template slot-scope="scope">

					<!-- <el-button size="mini">认领到</el-button>
				<el-button  size="mini" type="primary" >添加备注</el-button> -->
					<!-- <div style="margin-bottom:10px;">
					<el-button size="mini" type="primary" plain @click="editDataFn('2',scope.row.productId)"><i class="el-icon-edit"></i></el-button>
					<el-button size="mini" type="primary" plain @click="delFn(scope.row.productId)"><i class="el-icon-delete"></i></el-button>
				</div> -->
					<div class="table_btn" v-if="isLevelBtn('pro_btn_rl')">
						<el-button size="medium" type="primary" plain @click="submitCliam(scope.row.productId)" :disabled="!isAuthority('pro_btn_rl')" >认领</el-button>
					</div>
					<div class="table_btn">
						<el-dropdown>
							<span class="el-dropdown-link">
							<el-button size="medium" type="primary" plain>更多<i class="el-icon-arrow-down el-icon--right"></i></el-button>
						</span>
							<el-dropdown-menu slot="dropdown"> 
								<el-dropdown-item v-if="isLevelBtn('pro_btn_edit')" :disabled="!isAuthority('pro_btn_edit')" @click.native="editDataFn('2',scope.row.productId)">编辑</el-dropdown-item>
								<el-dropdown-item v-if="isLevelBtn('pro_btn_del')" :disabled="!isAuthority('pro_btn_del')" @click.native="submitDel(scope.row.productId)">删除</el-dropdown-item>
								<!-- <el-dropdown-item v-if="isLevelBtn('pro_btn_remark')">备注</el-dropdown-item> -->

							</el-dropdown-menu>
						</el-dropdown>
					</div>

				</template>
			</el-table-column>
		</el-table>
		<div class="block page">
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page.sync="currentPage1" :page-sizes="pageSizes" :page-size="pageSize" :layout="pageLayout" :total="totalNum">
			</el-pagination>
		</div>

		<el-dialog :visible.sync="crawlVisible"  title="数据采集" width="600px" @close="closeFn">
            <div class="crawlresult">
				<dl>
					<dt>采集任务完成，共采集<span>{{allNum}}</span>个url</dt>
					<dd>成功<span class="success_i">{{successNum}}</span>个</dd>
					<dd>失败<span class="fail_i">{{failNum}}</span>个</dd>
				</dl>
				<dl v-show="failUrl.length>0">
					<dt>抓取失败url</dt>
					<dd v-for="(url,index) in failUrl" :key="index" v-text="index+1+'：'+url"></dd>
				</dl>
				
				<el-button type="primary" @click="closeFn" style="margin-top:10px;"> 关闭</el-button>
			</div>
			
        </el-dialog>

		<div v-show="loadcrawlVisible" class="bounbox"> 
			<div class="bounbos">
				<img src="../../assets/img/load.gif">
					<div>正在采集，请稍后...</div>
				</div>
		</div>
		<el-dialog title="批量编辑产品" width="80%" :visible.sync="batchEditShow">
			<div class="edit_table">
				<ul>
					<li>标题</li>
					<li>描述</li>
					<li>售价</li>
				</ul>
				<ul v-for="item in tableEdit" :key="item.productId">
					<li>
						<el-input type="textarea" v-model="item.productTitle"></el-input>
						<p v-if="item.productTitle==''" class='edithint'>请填写标题</p>
					</li>
					<li>
						<el-input type="textarea" v-model="item.productDesc"></el-input>
						<p v-if="item.productDesc==''" class='edithint'>请填写描述</p>
					</li>
					<li>
						<el-input type="textarea" v-model="item.productPrice"></el-input>
						<p v-if="item.productPrice==''" class='edithint'>请填写价格</p>
						<p v-if="item.productPrice=='0'||(!$checkPrice(item.productPrice))" class='edithint'>价格需是大于0的数字，最多保留两位小数</p>
					</li>
				</ul>

			</div>
			
			<div slot="footer" class="dialog-footer">
				<el-button @click="batchEditShow = false">取 消</el-button>
				<el-button type="primary" @click="submitBatchEdit()">确 定</el-button>
			</div>
		</el-dialog>

	</div>
</template>

<script src="@/api/componentExport/product/crawl.js"></script>