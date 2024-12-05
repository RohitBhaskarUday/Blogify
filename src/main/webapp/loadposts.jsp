<%@ page import="com.blog.dao.PostDAO" %>
<%@ page import="com.blog.handler.ConnectionProvider" %>
<%@ page import="com.blog.entities.Post" %>
<%@ page import="java.util.List" %>

<div class="row">



<%
    PostDAO d = new PostDAO(ConnectionProvider.getConnection());
    List<Post> posts = d.getAllPost();
    for (Post post : posts) {
        %>
<%--creation of cards--%>
<div class="col-md-6">
    <div class="card">
        <img src="blog-images/<%=post.getpPicture()%>" class="card-img-top" alt="...">
        <div class="card-body">
            <b><%=post.getpTitle()%></b>
            <p><%=post.getpContent()%></p>
            <pre><%=post.getpCode()%></pre>
        </div>
    </div>
</div>

<%
    }
%>

</div>