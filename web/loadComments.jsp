<%@ page import="your.package.CommentDao" %>
<%@ page import="your.package.ConnectionProvider" %>
<%@ page import="your.package.UserDao" %> <!-- Import UserDao for fetching user profiles -->

<%
    CommentDao cDao = new CommentDao(ConnectionProvider.getConnection());
    UserDao ud = new UserDao(ConnectionProvider.getConnection()); // Initialize UserDao
    ArrayList<Comments> comments = cDao.getComments();

    for (Comments c : comments) {
%>
    <div class="card mb-3" style="max-width: 440px;">
        <div class="row g-0">
            <div class="col-md-4 d-flex align-items-center justify-content-center">
                <img src="img/<%= ud.getUserByUserId(c.getUid()).getProfile() %>" class="img-fluid rounded-circle" style="width: 60px; height: 60px;" alt="Profile Image">
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title"><%= ud.getUserByUserId(c.getUid()).getName() %></h5>
                    <p class="card-text"><%= c.getComment() %></p>
                </div>
            </div>
        </div>
    </div>
<%
    }
%>
