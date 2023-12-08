package DB;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class JdbcUtil {
	public static Connection getConnection() {
		Connection con = null;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MySQLDB");
			con = ds.getConnection();
			con.setAutoCommit(false);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	public static void commit(Connection con) {
		try {
			con.commit();
			System.out.println("commit complete");
		} catch(Exception e) {
			e.printStackTrace();	
		}
	}
	
	public static void rollback(Connection con) {
		try {
			con.rollback();
			System.out.println("rollback complete");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// close 메서드 오버로딩
	public static void close(Connection con) {
		try {
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(PreparedStatement ps) {
		try {
			ps.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	// close 메서드 끝
}
