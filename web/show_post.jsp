<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Posts"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.TimeZone"%>

<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao dao = new PostDao(ConnectionProvider.getConnection());
    Posts post = dao.getPostByPostId(postId);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title><%=post.getPostTitle()%></title>
        <style>
            body {
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            .post-title {
                font-weight: 100;
                font-size: 30px;
            }
            .post-content {
                font-weight: 70px;
                font-size: 20px;
            }
            .post-date {
                font-style: italic;
            }
            .row-user {
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
        </style>
        <%---
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v19.0" nonce="EAFqbFmU"></script>
    ---%>
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
                            <a class="nav-link active" aria-current="page" href="profile.jsp"><span class="fa fa-home "></span> Home</a>
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
        <!--nav end-->
        <!--main content of the body-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-10 offset-md-1">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="post-title"><%=post.getPostTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img src="blog_pic/<%=post.getPostPic()%>" class="card-img-top img-fluid mx-auto   d-block" style="max-width: 500px" alt="...">
                            <div class="row my-3 row-user">
                                <div class="col-md-9">
                                    <% UserDao ud = new UserDao(ConnectionProvider.getConnection()); %>
                                    <p>Writer: <a href="#!"><%= ud.getUserByUserId(post.getUserId()).getName()%></a></p>
                                </div>
                                <div class="col-md-3">
                                    <%
                                        TimeZone timeZone = TimeZone.getTimeZone("Asia/Dhaka");
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, MMMM d, yyyy h:mm a", new Locale("en", "BD"));
                                        dateFormat.setTimeZone(timeZone);
                                        String formattedDate = dateFormat.format(post.getPostDate());
                                    %>
                                    <p class="post-date"><%=formattedDate%></p>
                                </div>
                            </div>
                            <p class="post-content"><%=post.getPostContent()%></p>
                            <br><!-- comment -->
                            <div class="post-code">
                                <pre><%= post.getPostCode() %></pre>
                            </div>
                        </div>
                        <div class="card-footer bg-dark">
                            <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                int pid = post.getPostId(); // Assuming post.getPostId() retrieves the post ID
                                int uid = user.getId();     // Assuming user.getId() retrieves the user ID
                          %>

                            <div class="post">
                                <a href="#!" onclick="doLike(<%= pid %>, <%= uid %>)" class="btn btn-outline-light btn-sm">
                                    <i class="fa fa-thumbs-o-up"></i>
                                    <span class="like-counter"><%= ld.countLikeOnPost(pid) %></span>
                                </a>
                                <a href="#!" onclick="doUnLike(<%= pid %>, <%= uid %>)" class="btn btn-outline-light btn-sm">
                                    <i class="fa fa-thumbs-o-down"></i>
                                </a>
                                <a href="#!" class="btn btn-outline-light btn-sm">
                                    <i class="fa fa-commenting-o"></i>
                                    <span> 20</span> <!-- Replace with actual comment count -->
                                </a>
                            </div>
                        </div>

                        <%--
                    <div class="card-footer">
                        <div class="fb-comments" data-href="http://localhost:9494/TechBlog/show_post.jsp?post_id=<%=post.getPostId()%>" data-width="300px" data-numposts="10"></div>
                    </div>
                        --%>
                    </div>
                </div>
            </div>
        </div>
        <!--end of main content-->
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
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
                    let form = new FormData(this);
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() === 'done') {
                                swal("Good job!", "Post saved successfully", "success");
                            } else {
                                swal("Error!", "Sorry something went wrong", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Error!", "Sorry something went wrong", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
    </body>
</html>
