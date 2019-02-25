$(function(){
	$('#section-4 .cancel').click(function(e){
		e.preventDefault();
		
		var appt = $('input[type="hidden"][name="appt"]').val();
		var url = $(this).prop('href');
		
		config.ajax.data = { appt: appt };
		config.ajax.url = url;

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				$.toast(data.err, 'err');
			} else {
				window.location.href = config.baseUrl + '/myaccount';
			}
		});
	});
});