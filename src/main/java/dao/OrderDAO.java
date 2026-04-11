package dao;

import java.sql.*;
import java.util.*;
import model.*;
import util.DBConnection;

public class OrderDAO {

    // ✅ CREATE ORDER
    public int createOrder(int userId, double total) {
        int orderId = 0;

        try (Connection con = DBConnection.userCon()) {

            String sql = "INSERT INTO orders(user_id, total_amount) VALUES(?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, userId);
            ps.setDouble(2, total);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderId;
    }

    // ✅ ADD ORDER ITEMS
    public void addOrderItems(int orderId, List<OrderItem> items) {

        try (Connection con = DBConnection.userCon()) {

            String sql = "INSERT INTO order_items(order_id, product_id, quantity, price_at_purchase) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getPriceAtPurchase());
                ps.addBatch();
            }

            ps.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Map<String, Object>> getUserOrders(int userId) {

        List<Map<String, Object>> orders = new ArrayList<>();

        try (Connection con = DBConnection.userCon()) {

            String sql = "SELECT o.order_id, o.total_amount, o.order_status, o.created_at, " +
                         "oi.product_id, oi.quantity, oi.price_at_purchase, p.name, p.image_url " +
                         "FROM orders o " +
                         "JOIN order_items oi ON o.order_id = oi.order_id " +
                         "JOIN products p ON oi.product_id = p.product_id " +
                         "WHERE o.user_id=? ORDER BY o.order_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Map<String, Object> row = new HashMap<>();

                row.put("orderId", rs.getInt("order_id"));
                row.put("total", rs.getDouble("total_amount"));
                row.put("status", rs.getString("order_status"));
                row.put("date", rs.getTimestamp("created_at"));

                row.put("productId", rs.getInt("product_id"));
                row.put("name", rs.getString("name"));
                row.put("image", rs.getString("image_url"));
                row.put("qty", rs.getInt("quantity"));
                row.put("price", rs.getDouble("price_at_purchase"));

                orders.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    public void cancelOrder(int orderId){

        try(Connection con = DBConnection.userCon()){

            String sql = "UPDATE orders SET order_status='Cancelled' WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, orderId);
            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public List<OrderItem> getOrderItems(int orderId){

        List<OrderItem> list = new ArrayList<>();

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT * FROM order_items WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                OrderItem item = new OrderItem();
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    public String getOrderStatus(int orderId){

        String status = "";

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT order_status FROM orders WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                status = rs.getString("order_status");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }
}