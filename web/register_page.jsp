
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 67% 95%, 33% 99%, 0 94%, 0 0);
            }
        </style>
    </head>
    <body>

        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>

        <main class=" primary-background  banner-background" style="padding-bottom:100px;">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-user-plus fa-3x"></span>
                            <br>
                            <p>Register Here</p>
                        </div>
                        <div class="card-body" >
                            <form id="reg-form" action="RegisterServlet" method="POST">

                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input name="user_name" type="textl" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter Name">         
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter E-Mail">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Enter Password">
                                </div>

                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <br>
                                    <input type="radio"  id="gender" name="gender" value="Male"> Male
                                    <input type="radio"  id="gender" name="gender" value="FeMale"> Female
                                </div>

                                <div class="form-group">
                                    <textarea name="about" class="form-control" rows="5" placeholder="Enter about yourself"></textarea>
                                </div>

                                <div class="form-group form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree Terms & Conditions</label>
                                </div>

                                <br>
                                <div class="container text-center " id="loader" style="display:none;">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please Wait....</h4>
                                </div>                                                          
                                <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </main>

        <!--javascript-->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script> 
        <script>
            $(document).ready(function () {
                console.log("Loaded...");

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $("#submit-btn").hide();
                    $("#loader").show();
                    //send register servlet
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#submit-btn").show();
                            $("#loader").hide();
                            
                            if(data.trim()=='done'{
                            swal("Registered Successfull..")
                                    .then((value) => {
                                        window.location="login_page.jsp";
                                    });
                                }else{
                                    swal(data);
                                }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#submit-btn").show();
                            $("#loader").hide();
                           swal("Something Went Wrong...Try Again");
                                  
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });

        </script>
    </body>
</html>
