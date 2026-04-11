package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Blog;
import dao.BlogDAO;

@WebServlet("/UpdateBlogServlet")
public class UpdateBlog extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Blog blog = new Blog();

        blog.setBlogId(Integer.parseInt(request.getParameter("id")));
        blog.setTitle(request.getParameter("title"));
        blog.setContent(request.getParameter("content"));
        blog.setImageUrl(request.getParameter("image"));

        BlogDAO dao = new BlogDAO();
        dao.updateBlog(blog);

       // response.sendRedirect("manage-blog.jsp");
        response.sendRedirect("getblogs.jsp");
    }
}