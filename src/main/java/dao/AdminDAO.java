package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Admins;
import util.DBConnection;

public class AdminDAO {

    public Admins login(String email, String password) {

        Admins admin = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM admins WHERE email=? AND password_hash=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                admin = new Admins();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPasswordHash(rs.getString("password_hash"));
                admin.setCreatedAt(rs.getTimestamp("created_at"));
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admin;
    }
}