$(function(){

	/* set and get cookie */

	$.cookie = function(name, val = null, min = null, path = '/') {
		if (val !== null) {
			var expires = '';

			if (min !== null) {
				if (typeof min != 'number') {
					console.error('Caught error: expiry must be a number');
					return;
				}

				var date = new Date();
				date.setTime(date.getTime() + (min*(60*1000)));
	       		expires = '; expires=' + date.toUTCString();
			}	        

		    document.cookie = name + '=' + (val || '')  + expires + '; path=' + path;
		    return;
		}

		var regex = new RegExp('(^| )' + name + '=([^;]+)');
		var match = document.cookie.match(regex);
  		if (match) return decodeURIComponent(match[2]);
	}

	/* toggle nav menu */

	$('#header .toggle-menu').click(function(){
		var left = $('#mobile-nav').css('left');

		if (left == '-250px') {
			$('#mobile-nav').css({
				'left': '0px',
				'opacity': '1'
			});
			$('body').addClass('no-scroll');
			$(this).find('i').removeClass('fa-bars').addClass('fa-times');
		} else {
			$('#mobile-nav').css({
				'left': '-250px',
				'opacity': '0'
			});
			$('body').removeClass('no-scroll');
			$(this).find('i').removeClass('fa-times').addClass('fa-bars');
		}
	});


	/* modal events */

	$('.modal-overlay').click(function(e){
		if (e.target === this) {
			$(this).fadeOut();
			$('html').removeClass('no-scroll');
		}
	});

	$('.toggle-modal').click(function(e){
		e.preventDefault();
		$(this.dataset.modal).fadeIn();
		$('html').addClass('no-scroll');
	});

	$('.modal-close, .modal-cancel').click(function(e){
		e.preventDefault();
		$(this).closest('.modal-overlay').fadeOut();
		$('html').removeClass('no-scroll');
	});

});