package dao;

import java.sql.*;
import java.util.*;
import model.Blog;
import util.DBConnection;

public class BlogDAO {

    // ADD BLOG
    public boolean addBlog(Blog blog) {
        boolean status = false;

        try (Connection con = DBConnection.userCon()) {

            String sql = "INSERT INTO blogs (admin_id, title, content, image_url) VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, blog.getAdminId());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getContent());
            ps.setString(4, blog.getImageUrl());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // GET ALL BLOGS
    public List<Blog> getAllBlogs() {

        List<Blog> list = new ArrayList<>();

        try (Connection con = DBConnection.userCon()) {

            String sql = "SELECT * FROM blogs ORDER BY created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Blog b = new Blog();
                b.setBlogId(rs.getInt("blog_id"));
                b.setAdminId(rs.getInt("admin_id"));
                b.setTitle(rs.getString("title"));
                b.setContent(rs.getString("content"));
                b.setImageUrl(rs.getString("image_url"));
                b.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // DELETE BLOG
    public boolean deleteBlog(int id) {

        boolean status = false;

        try (Connection con = DBConnection.userCon()) {

            String sql = "DELETE FROM blogs WHERE blog_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // UPDATE BLOG
    public boolean updateBlog(Blog blog) {

        boolean status = false;

        try (Connection con = DBConnection.userCon()) {

            String sql = "UPDATE blogs SET title=?, content=?, image_url=? WHERE blog_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImageUrl());
            ps.setInt(4, blog.getBlogId());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public int getBlogCount() {
        int count = 0;

        try (Connection con = DBConnection.userCon()) {

            String sql = "SELECT COUNT(*) FROM blogs";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
 // GET BLOG BY ID
    public Blog getBlogById(int id) {

        Blog b = null;

        try (Connection con = DBConnection.userCon()) {

            String sql = "SELECT * FROM blogs WHERE blog_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                b = new Blog();
                b.setBlogId(rs.getInt("blog_id"));
                b.setAdminId(rs.getInt("admin_id"));
                b.setTitle(rs.getString("title"));
                b.setContent(rs.getString("content"));
                b.setImageUrl(rs.getString("image_url"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }
}
