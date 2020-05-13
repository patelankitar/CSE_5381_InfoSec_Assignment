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

<title>Watermark functionality</title>

<style>
/* html {
	padding: 15px 15px 0;
	font-family: sans-serif;
	font-size: 14px;
} */
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

	<form name="waterMarkForm" action="WaterMarkController" method="post"
		style="width: 100%" enctype="multipart/form-data">

		<ul id='tabs' class="tabss">
			<li><a href='#watermark'>Watermarking</a></li>
			<a href="UniqueKeyController">Back</a>
		</ul>

		<h1>Functionality to add watermark to image :</h1>

		<span style="color: Red"> <label for="errorMessageLabel"
			id="errorMessageLabel">${waterMarkModel.errorMessage}</label>
		</span>

		<table>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					1:</td>
				<td>
					<label for="myfile">Browse an Image file:</label> <input
						type="file" name="uploadedFile" value="Browse File" class="button"/>
				</td>
			</tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					2:</td>
				<td>
					<label for="uploadImageButton">Upload file:</label> <input
						type="submit" name="uploadImageButton" id="uploadImageButton" class="button"
						value="upload Image" />
						<label name="uploadImageConfirmMessage" id="uploadImageConfirmMessage" style="font-style: italic;">${waterMarkModel.imageUploadMessage}</label>
				</td>
			</tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					3:</td>
				<td>
					<label for="waterMarkTextBox">Add text to add as Watermark
						on image:</label> <input type="text" name="waterMarkTextBox"
						id="waterMarkTextBox">
				<td />

			</tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td
					style="width: 10%; font-style: italic; text-decoration: underline;">Step
					4:</td>
				<td>
					<input type="submit" name="submitButton" id="submitButton" class="button"
						value="Add Watermark to Image" />
				</td>
			</tr>
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span style="color: black"> <label for="timeTakenLabel"
						id="timeTakenLabel">${waterMarkModel.timeTaken}</label>
					</span>
				</td>
			</tr>
			
			<tr>
				<td colspan=2 height="10px"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" name="clearButton" id="clearButton"
										class="button" value="Clear values">
				</td>
			</tr>

		</table>
		<table>
			<tr>
				<td>
					<label for="firstImage"> Origional Image </label>
				</td>
				<td>
					<img
						src="<%=request.getContextPath() %>/${waterMarkModel.originalImgPath}"
						height="80%" width="80%">
				</td>
			</tr>
			<tr>
				<td>
					<label for="firstImage"> Watermarked Image </label>
				</td>
				<td>
					<img
						src="<%=request.getContextPath() %>/${waterMarkModel.waterMarkedImgPath}"
						height="80%" width="80%">
				</td>

			</tr>

		</table>
	</form>



	<table style="font-size: 16px;">
		<tr>
			<td
				style="width: 10%; font-style: italic; text-decoration: underline;">Note
				:</td>
			<td style="width: 90%">Code referenced from :
				https://stackoverflow.com/</td>

		</tr>
	</table>

	<table style="font-style: italic; color: gray">
		<tr>
			<td style="padding-left: 420px;">Source code can be found at -
				github.com
			<td>
		</tr>

	</table>


</body>
</html>