
<%@page import="com.blog.entities.User" %>
<%@ page import="com.blog.entities.Message" %>
<%@page errorPage="errorpage.jsp" %>

<%--if the user has did not loggedin--%>
<%User user = (User) session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("loginpage.jsp");
    }
%>
<html>
<head>
    <title>Profile</title>
    <!--bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <%--adding css--%>
    <link href="css/style.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .banner-background{
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 62% 100%, 28% 85%, 0 100%, 0 0); } </style>

</head>
<body>

<%--   nav bar starts--%>
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-sticky-note"></span>  Blogify</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#"><span class="fa fa-pencil-square-o"></span> Write a Blog</a>
            </li>

            <li class="nav-item active dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                    <span class="fa fa-check-square-o"></span> Categories
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#">Tech</a>
                    <a class="dropdown-item" href="#">Lifestyle</a>
                    <a class="dropdown-item" href="#">Travel</a>
                    <a class="dropdown-item" href="#">Food</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Fashion</a>
                </div>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="#"> <span class="fa fa-address-book-o"></span> About</a>
            </li>

        </ul>

        <ul class="navbar-nav mr-right">
            <li class="nav-item active">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#profileModal"> <span class="fa fa-user-circle"></span> <%=user.getName()%></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="LogoutServlet"> <span class="fa fa-sign-out"></span> Logout</a>
            </li>

        </ul>


    </div>
</nav>
<%--nav bar ends over here--%>
<%
    Message message = (Message) session.getAttribute("msg");
    if(message!=null)
    {
%>
<div class="alert <%=message.getCssClass()%>" role="alert">
    <%=message.getContent()%>
</div>
<% session.removeAttribute("msg");
} %>

<%--start of the profile modal--%>
<!-- Button trigger modal -->
<%--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#profileModal">--%>
<%--    Launch demo modal--%>
<%--</button>--%>

<!-- Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title"> Welcome Blogify User!</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body ">
                <div class="container text-center">
                    <img src="pictures/<%=user.getProfile()%>" style="width: 150px; height: 150px; object-fit: cover;" >
                <h4 class="modal-title " id="exampleModalLabel"><%=user.getName()%></h4>
                    <br>
<%--                    details--%>
                    <div id="profile-details">
                    <table class="table">

                        <tbody>
                        <tr>
                            <th scope="row">I.D.</th>
                            <td> <%=user.getId()%> </td>
                        </tr>
                        <tr>
                            <th scope="row">Email Address</th>
                            <td> <%=user.getEmail()%> </td>
                        </tr>
                        <tr>
                            <th scope="row">Gender</th>
                            <td> <%=user.getGender()%> </td>
                        </tr>
                        <tr>
                            <th scope="row">About</th>
                            <td> <%=user.getAbout()%> </td>
                        </tr>
                        <tr>
                            <th scope="row">Joined on</th>
                            <td> <%=user.getDateTime().toString()%> </td>
                        </tr>

                        </tbody>
                    </table>
                    </div>
<%--                    profile editing starts here--%>
                    <div id="profile-edit" style="display: none">
                        <h5 class="mt">Make your changes here</h5>
                        <form action="EditServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tr>
                                    <td>I.D.</td>
                                    <td><%=user.getId()%></td>
                                </tr>
                                <tr>
                                    <td>Name: </td>
                                    <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                                </tr>
                                <tr>
                                    <td>Email: </td>
                                    <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                                </tr>
                                <tr>
                                    <td>Password: </td>
                                    <td><input type="password" id="passwordInput" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                                </tr>
                                <tr>
                                    <td>About: </td>
                                    <td>
                                        <textarea rows="3" class="form-control" name="user_about"><%=user.getAbout()%></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Gender: </td>
                                    <td><%=user.getGender().toUpperCase()%></td>
                                </tr>
                                <tr>
                                    <td>Profile: </td>
                                    <td><input type="file" class="form-control" name="image"></td>
                                </tr>

                            </table>

                            <div class="container">
                                <button type="submit" class="btn btn-outline-primary">Save Changes</button>
                            </div>

                        </form>


                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
            </div>
        </div>
    </div>
</div>


<%--end of profile modal--%>

<%--javascript starts here--%>

<!-- Scripts-->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<script src="/scripts/script.js" type="text/javascript"></script>

<script>
    $(document).ready(function (){
        //for toggle button of edit
        let editStatus = false;

        $('#edit-profile-button').click(function (){
            //this is the toggle logic.
           if(editStatus==false){
               $('#profile-details').hide()
               $('#profile-edit').show()
               editStatus=true;
               $(this).text("Back")

           }else{
               $('#profile-details').show()
               $('#profile-edit').hide()
               editStatus=false;
               $(this).text("Edit")
           }


        })
    });

</script>



</body>
</html>
