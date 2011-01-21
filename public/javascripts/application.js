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
	sendToken: function(){
		$.ajaxSetup({async:false});
		var mailTo = $('#to').val();
		$('#sendToken').attr('disabled', true);
		$.post('/user', {mail: mailTo}, function(data) {
			data = eval('(' + data + ')');
			if(!PutsMail.showErrorsFor(data.errors)){
				var msg = '';
				if(data.token_reset){
					msg = 'Your token was reset! The previous token has been disabled\n\n';
				}
				msg += 'The token was sent to ' + mailTo; 
				alert(msg);
			}
		});
		$('#sendToken').attr('disabled', false);
	},
	putsMail: function(){
		$.ajaxSetup({async:false});
		var mailTo = $('#to').val();
		var token = $('#token').val();
		var subject = $('#subject').val();
		var body = $('#body').val();
		$('#sendMail').attr('disabled', true);
		$.post('/puts_mail', {mail: mailTo, token: token, subject: subject, body: body}, function(data) {
			data = eval('(' + data + ')');
			if(!PutsMail.showErrorsFor(data.errors)){
				alert('The mail was sent to ' + mailTo);
			}
		});		
		$('#sendMail').attr('disabled', false);
	}		
};