const pageSizes = [20, 80, 100, 200,500]
const pageSize=20
const pageLayout="total, sizes,prev, pager, next"
function getRandColor() {
	var tem = Math.round(Math.random() * colorListLength)
	return colorList[tem]
}
export default {
	pageSizes,
	pageSize,
	pageLayout,
	getRandColor
}