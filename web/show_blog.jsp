<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>

<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%></title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            body{
                
                background: url(pics/Bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 67% 95%, 33% 99%, 0 94%, 0 0);
            }
            
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
                font-size: 20px;
            }
            .post-user{
                font-weight: 300;
                font-size: 20px;
            }
            .row-user{
                border: 2px solid #e2e2e2;
                padding-top: 15px;
            }
        </style>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"><span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
                            <span class="fa fa-bars"></span> Categories
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-drivers-license"></span> Contact</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span> Do Post</a>
                    </li>

                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle='modal' data-target="#profile-modal"><span class="fa fa-user-circle-o"></span> <%= user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> Log-Out</a>
                    </li>
                </ul>
            </div>
        </nav>


        <!--main content-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">

                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%= p.getpTitle()%></h4>
                        </div>

                        <div class="card-body">
                            
                            <img class="card-img-top my-2" src="pics/<%= p.getpPic() %>" alt="Card image cap">
                            
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <% 
                                        UserDao ud=new UserDao(ConnectionProvider.getConnection());                                       
                                    %>
                                    <p class="post-user"><a href="#"><%= ud.getUserByUserId(p.getUserId()).getName()  %> </a>has Posted:</p>
                                        
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
                                </div>
                            </div>

                            <p class="post-content"><%= p.getpContent()%></p>
                            <br>
                            <br>
                            <div class="post-code">
                            <pre><%= p.getpCode()%></pre>  
                            </div>
                        </div>
                        <div class="card-footer primary-background text-center">
                            <%
                                LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                                %>
                            <a href="#" onclick="doLike(<%= p.getPid() %>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())  %></span></a>
                            <a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>

                        </div>

                    </div>

                </div>
            </div>
        </div>


        <!--profile modal-->        

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid"  style="border-radius:50%; max-width: 150px; "/>
                            <br>
                            <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">E-Mail :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About :</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--profile edit-->
                            <div id="profile-edit" style="display: none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>Id :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>E-Mail :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about"> <%= user.getAbout()%>   </textarea>                                                                                             
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile :</td>
                                            <td>
                                                <input type="file" name="image" class="form-control" />                                                                                             
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button"id="edit-profile-button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid"  style="border-radius:50%; max-width: 150px; "/>
                            <br>
                            <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row">ID :</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">E-Mail :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">About :</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--profile edit-->
                            <div id="profile-edit" style="display: none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <td>Id :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <td>E-Mail :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about"> <%= user.getAbout()%>   </textarea>                                                                                             
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>New Profile :</td>
                                            <td>
                                                <input type="file" name="image" class="form-control" />                                                                                             
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button"id="edit-profile-button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>



        <!--add post modal-->

        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details..</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method='POST'>

                            <div class="form-group">
                                <select class="form-control" name="cid">                               
                                    <!--fetching name of categories from database using PostDao class-->
                                    <option selected disabled>--- Select Category ---</option>

                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {


                                    %>
                                    <option value="<%= c.getCid()%>"><%=c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control" />
                            </div>

                            <div class="form-group">
                                <textarea name="pontent" class="form-control" style="height:200px;" placeholder="Enter the Content"></textarea> 
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" class="form-control" style="height:200px;" placeholder="Enter the Program(if any)"></textarea> 
                            </div>

                            <div class="form-group">
                                <label>Select your pic..</label>
                                <br>
                                <input type="file" name="pic"  />
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>



        <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>

            $(document).ready(function () {
                let editStatus = false;

                $('#edit-profile-button').click(function () {
                    if (editStatus == false) {
                        $("#profile-details").hide()

                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back")
                    } else {
                        $("#profile-details").show()

                        $("#profile-edit").hide();
                        editStatus = false;
                    }



                })
            });
        </script>

        <!--now add post js-->
        <script>
            $(document).ready(function (e) {
                $("add-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted....
                    event.preventDefault();


                    let form = new FormData(this);
                    //now requesting to server
                    $ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success..
                            console.log(data);
                            if (data.trim() == 'done') {
                                swal("Good job!", "Saved Successfully", "success");
                            } else {
                                swal("Error!", "Something went wrong..!", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Error!", "Something went wrong..!", "error");
                        },
                        processData: false,
                        contentType: false
                    })
                })

            })
        </script>

        <!-- //loading post using ajax-->
        <script>
            function getPosts(catId, temp) {
                $("#loader").show();
                $("#post-container").hide();

                $(".c-link").removeClass('active');

                $.ajax({
                    url: "load_post.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                        $(temp).addClass('active');
                    }
                })
            }
            $(document).ready(function (e) {
                let allPostRef = $('.c-link')[0];
                getPosts(0, allPostRef);
            })
        </script>




    </body>
</html>
