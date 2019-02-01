$(function(){
	$('#login-form').submit(function(e){
		e.preventDefault();

		var url = $(this).prop('action');
		var email = $('input[name="email"]').val();
		var pass = $('input[name="pass"]').val();
		var type = $('input[name="type"]').val();
		var csrfname = $('input[name="csrfname"]').val();
		var csrfval = $('input[name="csrfvalue"]').val();

		if (!email || !pass) {
			alert('Missing email or password');
			return;
		}

		if (!email.match(/^\S+@\S+\.\S+/)) {
			alert('Invalid email or password');
			return;
		}

		config.ajax.url = url;
		config.ajax.data = {
			email: email,
			pass: pass,
			type: type,
			csrf_name: csrfname,
			csrf_value: csrfval
		};

		$.ajax(config.ajax).done(function(data){
			$('input[name="csrfname"]').val(data.token.csrf_name);
			$('input[name="csrfvalue"]').val(data.token.csrf_value);

			if (data.err) {
				alert(data.err);
			} else if (data.myaccount) {
				window.location.href = data.myaccount;
			}
		});
	});
});