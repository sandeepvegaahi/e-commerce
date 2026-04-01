package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import model.User;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

protected void doPost(HttpServletRequest request,HttpServletResponse response)
throws ServletException, IOException {

int userId=Integer.parseInt(request.getParameter("userId"));
String name=request.getParameter("fullName");
String email=request.getParameter("email");
String phone=request.getParameter("phone");
String city=request.getParameter("city");
String state=request.getParameter("state");
String pincode= request.getParameter("pincode");

User user=new User();

user.setUserId(userId);
user.setFullName(name);
user.setEmail(email);
user.setPhone(phone);
user.setCity(city);
user.setState(state);
user.setPincode(pincode);

UserDAO dao=new UserDAO();

if(dao.updateUser(user)){

HttpSession session=request.getSession();
session.setAttribute("user", user);

response.sendRedirect("user/profile.jsp");

}else{
response.getWriter().println("Update Failed");
}

}
}