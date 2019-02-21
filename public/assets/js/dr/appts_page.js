$(function(){
	var ajax = null;

	$('#section-1').on('click', '.pagination .page', function(e){
		e.preventDefault();
		if (ajax) ajax.abort();

		$('.pagination .active').removeClass('active');
		var page = $(this).addClass('active').data('page');
		var filter = $('input[name="filter"]').val();

		config.ajax.url = config.baseUrl + '/d/getappts';
		config.ajax.data = { page: page, filter: filter };

		ajax = $.ajax(config.ajax).done(function(data){
			ajax = null;

			if (data.error) {
				$.toast(data.err, 'err');
			} else {
				$('#section-1 .list').html(data.appts);
				$('#section-1 .pagination').html(data.pagination);
			}
		});
	});

	$('.filter select').change(function(){
		if (ajax) ajax.abort();
		var filter = this.value;

		config.ajax.url = config.baseUrl + '/d/getappts';
		config.ajax.data = { page: 1, filter: this.value };

		ajax = $.ajax(config.ajax).done(function(data){
			ajax = null;
			
			if (data.error) {
				$.toast(data.err, 'err');
			} else if (data.appts == null) {
				$('#section-1 .list').html('<div class="no-data">No data found</div>');
				$('#section-1 .pagination').html('');
			} else {
				$('input[name="filter"]').val(filter);
				$('#section-1 .list').html(data.appts);
				$('#section-1 .pagination').html(data.pagination);
			}
		});
	});
});