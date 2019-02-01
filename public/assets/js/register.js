$(function(){
	$('#register-form').submit(function(e){
		e.preventDefault();
		$('#form-signup .err').text('');

		var url = $(this).prop('action');
		var proceed = true;
		var data = {};

		$('#register-form input').each(function(){
			if (!$(this).is('input[name="mname"]') && !this.value) {
				$(this).parent().next('.err').text('Please provide an input');
				proceed = false;
			} else if ($(this).is('input[name="gen"]:checked') || !$(this).is('input[name="gen"]')) {
				data[$(this).attr('name')] = this.value;
			}
		});

		if (data.email && !data.email.match(/^\S+@\S+\.\S+/)) {
			$('#register-form input[name="email"]').parent().next('.err').text('Invalid email');
			proceed = false;
		}

		if (data.pass && (data.pass.length < 8 || !data.pass.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[~!@#$%^&*()_+)]).*/))) {
			$('#form-signup input[name="pass"]').parent().next('.err').text('Your input does not meet the minimum requirements');
			proceed = false;
		}

		if (data.pass && data.confirm_pass && data.pass != data.confirm_pass) {
			$('#form-signup input[name="confirm_pass"]').parent().next('.err').text('Password does not match');
			proceed = false;
		}

		if (!proceed) return false;

		data.csrf_name = $('input[name="csrfname"]').val();
		data.csrf_value = $('input[name="csrfvalue"]').val();
		data.type = $('input[name="type"]').val();

		config.ajax.url = url;
		config.ajax.data = data;

		$.ajax(config.ajax).done(function(data){
			$('input[name="csrfname"]').val(data.token.csrf_name);
			$('input[name="csrfvalue"]').val(data.token.csrf_value);
			
			if (data.err) {
				alert(data.err);
			} else {
				$('#register-modal').hide();
				alert('Account created successfully!');
			}
		});
	});
});