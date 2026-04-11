package dao;

import java.sql.*;
import java.util.*;
import model.Product;
import util.DBConnection;

public class FavoriteDAO {

    public boolean isFavorite(int userId, int productId){
        boolean exists = false;

        try(Connection con = DBConnection.userCon()){
            String sql = "SELECT * FROM favourites WHERE user_id=? AND product_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();
            exists = rs.next();

        }catch(Exception e){
            e.printStackTrace();
        }

        return exists;
    }

    public String toggleFavorite(int userId, int productId){

        try(Connection con = DBConnection.userCon()){

            if(isFavorite(userId, productId)){
                String delete = "DELETE FROM favourites WHERE user_id=? AND product_id=?";
                PreparedStatement ps = con.prepareStatement(delete);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.executeUpdate();
                return "removed";

            } else {
                String insert = "INSERT INTO favourites(user_id, product_id) VALUES(?,?)";
                PreparedStatement ps = con.prepareStatement(insert);
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.executeUpdate();
                return "added";
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return "error";
    }

    public List<Product> getFavorites(int userId){

        List<Product> list = new ArrayList<>();

        try(Connection con = DBConnection.userCon()){

            String sql = "SELECT p.* FROM favourites f " +
                    "JOIN products p ON f.product_id = p.product_id " +
                    "WHERE f.user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setOfferPrice(rs.getDouble("offer_price"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}