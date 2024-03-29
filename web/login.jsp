
<%@page import="com.tech.blog.entities.Message"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .banner-background {
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 100% 78%, 75% 83%, 52% 91%, 23% 85%, 0 89%, 0 0, 23% 0);
            }
        </style>

    </head>
    <body>

        <%@include file="navbar.jsp" %>

        <main class="d-flex align-items-center bg-dark banner-background" style="height:70vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header bg-dark text-white text-center">
                                <h3><span class="fa fa-user-circle"></span> Login Here</h3>
                            </div>
                            
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
                            
                            <div class="card-body">
                                <form action="LoginServlet" method="post">
                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                                        <input name="user_email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                        <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="exampleInputPassword1" class="form-label">Password</label>
                                        <input name="user_password" required type="password" class="form-control" id="exampleInputPassword1">
                                    </div>
                                    <div class="mb-2 d-inline-flex">
                                        <button type="submit" class="btn btn-outline-dark">Login</button>
                                        <a href="register.jsp" style="margin-left:10px;margin-top:5px"><p>Create Account</p></a>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
