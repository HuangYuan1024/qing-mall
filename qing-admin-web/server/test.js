var list=[
    {
        auditRuleType: "0",
        avertCarryingCapacityStatus: "off",
        avertCarryingCapacityTolerance: "30",
        avertFlySheetAuditTime: "1",
        flySheetAuditTolerance: "30",
        nodeId: "1",
        nodeName: "文达智通技术有限公司",
        nodeType: "M",
        nodeTypeName: "集团",
        parentId: "0",
        parentName: "",
        sort: "0",
    },{
        auditRuleType: "1",
        avertCarryingCapacityStatus: "on",
        avertCarryingCapacityTolerance: "0",
        avertFlySheetAuditTime: "1",
        flySheetAuditTolerance: "0",
        nodeId: "2",
        nodeName: "测试一",
        nodeType: "C",
        nodeTypeName: "区域",
        parentId: "1",
        parentName: "",
        sort: "0",
    },{
        auditRuleType: "0",
        avertCarryingCapacityStatus: "on",
        avertCarryingCapacityTolerance: "0",
        avertFlySheetAuditTime: "1",
        flySheetAuditTolerance: "0",
        nodeId: "4",
        nodeName: "融创",
        nodeType: "M",
        nodeTypeName: "集团",
        parentId: "0",
        parentName: "",
        sort: "0",
    },{
        auditRuleType: "0",
        avertCarryingCapacityStatus: "on",
        avertCarryingCapacityTolerance: "60",
        avertFlySheetAuditTime: "2",
        flySheetAuditTolerance: "20",
        nodeId: "5",
        nodeName: "郑州",
        nodeType: "C",
        nodeTypeName: "区域",
        parentId: "4",
        parentName: "",
        sort: "0",
    }
]
function $cascadervalueFn(data,nodeId){//商品分类获取的时候重组数组，选中选项
    var that=this;
    var cascaderType=[nodeId]
    var parentId=""
    for(var i=0;i<data.length;i++){//获取到父级Id
        if(data[i].nodeId==nodeId){
            parentId=data[i].parentId
        }
    }
    loop()
    function loop(){
        if(parentId!=="0"){
            cascaderType.unshift(parentId)
            for(var i=0;i<data.length;i++){
                if(data[i].nodeId==parentId){
                    parentId=data[i].parentId
                    if(parentId!=="0"){
                        loop()
                    }
                }
            }
        }
    }   
}
$cascadervalueFn(list,"5")
