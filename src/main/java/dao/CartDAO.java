package dao;

import java.sql.*;
import java.util.*;
import model.CartItem;
import util.DBConnection;

public class CartDAO {

    // GET OR CREATE CART
    public int getOrCreateCart(int userId) {

        int cartId = 0;

        try (Connection con = DBConnection.userCon()) {

            String check = "SELECT cart_id FROM carts WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(check);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cartId = rs.getInt("cart_id");
            } else {
                String create = "INSERT INTO carts(user_id) VALUES(?)";
                ps = con.prepareStatement(create, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, userId);
                ps.executeUpdate();

                ResultSet key = ps.getGeneratedKeys();
                if (key.next()) cartId = key.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartId;
    }

    // ADD TO CART
    public void addToCart(int userId, int productId) {

        try (Connection con = DBConnection.userCon()) {

            int cartId = getOrCreateCart(userId);

            String check = "SELECT quantity FROM cart_items WHERE cart_id=? AND product_id=?";
            PreparedStatement ps = con.prepareStatement(check);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int qty = rs.getInt("quantity") + 1;

                String update = "UPDATE cart_items SET quantity=? WHERE cart_id=? AND product_id=?";
                ps = con.prepareStatement(update);
                ps.setInt(1, qty);
                ps.setInt(2, cartId);
                ps.setInt(3, productId);
                ps.executeUpdate();

            } else {

                String insert = "INSERT INTO cart_items(cart_id, product_id, quantity) VALUES(?,?,1)";
                ps = con.prepareStatement(insert);
                ps.setInt(1, cartId);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET CART ITEMS (FIXED)
    public List<CartItem> getCartItems(int userId) {

        List<CartItem> list = new ArrayList<>();

        try (Connection con = DBConnection.userCon()) {

        	String query = "SELECT c.cart_item_id, c.quantity, " +
                    "p.product_id, p.name, p.description, " +
                    "p.offer_price, p.image_url, p.stock_quantity " +   // ✅ ADD THIS
                    "FROM cart_items c " +
                    "JOIN carts ca ON c.cart_id = ca.cart_id " +
                    "JOIN products p ON c.product_id = p.product_id " +
                    "WHERE ca.user_id=?";
        	 

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItem item = new CartItem();

                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setName(rs.getString("name"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("offer_price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setImage(rs.getString("image_url"));
                item.setStockQuantity(rs.getInt("stock_quantity"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public void updateQuantity(int userId, int productId, String action) {

        try (Connection con = DBConnection.userCon()) {

            String sql = "";

            if (action.equals("inc")) {
                sql = "UPDATE cart_items SET quantity = quantity + 1 WHERE product_id=? AND cart_id=(SELECT cart_id FROM carts WHERE user_id=?)";
            } else {
                sql = "UPDATE cart_items SET quantity = quantity - 1 WHERE product_id=? AND cart_id=(SELECT cart_id FROM carts WHERE user_id=?) AND quantity > 1";
            }

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public int getProductQuantity(int userId, int productId){

        int qty = 1;

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT quantity FROM cart_items WHERE product_id=? AND cart_id=(SELECT cart_id FROM carts WHERE user_id=?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                qty = rs.getInt("quantity");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return qty;
    }
    public double getCartTotal(int userId){

        double total = 0;

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT SUM(c.quantity * p.offer_price) AS total " +
                         "FROM cart_items c " +
                         "JOIN carts ca ON c.cart_id = ca.cart_id " +
                         "JOIN products p ON c.product_id = p.product_id " +
                         "WHERE ca.user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                total = rs.getDouble("total");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return total;
    }
    public double getProductPrice(int productId){

        double price = 0;

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT offer_price FROM products WHERE product_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                price = rs.getDouble("offer_price");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return price;
    }
    public Map<String, Object> updateCartItem(int userId, int productId, String action) {

        Map<String, Object> result = new HashMap<>();

        try (Connection con = DBConnection.userCon()) {

            String fetch = "SELECT c.quantity, p.stock_quantity, p.offer_price " +
                    "FROM cart_items c " +
                    "JOIN carts ca ON c.cart_id=ca.cart_id " +
                    "JOIN products p ON c.product_id=p.product_id " +
                    "WHERE ca.user_id=? AND c.product_id=?";

            PreparedStatement ps = con.prepareStatement(fetch);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            int qty = 1, stock = 0;
            double price = 0;

            if (rs.next()) {
                qty = rs.getInt("quantity");
                stock = rs.getInt("stock_quantity");
                price = rs.getDouble("offer_price");
            }

            // logic
            if ("inc".equals(action) && qty < stock) {
                qty++;
            } else if ("dec".equals(action) && qty > 1) {
                qty--;
            }

            // update
            String update = "UPDATE cart_items c JOIN carts ca ON c.cart_id=ca.cart_id " +
                    "SET c.quantity=? WHERE ca.user_id=? AND c.product_id=?";
            ps = con.prepareStatement(update);
            ps.setInt(1, qty);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            ps.executeUpdate();

            double sub = qty * price;

            // total
            String totalQuery = "SELECT SUM(c.quantity * p.offer_price) AS total " +
                    "FROM cart_items c " +
                    "JOIN carts ca ON c.cart_id=ca.cart_id " +
                    "JOIN products p ON c.product_id=p.product_id " +
                    "WHERE ca.user_id=?";

            ps = con.prepareStatement(totalQuery);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            double total = 0;
            if (rs.next()) total = rs.getDouble("total");

            result.put("qty", qty);
            result.put("sub", sub);
            result.put("total", total);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    public void removeFromCart(int userId, int productId){

        try(Connection con = DBConnection.userCon()){

            String sql = "DELETE c FROM cart_items c " +
                         "JOIN carts ca ON c.cart_id = ca.cart_id " +
                         "WHERE ca.user_id=? AND c.product_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public int getQuantity(int userId, int productId){

        int qty = 0;

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT quantity FROM cart_items ci " +
                         "JOIN carts c ON ci.cart_id = c.cart_id " +
                         "WHERE c.user_id=? AND ci.product_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                qty = rs.getInt("quantity");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return qty;
    }
    public void removeItem(int userId, int productId){

        try(Connection con = DBConnection.userCon()){

            String sql = "DELETE ci FROM cart_items ci " +
                         "JOIN carts c ON ci.cart_id = c.cart_id " +
                         "WHERE c.user_id=? AND ci.product_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public void removeItemByCartId(int cartId, int productId){

        try(Connection con = DBConnection.userCon()){

            String sql = "DELETE FROM cart_items WHERE cart_id=? AND product_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}