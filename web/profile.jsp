<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@ page import="java.util.ArrayList" %>


<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            /* Add your custom styles here */
            body{
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            .profile-modal-header {
                background-color: #343a40;
                color: white;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-dark navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp"><span class="fa fa-cogs"></span> Tech Blog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#"><span class="fa fa-home "></span> Home</a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="fa fa-check-square-o"></span> Category
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Programming Languages</a></li>
                                <li><a class="dropdown-item" href="#">Data Structure and Algorithms</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">SDLC</a></li>
                                <li><a class="dropdown-item" href="#">WEB API</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#"><span class="fa fa-phone-square"></span> Contact Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#do-post-modal"><span class="fa fa-upload"></span> Do Post</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav mr-right">
                        <li class="nav-item">
                            <a class="nav-link" href="#!"  data-bs-toggle="modal" data-bs-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LogoutServelt"><span class="fa fa-sign-out"></span> Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <%
            Message msg = (Message) session.getAttribute("msg");
            if (msg != null) {
        %>
        <div class="alert <%=msg.getCssClass()%>" role="alert">
            <%= msg.getContent()%>
        </div>
        <%  
            session.removeAttribute("msg");
            }
        %>                   

        <!--main body of the page started-->

        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first column-->
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active" aria-current="true">
                                All Post
                            </a>
                            <%
                                PostDao dao=new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category>list1=dao.getCategories();
                                for(Category cc:list1){
                            %>
                            <a href="#" onclick="getPosts(<%=cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                            <%
                        }
                            %>
                            <!--<a href="#" class="list-group-item list-group-item-action disabled" tabindex="-1" aria-disabled="true">A disabled link item</a>-->
                        </div>
                    </div>
                    <!--second column-->
                    <div class="col-md-8">
                        <!--post-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-3x fa-spin"></i>
                            <h4 class="mt-2">Loading...</h4>
                        </div>
                        <div class="container-fluid" id="post-container">

                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--main body of the page end-->

        <!-- Profile Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-top">
                <div class="modal-content">
                    <div class="modal-header profile-modal-header">
                        <h5 class="modal-title">TechBlog</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <img src="img/<%=user.getProfile()%>" class="img-fluid rounded-circle" style="max-width: 100px;" alt="User Profile Picture">
                            <h5 class="mt-3"><%=user.getName()%></h5>
                            <div id="profile-details">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Id: </th>
                                            <td><%=user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email: </th>
                                            <td><%=user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender: </th>
                                            <td><%=user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th>About: </th>
                                            <td><%=user.getAbout()%></td>
                                        </tr>
                                        <tr>
                                            <th>Registered on: </th>
                                            <td><%=user.getDateTime().toString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--profile edit-->

                            <div id="profile-edit" style="display: none;">
                                <h6 class="p-2">Edit Profile</h6>
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                    <div class="row mb-3">
                                        <label for="user_name" class="col-sm-3 col-form-label">Name:</label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control" id="user_name" name="user_name" value="<%=user.getName()%>" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="user_email" class="col-sm-3 col-form-label">Email:</label>
                                        <div class="col-sm-9">
                                            <input type="email" class="form-control" id="user_email" name="user_email" value="<%=user.getEmail()%>" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="user_password" class="col-sm-3 col-form-label">Password:</label>
                                        <div class="col-sm-9">
                                            <input type="password" class="form-control" id="user_password" name="user_password" value="<%=user.getPassword()%>" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="user_about" class="col-sm-3 col-form-label">About:</label>
                                        <div class="col-sm-9">
                                            <textarea rows="2" class="form-control" id="user_about" name="user_about" required><%=user.getAbout()%></textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="image" class="col-sm-4 col-form-label">Profile Picture:</label>
                                        <div class="col-sm-8">
                                            <input type="file" class="form-control" id="image" name="image">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-10 offset-sm-2">
                                            <button type="submit" class="btn btn-outline-dark">Save</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>

        <!--Post Modal -->
        <div class="modal fade" id="do-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content" style="background-color: #fff; color: #000;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide the post details.</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" name="add-post-form" action="AddPostServlet" method="POST">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>
                                    <% 
                                        PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postDao.getCategories();
                                        for(Category c : list) { 
                                    %>
                                    <option value="<%=c.getCid()%>"><%= c.getName() %></option>
                                    <% } %>
                                    <!-- Add other options if needed -->
                                </select>
                            </div>
                            <br>
                            <div class="form-group">
                                <input name="postTitle" type="text" placeholder="Enter post title" class="form-control">
                            </div>
                            <br>
                            <div class="form-group">
                                <textarea name="postContent" class="form-control" placeholder="Enter your content" style="height:120px"></textarea>
                            </div>
                            <br>
                            <div class="form-group">
                                <textarea name="postCode" class="form-control" placeholder="Enter your code(If any)" style="height:120px"></textarea>
                            </div>
                            <br>
                            <div class="form-group">
                                <label>Select Photo</label>
                                <input name="pic" type="file">
                            </div>
                            <div class="container text-center mt-1">
                                <button type="submit" class="btn btn-primary">Post</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- JavaScript Dependencies -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <script>
                                $(document).ready(function () {
                                    let editStatus = false;
                                    $('#edit-profile-button').click(function () {
                                        if (editStatus === false) {
                                            $("#profile-details").hide();
                                            $("#profile-edit").show();
                                            editStatus = true;
                                            $(this).text("Back");
                                        } else {
                                            $("#profile-details").show();
                                            $("#profile-edit").hide();
                                            editStatus = false;
                                            $(this).text("Edit");
                                        }
                                    });
                                });
        </script>

        <!--post js-->
        <script>
            $(document).ready(function () {
                $("#add-post-form").on("submit", function (event) {
                    event.preventDefault(); // Prevents the default form submission behavior

                    // Creates a new FormData object from the form with id "add-post-form"
                    let form = new FormData(this);

                    // Ajax call
                    $.ajax({
                        url: "AddPostServlet", // URL to which the request is sent
                        type: 'POST', // HTTP method (POST in this case)
                        data: form, // Data to be sent to the server (form data)
                        success: function (data, textStatus, jqXHR) { // Success callback function
                            // Executes if the request succeeds
                            if (data.trim() === 'done') {
                                // Display success message using SweetAlert
                                swal("Good job!", "Post saved successfully", "success");
                            } else {
                                // Display error message using SweetAlert
                                swal("Error!", "Sorry something went wrong", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) { // Error callback function
                            // Executes if the request fails
                            // Display error message using SweetAlert
                            swal("Error!", "Sorry something went wrong", "error");
                        },
                        processData: false, // Ensures that FormData is not processed as a query string
                        contentType: false // Ensures correct content type for FormData
                    });
                });
            });


        </script>
        <!--loading post using ajax-->

        <script>
            function getPosts(catId,temp) {
                $("#loader").show();
                $("#post-container").hide();
                
                $(".c-link").removeClass('active');
                
                
                $.ajax({
                    url: "load_post.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show(); // Fixed typo here
                        $("#post-container").html(data);
                        $(temp).addClass('active');
                    }
                });
            }
            $(document).ready(function (e) {
                let allPostRef=$('.c-link')[0];
                getPosts(0,allPostRef);
            });
        </script>

    </body>
</html>
