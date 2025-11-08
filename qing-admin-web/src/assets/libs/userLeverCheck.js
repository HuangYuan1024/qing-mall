$(function() {
	$(".submitBtn").click(function() {
		$("#submit").click();
	})
	$("#LevelMenu").on("click", "li", function() {
		$("#title").text($(this).text())
	});
	$("#LevelMenu").on("click", "li", function() {
		$(this).addClass("active").siblings().removeClass("active");
	})
	//当前tab全选
	$("#LevelMenuIds").on("change", "input[name='r_menu2']", function() {
		if($(this).prop("checked")) {
			$(this).parent().addClass("on")
			$(this).parent().parent().siblings(".navClassC").find("input[type='checkBox']").prop("checked", true).parent("span").addClass("on");
		} else {
			$(this).parent().removeClass("on")
			$(this).parent().parent().siblings(".navClassC").find("input[type='checkBox']").prop("checked", false).parent("span").removeClass("on");
		}
	});
	//次级全选取消功能
	$("#LevelMenuIds").on("change", "input[name='r_menu3']", function() {
		if($(this).prop("checked")) {
			$(this).parent().addClass("on")
			$(this).parent().siblings(".navClassBtn").find("input[name='r_btn']").prop("checked", true).parent("span").addClass("on");
			$(this).parents(".nav_list").find(".navClassB").find("input[type='checkBox']").prop("checked", true).parent("span").addClass("on");
			/*var r_menu2Length = $(this).parents(".nav_list").find("input[name='r_menu3']").length;
			var checkedR_menu2Length = $(this).parents(".nav_list").find("input[name='r_menu3']:checked").length;
			if(r_menu2Length == checkedR_menu2Length) {
				$(this).parents(".nav_list").find(".navClassB").find("input[type='checkBox']").prop("checked", true).parent("span").addClass("on");

			}*/
		} else {
			$(this).parent().removeClass("on")
			$(this).parent().siblings(".navClassBtn").find("input[name='r_btn']").prop("checked", false).parent("span").removeClass("on");
			//$(this).parents(".navClassC").siblings(".navClassB").find("input[name='r_menu2']").prop("checked", false).parent("span").removeClass("on");
		}
	});
	//btn取消功能
	$("#LevelMenuIds").on("change", "input[name='r_btn']", function() {
		if($(this).prop("checked")) {
			$(this).parent().addClass("on")
			//var BoxLength = $(this).parent().siblings(".navClassBtn").find("input[name='r_btn']").length;
			var checkedBoxLength = $(this).parent().siblings(".navClassBtn").find("input[name='r_btn']:checked").length;

			//  $(this).parents(".navClassBtn").siblings(".checkBox").find("input[name='r_menu3']").prop("checked", true).parent("span").addClass("on");
			if(checkedBoxLength >= 0) {
				$(this).parents(".navClassC").siblings(".navClassB").find("input[name='r_menu2']").prop("checked", true).parent("span").addClass("on");
				$(this).parents(".navClassBtn").siblings(".checkBox").find("input[name='r_menu3']").prop("checked", true).parent("span").addClass("on");
				$(this).parents(".nav_list").find(".navClassB").find("input[type='checkBox']").prop("checked", true).parent("span").addClass("on");
			}
			//var r_menu2Length = $(this).parents(".nav_list").find("input[name='r_menu3']").length;
			/*var checkedR_menu2Length = $(this).parents(".nav_list").find("input[name='r_menu3']:checked").length;
			if(r_menu2Length == checkedR_menu2Length) {
				$(this).parents(".nav_list").find(".navClassB").find("input[type='checkBox']").prop("checked", true).parent("span").addClass("on");

			}*/
		} else {
			$(this).parent().removeClass("on")
			/*$(this).parents(".nav_list").find(".navClassB").find("input[type='checkBox']").prop("checked", false).parent("span").removeClass("on");
			$(this).parents(".navClassBtn").siblings(".checkBox").find("input[name='r_menu3']").prop("checked", false).parent("span").removeClass("on");*/
		}
	});
})