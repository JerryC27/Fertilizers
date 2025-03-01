<%--
  Created by IntelliJ IDEA.
  User: Jerry Carter
  Date: 17-11-2023
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.Base64" %>
<%!
    byte[] blobToByteArray(Blob blob) throws SQLException, IOException {
        InputStream inputStream = blob.getBinaryStream();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        try {
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            return outputStream.toByteArray();
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }
%>
<html>
<head>
    <title>ADMIN PAGE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .icon{
            width: 200px;
            float: left;
            height: 70px;
        }
        .logo{
            color: #fff;
            font-size: 50px;
            font-family: sans-serif;
            padding-left: 20px;
            float: left;
            padding-top: 10px;
        }
        .menu{
            width: 400px;
            float: left;
            height: 70px;
        }
        .menu ul{
            float: left;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .menu ul li{
            list-style: none;
            margin-left: 62px;
            margin-top: 27px;
            font-size: 14px;
        }
        .menu ul li a{
            text-decoration: none;
            color: #fff;
            font-family: Arial;
            font-weight: bold;
            transition: 0.1s ease-in-out;
        }
        .menu ul li a:hover{
            color: #000;
        }
        .search{
            width: 330px;
            float: left;
            margin-left: 270px;
        }
        .srch{
            font-family: 'Times New Roman';
            width: 200px;
            height: 40px;
            background: transparent;
            border: solid limegreen;
            margin-top: 13px;
            color: #fff;
            border-right: none;
            font-size: 16px;
            float: left;
            padding: 10px;
            border-bottom-left-radius: 5px;
            border-top-left-radius: 5px;
        }
        .btn{
            width: 100px;
            height: 40px;
            background: limegreen;
            border: 2px limegreen;
            margin-top: 13px;
            color: #fff;
            font-size: 15px;
            border-bottom-right-radius: 5px;
            border-bottom-right-radius: 5px;
        }
        .btn:focus{
            outline: none;
        }
        .srch:focus{
            outline: none;
        }

        .content h1{
            font-family: 'Times New Roman';
            font-size: 50px;
            padding-left: 20px;
            margin-top: 2%;
            letter-spacing: 2px;
        }

        .content .cn a{
            text-decoration: none;
            color: #000;
            transition: .3s ease;
        }
        .content .cn a:hover{
            text-decoration: none;
            color: #000;
            transition: .3s ease;
        }

        .content span{
            color: #fff;
            font-size: 60px;
        }
    </style>
</head>
<body>
<img src="Agriculture.jpg" style="position: absolute; z-index: -1; filter: brightness(50%); width: 100%; height: 130%;"  alt="">

<div class="navbar" style="width: 100%; margin-bottom: 4rem;">
    <div class="icon">
        <h1 class="logo">FAS</h1>
    </div>
    <div class="menu" style="margin-left: 7rem">
        <ul>
            <li><a href="#">HOME</a></li>
            <li><a href="#">CALCULATE</a></li>
            <li><a href="#">HELP</a></li>
            <li><a href="index.jsp">EXIT</a></li>
        </ul>
    </div>
    <div class="search" style="margin-left: 25rem">
        <input class="srch" type="search" name="" placeholder="Type to text">
        <a href="#"><button class="btn btn-success" >Search</button></a>
    </div>
</div>

<table class="table table-hover text-center">

    <tr>
        <th scope="col">Image</th>
        <th scope="col">Description</th>
        <th scope="col">Solution</th>
    </tr>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyProject", "root", "admin");
            System.out.println("connected");

            String userID = request.getParameter("u");
            System.out.println(userID);

            PreparedStatement ps = con.prepareStatement("SELECT * FROM Complaint c JOIN User u ON c.user_id = u.user_id WHERE u.user_id = ?; ");
            ps.setString(1, userID);
            ResultSet rs1 = ps.executeQuery();

            while (rs1.next()) {
                int prob=rs1.getInt("prob_id");
                Blob blob = rs1.getBlob("image");
                byte[] imageBytes = blobToByteArray(blob);
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
    %>
    <tr>
        <td><img src="data:image/jpeg;base64,<%= base64Image %>" alt="Complaint Image" style="width: 100px; height: 100px;"></td>
        <td><b><% out.println(rs1.getString("issue")); %></b></td>

    <%
            String solutionData="";
            try {
        PreparedStatement ps1 = con.prepareStatement("SELECT * FROM Solution WHERE user_id = ? AND prob_id=?; ");
        ps1.setString(1, userID);
        ps1.setInt(2,prob);
        ResultSet rs = ps1.executeQuery();
        while (rs.next()) {
            solutionData = rs.getString("descript");

             }
            } catch (Exception e) {
                e.printStackTrace();
            }
    %>
        <td><b><%= solutionData %></b></td>
    </tr>

    <%
            }
    }
    catch (Exception e){
        e.printStackTrace();
    }
    %>
</table>
</body>
</html>
