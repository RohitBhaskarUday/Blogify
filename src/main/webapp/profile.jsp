
<%@page import="com.blog.entities.User" %>
<%@page errorPage="errorpage.jsp" %>
<%--if the user has did not loggedin--%>
<%
    User user = (User) session.getAttribute("currentUser");
    if(user==null){

        response.sendRedirect("loginpage.jsp");

    }
%>
<html>
<head>
    <title>Profile</title>
</head>
<body>
    <%= user.getName()%>
    <br>
    <%= user.getEmail()%>
    <br>
    <%= user.getAbout()%>

</body>
</html>
