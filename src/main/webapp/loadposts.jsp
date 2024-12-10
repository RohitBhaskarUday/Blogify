<%@ page import="com.blog.dao.PostDAO" %>
<%@ page import="com.blog.handler.ConnectionProvider" %>
<%@ page import="com.blog.entities.Post" %>
<%@ page import="java.util.List" %>

<div class="row">



<%
    Thread.sleep(500);
    PostDAO d = new PostDAO(ConnectionProvider.getConnection());

    int cid = Integer.parseInt(request.getParameter("cid"));

    List<Post> posts = null;
    if(cid==0){
        posts = d.getAllPost();
    }else{
        posts = d.getPostByCatId(cid);
    }

    if(posts.size()==0){
        out.println("<h4 class='display-4' text-center>No Posts found in this selected category</h4>");
        return;
    }

    for (Post post : posts) {
        %>
<%--creation of cards--%>
<div class="col-md-6">
    <div class="card">
        <img src="blog-images/<%=post.getpPicture()%>" class="card-img-top" alt="...">
        <div class="card-body">
            <b><%=post.getpTitle()%></b>
<%--            <p><%=post.getpContent()%></p>--%>
        </div>
        <div  class="card-footer primary-background text-center">
            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"> <span>10 </span></i> </a>
            <a href="showblogpage.jsp?post_id=<%=post.getpId()%>" class="btn btn-outline-light btn-sm">Read More</a>
            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> <span>20 </span></i> </a>
        </div>
    </div>
</div>

<%
    }
%>

</div>