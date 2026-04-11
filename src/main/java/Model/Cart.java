package model;

public class Cart {

    private int cartId;
    private int userId;
    private String sessionId;

    public Cart() {}

    public Cart(int cartId, int userId, String sessionId) {
        this.cartId = cartId;
        this.userId = userId;
        this.sessionId = sessionId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }
}