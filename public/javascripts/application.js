var PutsMail = {
	showErrorsFor: function(errors){
		var msgError = '';
		for(var key in errors){
			if (key === '') {
				// Global
				msgError += ' * ' + errors[key] + '\n';
			} else {
				msgError += ' * ' + key + ' ' + errors[key] + '\n';
			}
		}
		if(msgError === ''){
			return false;
		} else {
			msgError = 'There were problems with the following fields:\n\n' + msgError;
			alert(msgError);
			return true;
		}		
	},
	preview: function(){
		var preview = window.open('', 'preview');
		preview.document.write($('#body').val());
	},
	premailer: function(){
		if(_gaq){
			_gaq.push(['_trackEvent', 'premailer', 'check']);
		}
		
		$.ajaxSetup({async:false});
		// var mailTo = $('#to').val();
		// var token = $('#token').val();
		// var subject = $('#subject').val();
		var body = $('#body').val();
		$('#premailer').attr('disabled', true);
		$.post('/premailer', {body: body}, function(data) {
			data = eval('(' + data + ')');
			$('#body').val(data.body)
			$('#premailer_log table').remove();
			if(data.warnings.length > 0){
				var table = $('<table summary="List of HTML and CSS warnings" id="premailer-warnings" class="warnings">');
				var tableHead = $('<thead>');
				table.append(tableHead);
				var trHead = $('<tr>');
				tableHead.append(trHead);
				trHead.append($('<th>Property</th>'));
				trHead.append($('<th>Support</th>'));
				trHead.append($('<th>Unsupported clients</th>'));
				var tableBody = $('<tbody>');
				table.append(tableBody);
				for(var i = 0; i < data.warnings.length; i++){
					var trBody = $('<tr class="' + data.warnings[i].level.toLowerCase() + '">');
					tableBody.append(trBody);
					trBody.append($('<td>' + data.warnings[i].message + '</td>'));
					trBody.append($('<td>' + data.warnings[i].level + '</td>'));
					trBody.append($('<td>' + data.warnings[i].clients + '</td>'));
				}
				$('#premailer_log').append(table);
				alert("HTML warnings found!");
			} else {
				alert("No HTML warnings found!");
			}
			if(_gaq){
				_gaq.push(['_trackEvent', 'premailer', 'replaced']);
			}
			$('#body').focus();
		});		
		$('#premailer').attr('disabled', false);		
	},
	putsMail: function(){
		$.ajaxSetup({async:true});
		var mailTo = $('#to').val();
		var token = $('#token').val();
		var subject = $('#subject').val();
		var body = $('#body').val();
		$('#sendMail').attr('disabled', true);
		$.post('/puts_mail', {mail: mailTo, token: token, subject: subject, body: body}, function(data) {
			data = eval('(' + data + ')');
			if(!PutsMail.showErrorsFor(data.errors)){
				alert('The mail was sent to ' + mailTo);
				$('#mail_counter').text(data.mail_counter);
			}
		});		
		$('#sendMail').attr('disabled', false);
	}		
};