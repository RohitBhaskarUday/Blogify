
<%@page import="com.blog.entities.User" %>
<%@ page import="com.blog.entities.Message" %>
<%@ page import="com.blog.dao.PostDAO" %>
<%@ page import="com.blog.handler.ConnectionProvider" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blog.entities.Category" %>
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
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 62% 100%, 28% 85%, 0 100%, 0 0); }
        body{
            background-size: cover;
            background: url(images/bg.jpg);
            background-attachment: fixed;
        }
        .sticky-sidebar {
             /* Safari support */
            position: sticky;
            top: 0; /* adjust this offset as needed (the height of your navbar) */
        }
        .card {
            border-radius: 10px; /* Slightly rounded corners */
        }
        .card-header {
            background: #343a40; /* Dark grey */
            color: #fff;
        }

        .list-group-item:hover {
            background-color: lightskyblue;
            color: #000;
            cursor: pointer;
        }


    </style>

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
            <li class="nav-item active">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-heart"></span> Something on your mind?</a>
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


<%--main body of the profile page--%>
<main>
    <div class="container" >
        <div class="row mt-4 ">
            <%--first column--%>
                <div class="col-md-3 sticky-sidebar">
                    <div class="card mb-4">
                        <div class="card-header text-white bg-primary">
                            <strong>Categories</strong>
                        </div>
                        <div class="list-group list-group-flush">
                            <a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active">
                                All Categories
                            </a>
                            <%-- Loop through the categories --%>
                            <%
                                PostDAO catList = new PostDAO(ConnectionProvider.getConnection());
                                ArrayList<Category> ls = catList.getCategories();
                                for(Category cc: ls){
                            %>
                            <a href="#"
                               onclick="getPosts(<%= cc.getCid() %>, this)"
                               class="c-link list-group-item list-group-item-action">
                                <%= cc.getName() %>
                            </a>
                            <%
                                }
                            %>
                        </div>
                        <div class="text-center"><button type="button" id="add-category" class="btn btn-center" data-toggle="modal" data-target="#addCategoryModal">
                            <i class="fa fa-plus"></i> Add Category
                        </button></div>

                    </div>
                </div>
            <%--second column--%>
            <div class="col-md-9" >
            <%--posts--%>
                <div class="container text-center" id="loader">
                    <i class="fa fa-refresh fa-3x fa-spin"></i>
                    <h3 class="mt-3">Loading...</h3>
                </div>

                <div class="container-fluid" id="post-container">


                </div>

            </div>


        </div>

    </div>
</main>

<%-- Add category model --%>
<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addCategoryLabel">Create New Category</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="add-category-form" action="AddCategoryServlet" method="POST">
        <div class="modal-body">
          <div class="form-group">
            <label>Category Name</label>
            <input type="text" name="categoryName" class="form-control" required>
          </div>
          <div class="form-group">
            <label>Description (optional)</label>
            <textarea name="categoryDesc" class="form-control" rows="3"></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Create</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</div>


<%-- end the main body of the profile page--%>

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

<%--add your post starts here--%>
<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fs-5" id="post-heading">Jot that down!</h3>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="add-post-form" action="AddPostServlet" method="POST">
                    <div class="form-group">
                        <label>Type of Content</label>
                        <label>
                            <select class="form-control" name="cid">
                                <option selected disabled>--Select Category--</option>
                                <%
                                    PostDAO postdao = new PostDAO(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postdao.getCategories();
                                    for(Category category: list)
                                    {
                                %>
                                <option value="<%=category.getCid()%>"><%=category.getName()%></option>
                                <% }
                                %>
                            </select>
                        </label>


                    </div>
                    <div class="form-group">
                        <input name="pTitle" type="text" placeholder="Enter the title of your blog." class="form-control">
                    </div>

<%--                    this is where the user writes the content--%>
                    <div class="form-group">
                        <textarea id="pContent" name="pContent" class="form-control" style="height: 200px" placeholder="Enter the content over here.."></textarea>
                    </div>
                    <div class="d-flex justify-content-start" style="padding-bottom: 15px">
                        <button type="button" id="enhance-content" class="btn btn-outline-primary mr-2">Enhance Content</button>
                        <button type="button" id="grammar-checker" class="btn btn-outline-primary mr-2">Grammar-Check</button>
                        <button type="button" id="generate-idea" class="btn btn-outline-primary">Give Ideas</button>

                    </div>
                    <div class="form-group">
                        <textarea name="pCode" class="form-control" style="height: 200px" placeholder="Enter any kind of code over here..if any"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Select a picture to upload</label>
                        <input type="file" name="pic" >
                    </div>
                    <div class="container text-center"><button type="submit" class="btn btn-outline-primary">Post</button>
                    </div>
            </form>


        </div>
    </div>
</div>

<%--adding the post ends here--%>

<%--javascript starts here--%>

<!-- Scripts-->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="scripts/script.js" type="text/javascript"></script>

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

    <script>

        $(document).ready(function (){
            //we will start with a listener
            $("#add-category-form").on("submit",function(event){
                //this code gets called when form is submitted
                event.preventDefault(); // the form's normal behaviour would be stopped.
                //i,e the synchronous process would be stopped.
                console.log("You submitted the form")

                //now we will extract the form data
                let form = $(this).serialize();

                //now we are requesting the server
                $.ajax({
                    url:"AddCategoryServlet",
                    type: 'POST',
                    data: form,
                    success: function (response){
                        if (response.trim() === "success") {
                            // Close the modal and reset the form


                            // Reset the form
                            $("#add-category-form")[0].reset();

                            $("#addCategoryModal").hide();


                            // Display a success message
                            swal("Great!", "Your category has been added!", "success");
                            location.reload();

                        } else {
                            // Display an error message
                            swal("Error", "Could not add the category. Please try again.", "error");
                        }
                    },
                    error: function (){
                        //error..
                        swal("Error", "Please try again!", "error");
                    },
                });

            });

        });

    </script>



<script>
    //upon sending submit from enhance content we should be able to send the data to llm ?
    $(document).ready(function () {
        $('#enhance-content').on('click', function () {
            //event.preventDefault();
            const content = $('#pContent').val();

            if (!content.trim()) {
                alert("Please write something to correct or enhance!");
                return;
            }
            //const content = $('#content-area').val(); // Get the content from the textarea
            $.ajax({
                url: "EnhanceContentServlet",
                type: "POST",
                data: { pContent: content },
                success: function (response){
                    const enhancedContent = JSON.parse(response); // Parse the LLM response
                    if (enhancedContent.status !== "success") {
                        swal("Error", "Could not enhance content. Please try again.", "error");
                    } else {
                        $('#pContent').val(enhancedContent.enhancedContent); // Update the textarea with enhanced content
                        //swal("Enhanced!", "Your content has been enhanced.", "success");
                    }
                }
            });
        });
    });

</script>

    <script>
        $(document).ready(function () {
            $('#grammar-checker').on('click', function (){
                const content = $('#pContent').val();
                if (!content.trim()) {
                    alert("Please write something to correct or enhance!");
                    return;
                }
                $.ajax({
                    url: "GrammarCheckServlet",
                    type: "POST",
                    data: { pContent: content },
                    success: function (response){
                        const enhancedContent = JSON.parse(response); // Parse the LLM response
                        if (enhancedContent.status !== "success") {
                            swal("Error", "Could not enhance content. Please try again.", "error");
                        } else {
                            $('#pContent').val(enhancedContent.enhancedContent); // Update the textarea with enhanced content
                            //swal("Enhanced!", "Your content has been enhanced.", "success");
                        }
                    }
                });
            })
        });
    </script>

<script>

    $(document).ready(function (e){
        //we will start with a listener
        $("#add-post-form").on("submit",function(event){
            //this code gets called when form is submitted
            event.preventDefault(); // the form's normal behaviour would be stopped.
            //i,e the synchronous process would be stopped.
            console.log("You submitted the form")

            //now we will extract the form data
            let form = new FormData(this);

            //now we are requesting the server
            $.ajax({
                url:"AddPostServlet",
                type: 'POST',
                data: form,
                success: function (data, textStatus, jqXHR){
                    //success
                    console.log(data)
                    if(data.trim()==='done.'){
                        $("#add-post-modal").hide();
                        swal("Great!", "Your blog has been posted.", "success");
                    }else{
                        swal("Error", "Please try again!", "error");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown){
                    //error..
                    swal("Error", "Please try again!", "error");
                },
                processData: false,
                contentType: false
            })

        })

    });

</script>

<%--    loading post using ajax--%>
    <script>

        function getPosts(catId, temp){
            $("#loader").show();
            $("#post-container").hide();

            $(".c-link").removeClass('active')


            $.ajax({
                url: "loadposts.jsp",
                data: {cid: catId},
                success: function (data, textStatus, jqXHR){
                    console.log(data)
                    $('#loader').hide()
                    $('#post-container').show();
                    $('#post-container').html(data)
                    $(temp).addClass('active')
                }
            })
        }

        $(document).ready(function (e){
            let allPostRef = $('.c-link')[0]
            getPosts(0, allPostRef)
        })
    </script>


</body>
</html>
