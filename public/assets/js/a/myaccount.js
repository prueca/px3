$(function(){
	var ajax = null;

	$('.appointments').on('click', '.pagination .page', function(e){
		e.preventDefault();
		if (ajax) ajax.abort();

		$('.pagination .active').removeClass('active');
		var page = $(this).addClass('active').data('page');
		var filter = $('input[name="filter"]').val();
		var csrfname = $('input[name="csrfname"]').val();
		var csrfval = $('input[name="csrfvalue"]').val();

		config.ajax.url = config.baseUrl + '/getappts';
		config.ajax.data = {
			csrf_name: csrfname,
			csrf_value: csrfval,
			page: page,
			filter: filter
		};

		ajax = $.ajax(config.ajax).done(function(data){
			$('input[name="csrfname"]').val(data.token.csrf_name);
			$('input[name="csrfvalue"]').val(data.token.csrf_value);
			ajax = null;

			if (data.error) {
				alert(data.err);
			} else {
				$('.appointments .list').html(data.appts);
				$('.appointments .pagination').html(data.pagination);
			}
		});
	});


	$('.filter select').change(function(){
		if (ajax) ajax.abort();
		var filter = this.value;
		var csrfname = $('input[name="csrfname"]').val();
		var csrfval = $('input[name="csrfvalue"]').val();

		config.ajax.url = config.baseUrl + '/getappts';
		config.ajax.data = {
			csrf_name: csrfname,
			csrf_value: csrfval,
			page: 1,
			filter: this.value
		};

		ajax = $.ajax(config.ajax).done(function(data){
			$('input[name="csrfname"]').val(data.token.csrf_name);
			$('input[name="csrfvalue"]').val(data.token.csrf_value);
			ajax = null;
			
			if (data.error) {
				alert(data.err);
			} else if (data.appts == null) {
				$('.appointments .list').html('<div class="no-data">No data found</div>');
				$('.appointments .pagination').html('');
			} else {
				$('input[name="filter"]').val(filter);
				$('.appointments .list').html(data.appts);
				$('.appointments .pagination').html(data.pagination);
			}
		});
	});
});