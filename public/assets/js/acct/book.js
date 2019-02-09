$(function(){

	/* search doctor */

	var matching = null;

	$('#search-form').submit(function(e){
		e.preventDefault();
		if (matching) matching.abort();

		var post = {
			spec: $('#search-form [name="spec"]').val(),
			srvc: $('#search-form [name="srvc"]').val(),
			area: $('#search-form [name="area"]').val(),
			offset: 0
		};

		if (!post.area || !post.spec || !post.srvc) {
			$.toast('Please fill up the search form', 'info');
			return;
		}

		config.ajax.data = post;
		config.ajax.url = config.baseUrl + '/matchdoc';
		config.ajax.contentType = 'application/x-www-form-urlencoded; charset=UTF-8';
		config.ajax.processData = true;

		matching = $.ajax(config.ajax).done(function(data){
			$('#section-2 .results').html(data.searchResult || "");
			$('#section-2 .result-count').html(data.count);

			if (data.count) {
				$('#section-2 .filler').hide();
				$('.load-more').show();
			} else {
				$('.load-more').hide();
				$('#section-2 .filler').fadeIn();
				$.toast('No matching doctor', 'info');
			}

			$('input[type="hidden"][name="offset"]').val(data.offset);
			$('input[type="hidden"][name="spec"]').val(post.spec);
			$('input[type="hidden"][name="srvc"]').val(post.srvc);
			$('input[type="hidden"][name="area"]').val(post.area);

		}).always(function(){
			matching = null;
		});
	});


	/* load more search result */

	$('.load-more').click(function(e){
		e.preventDefault();
		if (matching) matching.abort();

		var post = {
			spec: $('input[type="hidden"][name="spec"]').val(),
			srvc: $('input[type="hidden"][name="srvc"]').val(),
			area: $('input[type="hidden"][name="area"]').val(),
			offset: $('input[type="hidden"][name="offset"]').val()
		};

		config.ajax.data = post;
		config.ajax.url = config.baseUrl + '/matchdoc';
		config.ajax.contentType = 'application/x-www-form-urlencoded; charset=UTF-8';
		config.ajax.processData = true;

		matching = $.ajax(config.ajax).done(function(data){
			$('#section-2 .results').append(data.searchResult || "");
			var currCount = parseInt($('#section-2 .result-count').text().trim());
			$('#section-2 .result-count').html(currCount + data.count);

			if (data.count) {
				$('#section-2 .filler').hide();
				$('.load-more').show();
			} else {
				$('.load-more').hide();
				$.toast('Reached end of search result', 'info');
			}

			$('input[type="hidden"][name="offset"]').val(data.offset);
			$('input[type="hidden"][name="spec"]').val(post.spec);
			$('input[type="hidden"][name="srvc"]').val(post.srvc);
			$('input[type="hidden"][name="area"]').val(post.area);

		}).always(function(){
			matching = null;
		});
	});


	/* address autocomplete */

	$('#search-form input[name="area"]').autocomplete({
		minLength: 2,
		delay: 1500,
		source: function(request, response) {
			$.ajax({
				url: config.baseUrl + '/matcharea',
				type: 'POST',
				dataType: 'JSON',
				data: { area: request.term }
			})
			.done(function(data){
				response($.map(data, function(item){
                    return { value: item.area }
                }));
			});
		}
	})
	.autocomplete("instance")._renderItem = function(ul, item) {
		var customHtml = '<div>' + item.value + '</div>';
		return $( "<li>" ).append( customHtml ).appendTo(ul);
	};


	/* book button clicked */

	$(document).on('click', '.result-item .book', function(e){
		$('#book-form input[name="for_other"]').prop('checked', false);
		$('#book-form .for-other').hide();
		$('#book-form')[0].reset();

		config.ajax.url = config.baseUrl + '/getdoctor';
		config.ajax.data = { id: $(this).closest('.result-item').data('id') };
		config.ajax.contentType = 'application/x-www-form-urlencoded; charset=UTF-8';
		config.ajax.processData = true;

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				$.toast(data.err, 'err');
				return;
			}

			var purpose = $('input[type="hidden"][name="srvc"]').val() + '.';
			$('#book-form textarea[name="purpose"]').val(purpose);
			$('#book-modal .doctor .photo img').attr('src', data.photo);
			$('#book-modal .doctor .info .name').text(data.name);
			$('#book-modal .doctor .info .field').text(data.spec);
			$('#book-modal .booking-details ul').html(data.clinics);
			$('html').addClass('no-scroll');
			$('#book-modal').fadeIn();
			$('#book-form  div.error').hide();
		});
	});


	/* book for other */

	$('#book-modal input[name="for_other"]').click(function(){
		if ($(this).is(':checked')) {
			$('#book-modal .for-other').slideDown();
		} else {
			$('#book-modal .for-other').slideUp();
		}
	});


	/* change gender */

	$('#book-form .gen-opt').click(function(){
		var gender = this.dataset.gender;
		$('#book-form input[name="gender"]').val(gender);
		$('#book-form .gen-opt.active').removeClass('active');
		$(this).addClass('active');
	});


	/* select photo */

	$('#book-form input[name="photo"]').change(function(){
		var reader = new FileReader();
		var file = this.files[0];
		var types = ['image/jpg', 'image/jpeg', 'image/png'];

		if (types.indexOf(file['type']) < 0) {
			$.toast('Invalid file type', 'info');
			return false;
		}
	});


	/* submit information */

	$('#book-form').submit(function(e){
		e.preventDefault();
		$('#book-form  div.error').hide();

		var has_error = false;
		var data = {
			clinic: $('#book-form input[name="clinic"]:checked').val(),
			schedule: $('#book-form input[name="schedule"]').val(),
			purpose: $('#book-form textarea[name="purpose"]').val(),
			for_other: $('#book-form input[name="for_other"]:checked').val()
		};

		if (!data.clinic) {
			has_error = true;
			$('#book-form .clinic .error').show();
		}

		if (!data.schedule) {
			has_error = true;
			$('#book-form .sched .error').show();
		}

		if (!data.purpose) {
			has_error = true;
			$('#book-form .purpose .error').show();
		}

		if ($('#book-form input[name="for_other"]').is(':checked')) {
			var fname = $('#book-form input[name="first_name"]').val();
			var mname = $('#book-form input[name="middle_name"]').val();
			var lname = $('#book-form input[name="last_name"]').val();
			var add = $('#book-form input[name="address"]').val();
			var bdate = $('#book-form input[name="birthdate"]').val();
			var gen = $('#book-form input[name="gender"]').val();
			var email = $('#book-form input[name="email_address"]').val();

			if (!fname) {
				has_error = true;
				$('#book-form .fname .error').show();
			}

			if (!mname) {
				has_error = true;
				$('#book-form .mname .error').show();
			}

			if (!lname) {
				has_error = true;
				$('#book-form .lname .error').show();
			}

			if (!add) {
				has_error = true;
				$('#book-form .add .error').show();
			}

			if (!bdate) {
				has_error = true;
				$('#book-form .bdate .error').show();
			}

			if (!gen) {
				has_error = true;
				$('#book-form .gen .error').show();
			}

			if (!email) {
				has_error = true;
				$('#book-form .email .error').text('Please provide an input').show();
			} else if (!email.match(/^\S+@\S+\.\S+/)) {
				has_error = true;
				$('#book-form .email .error').text('Please enter a valid email address').show();
			}

			data = new FormData(this);
			config.ajax.contentType = false;
			config.ajax.processData = false;
		}

		if (has_error) {
			return false;
		}

		config.ajax.url = config.baseUrl + '/book';
		config.ajax.data = data;
		$('#book-modal').fadeOut();

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				$.toast(data.err, 'err');
			} else {
				window.location.href = config.baseUrl + '/confirm/' + data.appt;
			}
		});
	});

});