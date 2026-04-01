package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import util.DBConnection;

public class ProductDAO {

    // ADD PRODUCT
    public boolean addProduct(Product product) {

        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO products (admin_id, name, description, category, actual_price, offer_price, stock_quantity, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, product.getAdminId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getCategory());
            ps.setDouble(5, product.getActualPrice());
            ps.setDouble(6, product.getOfferPrice());
            ps.setInt(7, product.getStockQuantity());
            ps.setString(8, product.getImageUrl());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // GET ALL PRODUCTS
    public List<Product> getAllProducts() {

        List<Product> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT * FROM products ORDER BY created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setAdminId(rs.getInt("admin_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setCategory(rs.getString("category"));
                p.setActualPrice(rs.getDouble("actual_price"));
                p.setOfferPrice(rs.getDouble("offer_price"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImageUrl(rs.getString("image_url"));
                p.setCreatedAt(rs.getTimestamp("created_at"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // GET PRODUCT COUNT
    public int getProductCount() {

        int count = 0;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT COUNT(*) FROM products";
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
    
    
 // DELETE PRODUCT
    public boolean deleteProduct(int productId) {

        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "DELETE FROM products WHERE product_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productId);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    
 // UPDATE PRODUCT
    public boolean updateProduct(Product product) {

        boolean status = false;

        try (Connection con = DBConnection.getConnection()) {

            String sql = "UPDATE products SET name=?, category=?, actual_price=?, offer_price=?, stock_quantity=?, image_url=?, description=? WHERE product_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setDouble(3, product.getActualPrice());
            ps.setDouble(4, product.getOfferPrice());
            ps.setInt(5, product.getStockQuantity());
            ps.setString(6, product.getImageUrl());
            ps.setString(7, product.getDescription());
            ps.setInt(8, product.getProductId());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    
}