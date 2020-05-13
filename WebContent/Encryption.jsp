<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/displaytag.css" type="text/css">
<link rel="stylesheet" href="css/screen.css" type="text/css">
<link rel="stylesheet" href="css/site.css" type="text/css">

<title>Encyption-Decryption functionality</title>

<style>

 html {
	padding: 15px 15px 0;
	font-family: sans-serif;
	font-size: 14px;
} 

p, h3 {
	margin-bottom: 15px;
}

div {
	padding: 10px;
	width: 600px;
	background: #fff;
}

.tabss li {
	list-style: none;
	display: inline;
}

.tabss a {
	padding: 5px 10px;
	display: inline-block;
	background: #666;
	color: #ffff;
	text-decoration: none;
}

.tabss li.active a {
	background: lightgreen;
	color: #0;
}

.tab_content {
	display: none;
}

.button {
	background-color: #5E7D7E;
	border-radius: 25px;
	color: white
}
</style>

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js">
	
</script>

<script>
	//Wait until the DOM has loaded before querying the document
	$(document).ready(
			function() {

				//Active tab selection after page load       
				$('#tabs').each(
						function() {

							var $active, $content, $links = $(this).find('a');

							$active = $($links.filter('[href="' + location.hash
									+ '"]')[0]
									|| $links[0]);

							$active.parent().addClass('active');

							$content = $($active.attr('href'));
							$content.show();

						});

				$("#tabs li").click(function(e) {
					e.preventDefault();

					// First remove class "active" from currently active tab
					$("#tabs li").removeClass('active');

					// Now add class "active" to the selected/clicked tab
					$(this).addClass("active");

					// Hide all tab content
					$(".tab_content").hide();

					// Here we get the href value of the selected tab
					var selected_tab = $(this).find("a").attr("href");

					var starting = selected_tab.indexOf("#");
					var sub = selected_tab.substring(starting);

					//write active tab into cookie

					//$(sub).show();
					$(sub).fadeIn();
					// At the end, we add return false so that the click on the
					// link is not executed
					return false;
				});

			});

	/* $(document).ready(function() {
	    if (location.hash) {
	        $("a[href='" + location.hash + "']").tab("show");
	    }
	    $(document.body).on("click", "a[data-toggle='tab']", function(event) {
	        location.hash = this.getAttribute("href");
	    });
	});
	$(window).on("popstate", function() {
	    var anchor = location.hash || $("a[data-toggle='tab']").first().attr("href");
	    $("a[href='" + anchor + "']").tab("show");
	}); */
</script>
</head>
<body>

	<table style="font-style: italic; color: gray">
		<tr>
			<td style="padding-left: 450px;">CSE 5381: Information Security
				2 - Spring 2020 - Class project
			<td>
		</tr>
		<tr>
			<td style="text-align: center; padding-left: 450px;">Ankita
				Ramjibhai Patel - 1001790796</td>
		</tr>
	</table>
	
	<hr style="width: 50%; text-align: center; margin-left: 100">
	
	<form name="encryptionForm" action="EncryptionController" method="post"
		style="width: 100%" enctype="multipart/form-data">

		<ul id='tabs' class="tabss">
			<li><a href='#encryption'>Encryption</a></li>
			<a href="UniqueKeyController">Back</a>
		</ul>

		<h1>Functionality to AES Encryption and Decryption :</h1>
		
		<table style="font-size: 16px;">
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					1:</td>
				<td style="width: 90%">  Input 16 character secret key to encrypt text
					text box</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					2:</td>
				<td style="width: 90%">  Input plain text that you want to be encrypted </td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					3:</td>
				<td style="width: 90%">  Click on "Encrypt" button</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					4:</td>
				<td style="width: 90%">  Encrypted text will be shown in the text box</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					5:</td>
				<td style="width: 90%">  Input encrypted text in the text box</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					4:</td>
				<td style="width: 90%">  Click on "Decrypt" button</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					4:</td>
				<td style="width: 90%">  Decrypted text will be shown in the text box</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
		</table>
		
		

		<span style="color: Red"> <label for="errorMessageLabel"
			id="errorMessageLabel">${encryptionModel.errorMessage}</label>
		</span>
		
		<table style="width: 100%">
			<tr>
				<td style="width: 600px">Input 16 char or digit Key here :</td>
				<td colspan=3 style="width: 500px">
					<textarea id="keyTextBox" name="keyTextBox" rows=2 cols=50>${encryptionModel.key}</textarea>
				</td>
			</tr>
			<tr>
				<td style="width: 400px">Input text here to Encrypt :</td>

				<td style="width: 600px">
					<textarea id="inputPlainTextBox" name="inputPlainTextBox" rows=5
						cols=50>${encryptionModel.inputPlainText}</textarea>
				</td>
				<td style="width: 200px">
					<input type="submit" name="encryptButton" id="encryptButton" class="button"
						value="Encrypt Text" />
				</td>
				<td style="width: 600px">
					<textarea id="generatedCipherTextBox" rows=5 cols=50
						name="generatedCipherTextBox">${encryptionModel.generatedCipherText}</textarea>
				</td>
			</tr>

			<tr>
				<td style="width: 400px">Input Cipher text here :</td>
				<td style="width: 600px">
					<textarea id="inputCipherTextBox" rows=5 cols=50
						name="inputCipherTextBox">${encryptionModel.inputCipherText}</textarea>
				</td>
				<td style="width: 200px">
					<input type="submit" name="decryptButton" id="decryptButton" class="button"
						value="Decrypt Text" />
				</td>
				<td style="width: 600px">
					<textarea id="generatedPlainTextBox" rows=5 cols=50
						name="generatedPlainTextBox">${encryptionModel.generatedPlainText}</textarea>
				</td>
			</tr>
			<tr>
			<td colspan=4>
			<input type="submit" name="clearButton" id="clearButton"
										class="button" value="Clear values">
			</td>
			</tr>
		</table>
	</form>
<br/><br/><br/>
	<table style="font-size: 16px;">
		<tr>
			<td
				style="width: 10%; font-style: italic; text-decoration: underline;">Note
				:</td>
			<td style="width: 90%">Code referenced from :
				https://stackoverflow.com/</td>

		</tr>
	</table>
<br/><br/><br/>
	<table style="font-style: italic; color: gray">
		<tr>
			<td style="padding-left: 320px;">Source code can be found at -
				<a href ="https://github.com/patelankitar/CSE_5381_InfoSec_Assignment"> Source </a>
			<td>
		</tr>

	</table>


</body>
</html>