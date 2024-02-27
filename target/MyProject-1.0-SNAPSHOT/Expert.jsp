<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Expert Login Form</title>
    <link rel="stylesheet" type="text/css" href="adlogin.css">
</head>
<body>
<form class="box" action="Expert" method="post">
    <h1>Expert</h1>

    <input type="text" name="expert_uname" placeholder="Username">

    <input type="password" name="expert_pass" placeholder="pass">
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <p style="color: red; margin-top: 3rem;" ><%= errorMessage %></p>
    <% } %>

    <input type="submit" name="submit" value="Access">
</form>
</body>
</html>

