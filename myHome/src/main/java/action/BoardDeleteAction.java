package action;

import static DB.JdbcUtil.commit;
import static DB.JdbcUtil.getConnection;
import static DB.JdbcUtil.rollback;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;

public class BoardDeleteAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String page = request.getParameter("page");
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		int re = dao.deleteBoard(board_num, con);
		
		if (re == 1) {
			commit(con);
		} else {
			rollback(con);
		}

		request.setAttribute("page", page);
		
		return false;
	}

}
