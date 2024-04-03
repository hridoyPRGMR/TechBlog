<%@ page import="java.util.List" %>
<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.entities.Posts" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>

<div class="row">
    <%
        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        List<Posts> posts = dao.getAllPost();
        for (Posts p : posts) {
    %>
    <div class="col-md-6">
        <div class="card mt-2">
            <img src="blog_pic/<%=p.getPostPic()%>" class="card-img-top" alt="...">
            <div class="card-body">
                <h3><%= p.getPostTitle() %></h3>
                <p><%=p.getPostContent()%></p>
                <pre><%=p.getPostCode()%></pre>
                
                <!-- Add other content here as needed -->
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>
