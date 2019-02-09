$(function(){

	/* photo preview */

	$('#edit-form input[name="photo"]').change(function(){
		var reader = new FileReader();
		var file = this.files[0];
		var types = ['image/jpg', 'image/jpeg', 'image/png'];

		if (types.indexOf(file['type']) < 0) {
			$.toast('Invalid file type', 'info');
			return false;
		}

		reader.onload = function(){
		    $('#section-1 .preview img').attr('src', reader.result);
		    $('#section-1 .file-browser .filename').text(file['name']);
		}; reader.readAsDataURL(file);
	});


	/* change gender */

	$('#edit-form .gen-opt').click(function(){
		var gender = this.dataset.gender;
		$('#edit-form input[name="gender"]').val(gender);
		$('#edit-form .gen-opt.active').removeClass('active');
		$(this).addClass('active');
	});


	/* submit form */

	$('#edit-form').submit(function(e){
		e.preventDefault();
		$('#section-1 .errors ul').html('');
		$('#section-1 .errors').hide();

		var photo_input = $('#edit-form input[name="photo"]');
		var file = photo_input[0]['files'][0];
		var types = ['image/jpg', 'image/jpeg', 'image/png'];
		var errors = [];

		if (file !== undefined && types.indexOf(file['type']) < 0) {
			errors.push('Invalid file type'); 
			photo_input.val('');
		}

		var fname = $('#edit-form input[name="first_name"]').val();
		var lname = $('#edit-form input[name="last_name"]').val();
		var address = $('#edit-form input[name="address"]').val();
		var number = $('#edit-form input[name="contact_number"]').val();
		var bdate = $('#edit-form input[name="birthdate"]').val();
		var gender = $('#edit-form input[name="gender"]').val();

		if (fname == '') {
			errors.push('Missing first name');
		}
		if (lname == '') {
			errors.push('Missing last name');
		}
		if (address == '') {
			errors.push('Missing address');
		}
		if (number == '') {
			errors.push('Missing contact number');
		}
		if (bdate == '') {
			errors.push('Missing birthdate');
		}
		if (gender == '') {
			errors.push('Missing gender');
		}

		if (errors.length > 0) {
			var html = '';

			for (var idx in errors) {
				html += '<li>' + errors[idx] + '</li>';
			}

			$('#section-1 .errors ul').html(html);
			$('#section-1 .errors').show();			
			return;
		}

		config.ajax.url = config.baseUrl + '/d/myaccount/update';
		config.ajax.data = new FormData(this);
		config.ajax.contentType = false;
		config.ajax.processData = false;

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				var html = '';

				for (var idx in data.err) {
					html += '<li>' + data.err[idx] + '</li>';
				}

				$('#section-1 .errors ul').html(html);
				$('#section-1 .errors').show();
				return;		
			}

			window.location.reload();
		});
	});

});