<%-- 
    Document   : index
    Created on : Mar 12, 2024, 12:36:35 PM
    Author     : Shaon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 44%, 100% 51%, 82% 63%, 55% 64%, 33% 93%, 0 93%, 0 49%, 0 0);
            }
        </style>
    </head>
    <body>

        <%@include file="navbar.jsp" %>

        <div class="container-fluid p-0 m-0 banner-background">
            <div class="jumbotron pt-4 pb-5 bg-dark text-light ">
                <div class="container">
                    <h3 class="display-3">Welcome To Tech Blog</h3>
                    <p>Welcome to Tech Blog, Learn and Implement The Idea.</p>
                    <button class="btn btn-outline-light"><span class="fa fa-external-link"></span> Start! it's free</button>
                    <a href="login.jsp" class="btn btn-outline-light"><span class="fa fa-user-circle fa-spin"></span> Login</a>    
                </div>
            </div>
        </div>
        
        <!--card -->
        
        <div class="container">
            <div class="row pt-4">
                <div class="col-md-4">
                    <div class="card">  
                        <div class="card-body">
                            <h5 class="card-title">JAVA</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn btn-outline-dark">Read More</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">  
                        <div class="card-body">
                            <h5 class="card-title">JAVA</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn btn-outline-dark">Read More</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">  
                        <div class="card-body">
                            <h5 class="card-title">JAVA</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn btn-outline-dark">Read More</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row pt-4">
                <div class="col-md-4">
                    <div class="card">  
                        <div class="card-body">
                            <h5 class="card-title">JAVA</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn btn-outline-dark">Read More</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">  
                        <div class="card-body">
                            <h5 class="card-title">JAVA</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn btn-outline-dark">Read More</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">  
                        <div class="card-body">
                            <h5 class="card-title">JAVA</h5>
                            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            <a href="#" class="btn btn-outline-dark">Read More</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <script>

        </script>

    </body>
</html>
