<%@page import ="java.sql.*"%>
<%@ page import="com.blog.handler.ConnectionProvider" %>
<html>
<head>
    <title>Home</title>
        <!--bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <%--adding css--%>
        <link href="css/style.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 62% 100%, 28% 85%, 0 100%, 0 0); } </style>

</head>
<body>
<%--navbar--%>
<%@include file="navigation.jsp"%>


<%--creation of banner--%>
<div class="container-fluid p-0 m-0 banner-background">
    <div class="jumbotron primary-background text-white">
        <div class="container">
            <h3 class="display-3"> Welcome to Blogify!</h3>

            <p> Jot down your own ideas, thoughts and stories. Whether you're an experienced writer or just getting started, our platform makes it easy to share your thoughts, stories, and expertise with large audience. Explore a wide range of topics, from tech and travel to personal insights and creative musings.</p>

            <a href="registerpage.jsp" class="btn btn-outline-light"><span class="fa fa-sign-in"></span> Get Started!</a>
            <a href="loginpage.jsp" class="btn btn-outline-light"><span class="fa fa-user-circle fa-spin"></span> Login</a>
        </div>
    </div>




</div>

<%--cards--%>
<div class="container">
    <div class="row mb-2">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Technology</h5>
                    <p class="card-text">Explore the ways and ideas on technology</p>
                    <a href="#" class="btn btn-primary">Check this out</a>
                </div>
            </div>

        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Technology</h5>
                    <p class="card-text">Explore the ways and ideas on technology</p>
                    <a href="#" class="btn btn-primary">Check this out</a>
                </div>
            </div>

        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Technology</h5>
                    <p class="card-text">Explore the ways and ideas on technology</p>
                    <a href="#" class="btn btn-primary">Check this out</a>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Technology</h5>
                    <p class="card-text">Explore the ways and ideas on technology</p>
                    <a href="#" class="btn btn-primary">Check this out</a>
                </div>
            </div>

        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Technology</h5>
                    <p class="card-text">Explore the ways and ideas on technology</p>
                    <a href="#" class="btn btn-primary">Check this out</a>
                </div>
            </div>

        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Technology</h5>
                    <p class="card-text">Explore the ways and ideas on technology</p>
                    <a href="#" class="btn btn-primary">Check this out</a>
                </div>
            </div>

        </div>
    </div>


</div>




<!-- Scripts-->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<script src="/scripts/script.js" type="text/javascript"></script>


</body>


</html>
