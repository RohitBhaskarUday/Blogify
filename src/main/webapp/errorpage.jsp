
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true" %>
<html>
<head>
    <title>Oops! Something went wrong...</title>
  <!--bootstrap -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
  <%--adding css--%>
  <link href="css/style.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    .banner-background{
      clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 62% 100%, 28% 85%, 0 100%, 0 0); } </style>
</head>
<body>

<div class="container text-center" style="padding-top: 10vh">

  <img src="images/error.png" class="img-fluid">
  <h3 class="display-4" >Sorry! Something went wrong.</h3>

  <a href="index.jsp" class="btn primary-background btn-lg text-white mt-1" > Back to Home</a>

</div>



</body>
</html>
