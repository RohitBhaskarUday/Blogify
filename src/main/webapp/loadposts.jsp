<%@ page import="com.blog.dao.PostDAO" %>
<%@ page import="com.blog.handler.ConnectionProvider" %>
<%@ page import="com.blog.entities.Post" %>
<%@ page import="java.util.List" %>

<div class="row">



<%



    PostDAO d = new PostDAO(ConnectionProvider.getConnection());


    int cid = Integer.parseInt(request.getParameter("cid"));

    List<Post> posts = null;
    if(cid==0){
        posts = d.getAllPost();
    }else{
        posts = d.getPostByCatId(cid);
    }

    if(posts.isEmpty()){
        out.println("<div class='display-4 text-md-center' text-center>No Posts found in this selected category</div>");
        return;
    }

    for (Post post : posts) {
        String str = post.getpPicture();

        boolean hasImage = (str != null && !str.trim().isEmpty());
        %>
<%--creation of cards--%>
<div class="col-md-6">
    <div class="card">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0"><%= post.getpTitle() %></h5>
        </div>
        <div class="card-body">


        <% if (hasImage) { %>
        <img class="card-img-top mb-3"
             src="blog-images/<%= str %>"
             alt="Blog Image"
             style="max-height: 400px; object-fit: cover;">
        <% } %>

            <p>
                <%  String sample="";
                    if(post.getpContent() != null && post.getpContent().length() > 50){
                        sample = post.getpContent().substring(0,25);
                }
                %>
                <%=sample%>
            </p>



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