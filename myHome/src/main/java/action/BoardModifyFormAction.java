package action;

import static DB.JdbcUtil.*;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;
import beans.Board;

public class BoardModifyFormAction implements Action{

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		Board article = null;
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		article = dao.selectArticle(board_num);
		close(con);
		
		request.setAttribute("article", article);
		return false;
	}

}
