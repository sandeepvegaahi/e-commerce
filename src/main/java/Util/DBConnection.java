package Util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	private static final String url = "jdbc:mysql://localhost:3306/mall";
	private static final String userName = "root";
    private static final String Password = "Pp@2203a52231";
	public static Connection userCon()
	{
		Connection con=null;
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection(url,userName,Password);
		}
		catch(Exception e)
		{
			e.getMessage();
		}
		return con;
	}
}
