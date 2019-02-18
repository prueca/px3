$(function(){

	var clinicItem = null;
	var updatingSpec = null;
	var schedArr = [];

	/**
	 * udpate specialization
	 */

	$('#section-1 .spec .save').click(function(){
		if (updatingSpec) {
			updatingSpec.abort();
		}

		var spec = $('#section-1 input[name="spec"]').val().trim();

		if (!spec) {
			alert('Please provide an input');
			return;
		}

		config.ajax.url = config.baseUrl + '/d/update/spec';
		config.ajax.data = { spec: spec };

		updatingSpec = $.ajax(config.ajax).done(function(data){
			updatingSpec = null;

			if (data.err) {
				alert(data.err);
			} else {
				$.toast('Your profile has been updated');
			}
		});
	});

	
	/**
	 * add or delete sched
	 */

	$('#clinic-modal').on('click', '.add-sched, .delete-sched', function(e){
		e.preventDefault();

		if ($(this).is('.add-sched')) {
			var newSched = {
				day: $('#clinic-modal .day').val(),
				opening: $('#clinic-modal .opening').val(),
				closing: $('#clinic-modal .closing').val()
			};

			if (newSched.day && newSched.opening && newSched.closing) {
				var push = true;

				if (schedArr.length > 0) {
					for (var i in schedArr) {
						var sched_elem = schedArr[i];

						if (sched_elem.day == newSched.day && sched_elem.opening == newSched.opening && sched_elem.closing == newSched.closing) {
							push = false;
							break;
						}
					}
				}

				if (push) {
					var text = newSched.day + ' ' + newSched.opening + ' - ' + newSched.closing;
					var html = '' +
					'<div class="list-item">' +
						'<a href="#" class="delete-sched"><i class="fas fa-fw fa-times"></i></a>' +
						'<span>' + text + '</span>'+
					'</div>';

					$('#clinic-modal .set-sched .list').append(html);
					schedArr.push(newSched);
				}
			}
			
		} else if ($(this).is('.delete-sched')) {
			var sched = $(this).parent();
			schedArr.splice(sched.index(), 1);
			sched.remove();
		}
	});


	/**
	 * submit clinic info
	 */

	$('#clinic-form').submit(function(e){
		e.preventDefault();
		var has_error = false;
		var clinic = $('#clinic-form input[name="clinic"]').val();
		var data = {
			name: $('#clinic-form input[name="name"]').val(),
			street_address: $('#clinic-form input[name="street_address"]').val(),
			city: $('#clinic-form input[name="city"]').val(),
			schedule: JSON.stringify(schedArr)
		};

		if (clinic) {
			data.clinic = clinic;
		}

		if (!data.name) {
			$('#clinic-modal .err.name').text('Please provide a name').show();
			has_error = true;
		} else {
			$('#clinic-modal .err.name').hide();
		}

		if (!data.street_address) {
			$('#clinic-modal .err.street-add').text('Please provide a street address').show();
			has_error = true;
		} else {
			$('#clinic-modal .err.street-add').hide();
		}

		if (!data.city) {
			$('#clinic-modal .err.city').text('Please provide a city').show();
			has_error = true;
		} else {
			$('#clinic-modal .err.city').hide();
		}

		if (schedArr.length < 1) {
			$('#clinic-modal .err.sched').text('Please provide a schedule').show();
			has_error = true;
		} else {
			$('#clinic-modal .err.sched').hide();
		}

		if (has_error) {
			return;
		}

		$('#clinic-modal').fadeOut();
		$('html').removeClass('no-scroll');

		config.ajax.url = $(this).prop('action');
		config.ajax.data = data;

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				$.toast(data.err, 'err');
			} else {
				if (data.append) {
					$('#section-2 .list').append(data.html);
				} else {
					$(clinicItem).replaceWith(data.html);
				}

				$.toast('Your profile has been updated');
			}
		});
	});


	/**
	 * edit clinic
	 */

	$('#section-2 .list').on('click', '.list-item .edit', function(e){
		e.preventDefault();
		clinicItem = $(this).closest('.list-item');
		config.ajax.url = config.baseUrl + '/d/clinic/get';
		config.ajax.data = { id: clinicItem.data('id') };

		$.ajax(config.ajax).done(function(data){
			if (data.err) {
				$.toast(data.err, 'err');
				return;
			}

			$('#clinic-form input[name="clinic"]').val(data.clinic_id);
			$('#clinic-form input[name="name"]').val(data.name);
			$('#clinic-form input[name="street_address"]').val(data.street_address);
			$('#clinic-form input[name="barangay"]').val(data.barangay);
			$('#clinic-form input[name="city"]').val(data.city);
			$('#clinic-modal .set-sched .list').html('');
			schedArr = [];

			for (var i in data.schedule) {
				var sched = data.schedule[i];
				var text = sched.day + ' ' + sched.opening + ' - ' + sched.closing;
				var html = '' +
				'<div class="list-item">' +
					'<a href="#" class="delete-sched"><i class="fas fa-fw fa-times"></i></a>' +
					'<span>' + text + '</span>'+
				'</div>';

				$('#clinic-modal .set-sched .list').append(html);
				schedArr.push(sched);
			}

			$('#clinic-modal').fadeIn();
			$('#clinic-form').prop('action', config.baseUrl + '/d/clinic/update');
		});
	});


	/**
	 * change clinic-form url to add
	 */

	$('#section-2 .add-clinic').click(function(e){
		e.preventDefault();
		$('#clinic-form').prop('action', config.baseUrl + '/d/clinic/add');
	});


	/**
	 * delete clinic
	 */

	$('#section-2 .list').on('click', '.list-item .delete', function(e){
		e.preventDefault();

		if (confirm('Proceed deleting this clinic?')) {
			clinicItem = $(this).closest('.list-item');
			config.ajax.url = config.baseUrl + '/d/clinic/delete';
			config.ajax.data = { id: clinicItem.data('id') };

			$.ajax(config.ajax).done(function(data){
				if (data.err) {
					$.toast(data.err, 'err');
				} else {
					$.toast('Your profile has been updated');
					clinicItem.remove();				
				}
			});
		}
	});


	/**
	 * add meta data
	 */

	$('.new-item .save-item').click(function(e){
		e.preventDefault();
		var input = $(this).closest('.new-item').find('input[name="item-value"]');
		var value = input.val();
		var type = $(this).data('type');

		if (type && value) {
			var inputWrapper = $(this).parent();
			config.ajax.url = config.baseUrl + '/d/meta/add';
			config.ajax.data = { type: type, value: value };

			$.ajax(config.ajax).done(function(data){
				if (data.err) {
					alert(data.err);
				} else {
					$(data.html).insertBefore(inputWrapper);
					$.toast('Your profile has been updated');
					input.val('');
				}
			});
		}
	});


	/**
	 * update meta data
	 */

	$('#section-3 .list').on('click', '.list-item .save-item', function(e){
		e.preventDefault();
		var listItem = $(this).closest('.list-item');
		var id = listItem.data('id');
		var type = listItem.data('type');
		var val = listItem.find('input[type="text"]').val();

		if (id && type && val) {
			config.ajax.url = config.baseUrl + '/d/meta/update';
			config.ajax.data = { id: id, type: type, val: val };

			$.ajax(config.ajax).done(function(data){
				if (data.err) {
					$.toast(data.err, 'err');
				} else {
					listItem.replaceWith(data.html);
					$.toast('Your profile has been updated');
				}
			});
		}
	});


	/**
	 * delete meta data
	 */

	$('#section-3 .list').on('click', '.list-item .delete-item', function(e){
		e.preventDefault();
		var confirmed = confirm('Proceed deleting this item?');
		var listItem = $(this).closest('.list-item');
		var id = listItem.data('id');

		if (confirmed && id) {
			config.ajax.url = config.baseUrl + '/d/meta/delete';
			config.ajax.data = { id: id };

			$.ajax(config.ajax).done(function(data){
				if (data.err) {
					alert(data.err);
				} else {
					listItem.remove();
					$.toast('Your profile has been updated');
				}
			});
		}
	});
});
