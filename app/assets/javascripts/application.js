// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
	$('#search-bar').hide();
	$('#search-button').click(function (event) {
		event.preventDefault();
		$('#search-bar').show();
		$('#search-button').hide();
		$('#q_expense_date_date_equals').val('')
		$('#q_category_name_or_sub_category_name_or_name_cont').val('')
		$('#q_amount_gteq').val('')
		$('#q_user_display_name_cont').val('')
	});
	$('input:text').click(
		function () {
			$(this).val('');
		});
});
