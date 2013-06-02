$(function() {
	var deletedTodayFull = $(".deleted-today-full");
	deletedTodayFull.hide();

	var btnUndelete = $(".btn-undelete");
	btnUndelete.attr("disabled", true);
	
	$(".deleted-today-oneline").show();
	$(".deleted-today-oneline a").click(function() {
		$(this).hide();
		deletedTodayFull.show();
	});

	$(".deleted-today-oneline a.just-deleted").animate({ backgroundColor: "white", color: "gray" }, 1000);
	
	$(".checkbox-undelete").click(function() {
		if ($(".checkbox-undelete:checked").length > 0) {
			btnUndelete.attr("disabled", false);
		} else {
			btnUndelete.attr("disabled", true);
		}
	});
});