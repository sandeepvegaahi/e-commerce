package model;

import java.sql.Timestamp;

public class Product {

    private int productId;
    private int adminId;
    private String name;
    private String description;
    private String category;
    private double actualPrice;
    private double offerPrice;
    private int stockQuantity;
    private String imageUrl;
    private Timestamp createdAt;

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getActualPrice() { return actualPrice; }
    public void setActualPrice(double actualPrice) { this.actualPrice = actualPrice; }

    public double getOfferPrice() { return offerPrice; }
    public void setOfferPrice(double offerPrice) { this.offerPrice = offerPrice; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}