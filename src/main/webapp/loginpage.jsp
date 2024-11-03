<%@ page import="com.blog.entities.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
      <title>Login</title>

      <!--bootstrap -->
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
      <%--adding css--%>
      <link href="css/style.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <style>
        .banner-background{
            clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 62% 100%, 28% 85%, 0 100%, 0 0); }     </style>
    </head>
    <body>

    <!--navbar-->
    <%@include file="navigation.jsp"%>
    <main class="d-flex align-items-center primary-background banner-background" style="height:70vh">
      <div class="container">
        <div class="row">
          <div class="col-md-4 offset-md-4">
            <div class="card">
              <div class="card-header primary-background text-white text-center">
                <span class="fa fa-user-plus fa-3x"></span><br>
                <p> Login Here</p>
              </div>
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


                <div class="card-body">

                <form action="LoginServlet" method="POST">
                  <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
                    <div id="emailHelp" class="form-text small"></div>
                  </div>
                  <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input name="password" type="password" class="form-control" id="exampleInputPassword1" required>
                  </div>
                  <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">remember me</label>
                  </div><div class="text-center">
                    <button type="submit" class="btn btn-outline-dark">Log-in</button>
                </div>

                </form>

              </div>
            </div>

          </div>
        </div>

      </div>
    </main>


    <!-- Scripts-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
    <script src="/scripts/script.js" type="text/javascript"></script>


    </body>
</html>
