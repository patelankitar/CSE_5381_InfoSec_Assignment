<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/displaytag.css" type="text/css">
<link rel="stylesheet" href="css/screen.css" type="text/css">
<link rel="stylesheet" href="css/site.css" type="text/css">

<title>Hash functionality</title>

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
			<td style="padding-left: 450px;">CSE 5381 : Information Security
				2 - Class project
			<td>
		</tr>
		<tr>
			<td style="text-align: center; padding-left: 450px;">Ankita
				Ramjibhai Patel - 1001790796</td>
		</tr>
	</table>

	<hr style="width: 50%; text-align: center; margin-left: 100">

	<div id='hash' class="tab_content">
		<ul id='tabs' class="tabss">
			<li><a href='#hash'>Secure Hashing</a></li>
			<a href="UniqueKeyController">Back</a>
		</ul>

		<h1>Functionality to generate Secure Hash - MD5</h1>

		<table style="font-size: 16px;">
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					1:</td>
				<td style="width: 90%">Enter plain text in the text box to get
					hashed value</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					2:</td>
				<td style="width: 90%">Click on "Generate New Hash value"</td>
			<tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					3:</td>
				<td style="width: 90%">Generated hashed value will display in
					the table below.</td>
			<tr>
			<tr>
				<td style="width: 10%"></td>
				<td style="width: 90%">This will also show the time taken to
					generate each value.</td>
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
			id="errorMessageLabel">${hashModel.errorMessage}</label>
		</span>

		<table>
			<tr>
				<td>
					<form name="hashForm" action="HashController" method="post"
						style="width: 100%">
						<table style="width: 100%">
							<tr>
								<td colspan=3>Enter your text here :</td>
							</tr>
							<tr>

								<td>
									<input type="text" id="stringToHashTextBox"
										style="width: 400px" name="stringToHashTextBox"
										value='${hashModel.stringToHash}'>
								</td>
								<td style="width: 50px">
									<input type="submit" name="generateHashButton" class="button"
										id="generateHashButton" value="Generate New Hash value">
								</td>
								<td style="width: 500px">
									<input type="submit" name="clearButton" id="clearButton"
										class="button" class="button" value="Clear values">
								</td>

							</tr>

						</table>

						<table style="border: 1px solid black">
							<tr style="border: 1px solid black; background-color: lightgray;">
								<th>Input Text</th>
								<th>Generated Hash Value</th>
								<th>Time taken (ms)</th>
							</tr>
							<c:forEach items="${hashedValuesTableList}" var="hashValue">
								<tr style="border: 1px solid black">
									<td>${hashValue.inputText}</td>
									<td>${hashValue.hashedValue}</td>
									<td>${hashValue.timeTaken}</td>
								</tr>

							</c:forEach>
						</table>
					</form>
				</td>
			</tr>
		</table>

		<table style="font-size: 16px;">
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Note
					:</td>
				<td style="width: 90%">Code referenced from :
					https://www.geeksforgeeks.org/</td>

			</tr>
		</table>

		<table style="font-style: italic; color: gray">
			<tr>
				<td style="padding-left: 220px;">Source code can be found at -
					github.com
				<td>
			</tr>

		</table>

	</div>
</body>
</html>