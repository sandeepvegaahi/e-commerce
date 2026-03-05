package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Model.User;
import util.DBConnection;

public class UserDAO {
    public boolean registerUser(User user) {

        String sql = "INSERT INTO users(full_name,email,phone,password_hash,city,state,pincode) VALUES (?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPasswordHash());
            ps.setString(5, user.getCity());
            ps.setString(6, user.getState());
            ps.setString(7, user.getPincode());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    public User loginUser(String email, String passwordHash) {

        String sql = "SELECT * FROM users WHERE email=? AND password_hash=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) 
        {

            ps.setString(1, email);
            ps.setString(2, passwordHash);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setCity(rs.getString("city"));
                user.setState(rs.getString("state"));
                user.setPincode(rs.getString("pincode"));

                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public boolean updateUser(User user){

    	String sql="UPDATE users SET full_name=?,email=?,phone=?,city=?,state=?,pincode=? WHERE user_id=?";

    	try(Connection conn=DBConnection.getConnection();
    	PreparedStatement ps=conn.prepareStatement(sql)){

    	ps.setString(1,user.getFullName());
    	ps.setString(2,user.getEmail());
    	ps.setString(3,user.getPhone());
    	ps.setString(4,user.getCity());
    	ps.setString(5,user.getState());
    	ps.setString(6,user.getPincode());
    	ps.setInt(7,user.getUserId());

    	return ps.executeUpdate()>0;

    	}catch(Exception e){
    	e.printStackTrace();
    	}

    	return false;
    	}
    public boolean deleteUser(int userId) {

        String sql = "DELETE FROM users WHERE user_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}