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
					msg = 'Your token was reset! The previous token was disabled\n\n';
				}
				msg += 'The token was sent to ' + mailTo; 
				alert(msg);
			}
		});
		$('#sendToken').attr('disabled', false);
	},
	checkImagesSource: function(){
		// Validate putsMail - img src
		var div = document.createElement('div');
		div.innerHTML = $('#body').val();
		var imgs = div.getElementsByTagName('img');
		var count = 0;
		for(var i = 0; i < imgs.length; i++){
			var img = imgs[i];
			var imgSrc = '';
			if(img.attributes['src'] && img.attributes['src'].nodeValue){
				imgSrc = img.attributes['src'].nodeValue.toLowerCase();
			}
			if(imgSrc.indexOf('http://') != 0){
				count++;
			}
		}
		if(count > 0){
			return (confirm('Ooops! ' + count + ' local image(s) found. The img src attribute must begin with "http://" to be available on the mail\n\nContinue send mail?'))
		}
		return true;
		// Validate putsMail - img src
	},
	putsMail: function(){
		if(!PutsMail.checkImagesSource()){
			return;
		}
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
				$('#mail_counter').text(data.mail_counter);
			}
		});		
		$('#sendMail').attr('disabled', false);
	}		
};