
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

  <title>Register</title>
  <!--bootstrap -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
  <%--adding css--%>
  <link href="css/style.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    .banner-background{
      clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 62% 100%, 28% 85%, 0 100%, 0 0);
    } </style>

</head>
<body>
<%--adding nav bar--%>
<%@include file="navigation.jsp"%>

<main class="primary-background " style="padding-bottom: 20px">

  <div class="container" >

    <div class="col-md-6 offset-md-3">

      <div class="card">
        <div class="card-header primary-background text-center text-white">
          <span class="fa fa-sign-in fa-3x text-white"></span> <br> Register Here
        </div>
        <div class="card-body">
          <form id="reg-form" action="RegisterServlet" method="POST">
            <div class="mb-3">
              <label for="user_name" class="form-label">User Name</label>
              <input name="user_name" placeholder="Enter your name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp">
            </div>

            <div class="mb-3">
              <label for="exampleInputEmail1" class="form-label">Email address</label>
              <input name="user_email" placeholder="Enter your email address" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
              <div id="emailHelp" class="form-text small">We'll never share your email with anyone else.</div>
            </div>

            <div class="mb-3">
              <label for="exampleInputPassword1" class="form-label">Select Gender</label>
              <br>
              <input type="radio" id="gender" name="gender" value="male"> Male
              <input type="radio" id="gender" name="gender" value="female"> Female
            </div>

            <div class="mb-3">

                <textarea name="about" class="form-control"  rows="5" placeholder="A little about yourselves"></textarea>

            </div>



            <div class="mb-3">
              <label for="exampleInputPassword1" class="form-label">Password</label>
              <input type="password" name="user_password" placeholder="Enter your password" class="form-control" id="exampleInputPassword1">
            </div>

            <div class="mb-3 form-check">
              <input name="check" type="checkbox" class="form-check-input " id="exampleCheck1">
              <label class="form-check-label " for="exampleCheck1">Terms & Conditions</label>
            </div>
            <div class="text-center" id="loader" style="display: none;">
            <span class="fa fa-refresh fa-spin fa-4x"></span>
              <h4>Please wait..</h4>
            </div>
            <div class="text-center"><button id="submit-btn" type="submit" class="btn btn-outline-dark">Submit</button></div>

          </form>

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
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
  $(document).ready(function (){

    console.log("page loaded successfully")

    $('#reg-form').on('submit', function (event){
      event.preventDefault();
      let form = new FormData(this);

      $('#submit-btn').hide();
      $('#loader').show();
      //now send register Servlet:
      $.ajax({
        url: "RegisterServlet",
        type: 'POST',
        data: form,
        success: function (data, textStatus, jqXHR) {
          console.log(data)
          $('#submit-btn').show();
          $('#loader').hide();

          if(data.trim()==="Registered Successfully!"){

            swal("Registration successfully! redirecting..")
                    .then((value) => {
                      window.location = "loginpage.jsp"
                    });

          } else{
            swal(data)
          }
        },
        error: function (jqXHR, textStatus, errorThrown) {
          swal("Oops! Something went wrong. Please try again");
          $('#submit-btn').show();
          $('#loader').hide();
        },
        processData: false,
        contentType: false
      });
    });
  });

</script>

</body>
</html>
