$(function(){
	$('#section-4 .cancel').click(function(e){
		e.preventDefault();
		config.ajax.data = { appt: $('input[type="hidden"][name="appointment"]').val() };
		config.ajax.url = config.baseUrl + '/appt/cancel';

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				$.toast(data.err, 'err');
			} else {
				window.location.href = config.baseUrl + '/myaccount';
			}
		});
	});
});