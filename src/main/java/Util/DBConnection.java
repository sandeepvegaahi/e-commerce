package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {


    private static final String URL = "jdbc:mysql://localhost:3306/mall";
    private static final String USER = "root";
    private static final String PASSWORD = "Pp@2203a52231";

    public static Connection userCon() throws Exception {

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

