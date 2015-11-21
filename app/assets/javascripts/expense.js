$(document).ready(function () {
	$('label[for="expense_name"]').hide();
	$('#expense_name').hide();
	$('label[for="expense_sub_category_id"]').hide();
	$('#expense_sub_category_id').hide();
	var sub_categories = $('#expense_sub_category_id').html();
	$('#expense_category_id').change(function () {
		var category = $('#expense_category_id :selected').text();
		var options = $(sub_categories).filter("optgroup[label='" + category + "']").html();
		if (options) {
			$('#expense_sub_category_id').html(options);
			$('label[for="expense_name"]').hide();
			$('#expense_name').hide();
			$('label[for="expense_sub_category_id"]').show();
			$('#expense_sub_category_id').show();
		} else {
			$('label[for="expense_name"]').show();
			$('#expense_name').show();
			$('#expense_sub_category_id').empty();
			$('#expense_sub_category_id').hide();
			$('label[for="expense_sub_category_id"]').hide();
		}
	});
});