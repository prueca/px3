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
			alert('Please fill up the search form');
			return;
		}

		config.ajax.data = post;
		config.ajax.url = config.baseUrl + '/matchdoc';

		matching = $.ajax(config.ajax).done(function(data){
			$('#section-2 .results').html(data.searchResult || "");
			$('#section-2 .result-count').html(data.count);

			if (data.count) {
				$('#section-2 .filler').hide();
				$('.load-more').show();
			} else {
				$('.load-more').hide();
				$('#section-2 .filler').fadeIn();
				alert('No matching doctor');
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

		matching = $.ajax(config.ajax).done(function(data){
			$('#section-2 .results').append(data.searchResult || "");
			var currCount = parseInt($('#section-2 .result-count').text().trim());
			$('#section-2 .result-count').html(currCount + data.count);

			if (data.count) {
				$('#section-2 .filler').hide();
				$('.load-more').show();
			} else {
				$('.load-more').hide();
				alert('Reached end of search result');
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

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				alert(data.err);
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
			data.first_name = $('#book-form input[name="first_name"]').val();
			data.middle_name = $('#book-form input[name="middle_name"]').val();
			data.last_name = $('#book-form input[name="last_name"]').val();
			data.address = $('#book-form input[name="address"]').val();
			data.birthdate = $('#book-form input[name="birthdate"]').val();
			data.gender = $('#book-form input[name="gender"]').val();
			data.email_address = $('#book-form input[name="email_address"]').val();

			if (!data.first_name) {
				has_error = true;
				$('#book-form .fname .error').show();
			}

			if (!data.middle_name) {
				has_error = true;
				$('#book-form .mname .error').show();
			}

			if (!data.last_name) {
				has_error = true;
				$('#book-form .lname .error').show();
			}

			if (!data.address) {
				has_error = true;
				$('#book-form .add .error').show();
			}

			if (!data.birthdate) {
				has_error = true;
				$('#book-form .bdate .error').show();
			}

			if (!data.gender) {
				has_error = true;
				$('#book-form .gen .error').show();
			}

			if (!data.email_address) {
				has_error = true;
				$('#book-form .email .error').text('Please provide an input').show();
			} else if (!data.email_address.match(/^\S+@\S+\.\S+/)) {
				has_error = true;
				$('#book-form .email .error').text('Please enter a valid email address').show();
			}
		}

		if (has_error) {
			return false;
		}

		config.ajax.url = config.baseUrl + '/book';
		config.ajax.data = data;
		$('#book-modal').fadeOut();

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				alert(data.err);
			} else {
				window.location.href = config.baseUrl + '/confirm/' + data.appt;
			}
		});
	});

});