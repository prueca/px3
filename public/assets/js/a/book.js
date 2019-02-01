$(function(){

	/* search doctor */

	var matching = null;

	$('#search-form').submit(function(e){
		e.preventDefault();
		if (matching) matching.abort();

		var post = {
			csrf_name: $('input[name="csrfname"]').val(),
			csrf_value: $('input[name="csrfvalue"]').val(),
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

			$('input[name="csrfname"]').val(data.token.csrf_name);
			$('input[name="csrfvalue"]').val(data.token.csrf_value);
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
			csrf_name: $('input[name="csrfname"]').val(),
			csrf_value: $('input[name="csrfvalue"]').val(),
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

			$('input[name="csrfname"]').val(data.token.csrf_name);
			$('input[name="csrfvalue"]').val(data.token.csrf_value);
			$('input[type="hidden"][name="offset"]').val(data.offset);
			$('input[type="hidden"][name="spec"]').val(post.spec);
			$('input[type="hidden"][name="srvc"]').val(post.srvc);
			$('input[type="hidden"][name="area"]').val(post.area);

		}).always(function(){
			matching = null;
		});
	});


	/* address autocomplete */

	/*$('#search-form input[name="area"]').autocomplete({
		minLength: 2,
		delay: 1500,
		source: function(request, response) {
			config.ajax.url = config.base_url + '/match/area';
			config.ajax.data = { area: request.term };

			$.ajax(config.ajax).done(function(data){
				response($.map(data, function(item){
                    return { value: item.area }
                }));
			});
		}
	})
	.autocomplete("instance")._renderItem = function(ul, item) {
		var customHtml = '<div>' + item.value + '</div>';
		return $( "<li>" ).append( customHtml ).appendTo(ul);
	};*/


	/* book button clicked */

	/*$(document).on('click', '.result-item .book', function(e){
		$('#book-form input[name="for_other"]').prop('checked', false);
		$('#book-form .for-other').hide();
		$('#book-form')[0].reset();
		$.toast('Fetching data. Please wait...', 'processing');

		config.ajax.url = config.base_url + '/getdoctor';
		config.ajax.data = {
			uid: $(this).closest('.result-item').data('uid'),
			loc: $(this).closest('.result-item').data('area')
		};

		$.ajax(config.ajax).done(function(resp){
			$('#toast').fadeOut();
			$('#book-modal .doctor .photo img').attr('src', resp.photo);
			$('#book-modal .doctor .info .name').text(resp.name);
			$('#book-modal .doctor .info .field').text(resp.specialization);
			$('#book-modal .booking-details ul').html(resp.html_clinics);
			$('html').addClass('no-scroll');
			$('#book-modal').fadeIn();
			$('#book-form  div.error').hide();
		}).fail(function(){
			$.toast('An application error has occurred', 'error', true);
		});
	});*/


	/* book for other */

	/*$('#book-modal input[name="for_other"]').click(function(){
		if ($(this).is(':checked')) {
			$('#book-modal .for-other').slideDown();
		} else {
			$('#book-modal .for-other').slideUp();
		}
	});*/


	/* change gender */

	/*$('#book-form .gen-opt').click(function(){
		var gender = this.dataset.gender;
		$('#book-form input[name="gender"]').val(gender);
		$('#book-form .gen-opt.active').removeClass('active');
		$(this).addClass('active');
	});*/


	/* submit information */

	/*$('#book-form').submit(function(e){
		e.preventDefault();
		$('#book-form  div.error').hide();

		var has_error = false;
		var data = new FormData(this);

		if (!data.get('clinic')) {
			has_error = true;
			$('#book-form .clinic .error').show();
		}

		if (!data.get('schedule')) {
			has_error = true;
			$('#book-form .sched .error').show();
		}

		if (!data.get('purpose')) {
			has_error = true;
			$('#book-form .purpose .error').show();
		}

		if ($('#book-form input[name="for_other"]').is(':checked')) {
			if (!data.get('first_name')) {
				has_error = true;
				$('#book-form .fname .error').show();
			}

			if (!data.get('middle_name')) {
				has_error = true;
				$('#book-form .mname .error').show();
			}

			if (!data.get('last_name')) {
				has_error = true;
				$('#book-form .lname .error').show();
			}

			if (!data.get('address')) {
				has_error = true;
				$('#book-form .add .error').show();
			}

			if (!data.get('birthdate')) {
				has_error = true;
				$('#book-form .bdate .error').show();
			}

			if (!data.get('gender')) {
				has_error = true;
				$('#book-form .gen .error').show();
			}

			if (!data.get('email_address')) {
				has_error = true;
				$('#book-form .email .error').text('Please provide an input').show();
			} else if (!data.get('email_address').match(/^\S+@\S+\.\S+/)) {
				has_error = true;
				$('#book-form .email .error').text('Please enter a valid email address').show();
			}
		}

		if (has_error) {
			return false;
		}

		config.ajax.url = config.base_url + '/book';
		config.ajax.contentType = false;
		config.ajax.processData = false;
		config.ajax.data = data;

		$('#book-modal').fadeOut();
		$.toast('Saving data. Please wait...', 'processing');

		$.ajax(config.ajax).done(function(resp){
			if (resp.error) {
				$.toast(resp.error, 'error');
				return;
			}

			window.location.href = config.base_url + '/confirm/' + resp.appointment;
		});
	});*/

});