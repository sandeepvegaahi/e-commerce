<%@ page import="dao.BlogDAO,model.Blog" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 

<%
int id = Integer.parseInt(request.getParameter("id"));
BlogDAO dao = new BlogDAO();
Blog b = dao.getBlogById(id);
%>

<div class="blog-view">

    <img src="<%=request.getContextPath()%>/blogsimg/<%=b.getImageUrl()%>" class="blog-img">

    <h2><%=b.getTitle()%></h2>

    <p class="content"><%=b.getContent()%></p>

    <small>Posted on: <%=b.getCreatedAt()%></small>

</div>