<html lang="en" dir="ltr">
<head>
	<meta charset="utf-8">
	<title>Admin Login Form</title>
	<link rel="stylesheet" type="text/css" href="adlogin.css">
</head>
<body>
	<form class="box" action="AdminLogin" method="post">
		<h1>Admin</h1>
		
		<input type="text" name="admin_uname" placeholder="Username">
		
		<input type="password" name="admin_pass" placeholder="pass">
		<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
		<% if (errorMessage != null) { %>
		<p style="color: red; margin-top: 3rem;" ><%= errorMessage %></p>
		<% } %>
		
		<input type="submit" name="submit" value="Access">
	</form>
</body>
</html>

