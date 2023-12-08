package action;

import static DB.JdbcUtil.*;

import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DB.BoardDAO;
import beans.Board;

public class BoardModifyProAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		int board_num = Integer.parseInt(request.getParameter("BOARD_NUM"));
		String pass = request.getParameter("BOARD_PASS");
		Board article = new Board();
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		boolean isWriter = dao.isArticleBoardWriter(board_num, pass);
		
		if (!isWriter) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('암호가 일치하지 않아, 수정이 거부되었습니다.')");
			out.println("history.back();");
			out.println("</script>");
		} else {
			article.setBOARD_NUM(board_num);
			article.setBOARD_SUBJECT(request.getParameter("BOARD_SUBJECT"));
			article.setBOARD_CONTENT(request.getParameter("BOARD_CONTENT"));
			int upCount = dao.updateArticle(article);
			
			if (upCount != 1) {
				rollback(con);
				close(con);
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('글 수정에 실패했습니다.')");
				out.println("history.back();");
				out.println("</script>");
				
			} else {
				commit(con);
				//request.setAttribute("board_num", board_num);
			}
			close(con);
			

		}
		return true;
	}
	
}
