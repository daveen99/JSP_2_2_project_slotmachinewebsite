package action;

import static DB.JdbcUtil.*;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;
import beans.Board;

public class BoardDetailAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String page = request.getParameter("page");
		Board article = null;
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		int up = dao.updateReadCount(board_num);
		if (up == 1) {
			commit(con);
		} else {
			rollback(con);
		}
		
		article = dao.selectArticle(board_num);
		close(con);
		
		request.setAttribute("page", page);
		request.setAttribute("article", article);
		
		return false;
	}

}
