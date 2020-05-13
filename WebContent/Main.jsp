<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/displaytag.css" type="text/css">
<link rel="stylesheet" href="css/screen.css" type="text/css">
<link rel="stylesheet" href="css/site.css" type="text/css">

<title>Unique Key generation</title>

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
	// Wait until the DOM has loaded before querying the document
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

	<div id='uniqueKey' class="tab_content">

		<ul id='tabs' class="tabss">
			<li><a href='#uniqueKey'>Generate Unique Key</a></li>
			<a href="HashController">Secure Hashing</a>
			<a href='EncryptionController'>Encryption/Decryption</a>
			<a href="WaterMarkController">Watermarking</a>
		</ul>

		<h1>Functionality to generate unique keys :</h1>

		<table style="font-size: 16px;">
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					1:</td>
				<td style="width: 90%">Add / Update the value for "Key length"
					text box</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					2:</td>
				<td style="width: 90%">Click on "Generate New Key Button"</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					3:</td>
				<td style="width: 90%">New and unique generated key will
					display in the table below.</td>
			<tr>
			<tr>
				<td style="width: 10%"></td>
				<td style="width: 90%">This will also show the time taken to
					generate each key.</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					4:</td>
				<td style="width: 90%">Click on "Clear values" button to reset
					values.</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
		</table>

<span style="color: Red"> <label for="errorMessageLabel"
			id="errorMessageLabel">${uniqueKeyModel.errorMessage}</label>
		</span>
		

		<table>
			<tr>
				<td>
					<form name="uniqueKeyForm" action="UniqueKeyController"
						method="post" style="width: 100%">
						<table style="border: 1px solid black">
							<tr>
								<td>
									<label> Key length = </label> <input id="keyLeangthTextBox"
										name="keyLeangthTextBox" value='${uniqueKeyModel.keyLength}'
										style="width: 50px">
								</td>
								<td>
									<input type="submit" name="generateKeyButton" class="button"
										id="generateKeyButton" value="Generate New Key"
										class="myButton">
								</td>
								<td>
									<%-- <input id="uniqueKeyTextBox" name="uniqueKeyTextBox"
										value='${uniqueKeyModel.newGeneratedKey}' style="width: 250px"> --%>
								</td>
								<td>
									<input type="submit" name="clearButton" id="clearButton"
										class="button" value="Clear values">
								</td>
								<td width="25px">
							</tr>

						</table>

						<table style="border: 1px solid black">
							<tr style="border: 1px solid black; background-color: lightgray;">
								<th># Attempt</th>
								<th>New Generated Key</th>
								<th>Time taken (ms)</th>
							</tr>

							<c:forEach items="${uniqueKeyTableList}" var="newKey">
								<tr
									style="border: 1px solid black; width: 250px; overflaw: wrap">
									<td>${newKey.attemptNum}</td>
									<td>${newKey.newGeneratedKey}</td>
									<td>${newKey.timeTaken}</td>
								</tr>

							</c:forEach>

						</table>

						<table>
							<tr>
								<td>
									<%-- <textarea name='previousKeysTextarea'
										id='previousKeysTextarea' rows="40" cols="150">${uniqueKeyModel.allGeneratedKeys} </textarea> --%>
								</td>
							</tr>

							<tr>
								<td>
									<!-- <input type="submit" name="clearButton" id="clearButton"
										class="button" value="Clear values"> -->
								</td>
							</tr>
						</table>

					</form>
				</td>
			</tr>
		</table>
	</div>
<br/><br/><br/>
	<table style="font-size: 16px;">
		<tr>
			<td
				style="width: 10%; font-style: italic; text-decoration: underline;">Note
				:</td>
			<td style="width: 90%">Code referenced  from : https://www.geeksforgeeks.org/</td>

		</tr>
	</table>
	<br/><br/><br/>

	<table style="font-style: italic; color: gray">
		<tr>
			<td style="padding-left: 420px;">Source code can be found at -
				<a href ="https://github.com/patelankitar/CSE_5381_InfoSec_Assignment" target = "_blank"> Source </a>
			<td>
		</tr>

	</table>

</body>
</html>