<%-- 
    Document   : error_page
    Created on : Mar 14, 2024, 10:29:49 AM
    Author     : Hridoy
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! something went wrong</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        
        <div class="container text-center">
            <img src="img/warning.png" class="img-fluid mt-3" style="max-width: 300px">
            <h4 class="display-4">Sorry! Something went wrong...</h4>
            
            <a href="index.jsp" class="btn btn-outline-dark mt-2">Home</a>
        </div>
        
    </body>
</html>
