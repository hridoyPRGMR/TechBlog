<%@ page import="java.util.List" %>
<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.entities.Posts" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>

<div class="row">
    <%
        Thread.sleep(1000);//that should be remove before host...its used for loading
        PostDao dao = new PostDao(ConnectionProvider.getConnection());
        int cid=Integer.parseInt(request.getParameter("cid"));
        List<Posts>posts=null;
        if(cid==0){
            posts = dao.getAllPost();
        }
        else{
            posts=dao.getPostByCatId(cid);
        }
        
        if(posts.size()==0){
            out.println("<h4 class=display-3 text-center>NO posts available in this category</h4>");
            return;
        }
        
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
