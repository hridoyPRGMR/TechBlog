<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%@page import="com.tech.blog.entities.Message"%>

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

        <!-- JavaScript Dependencies -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
                })
            });
        </script>

    </body>
</html>
