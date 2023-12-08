package action;

import static DB.JdbcUtil.commit;
import static DB.JdbcUtil.getConnection;
import static DB.JdbcUtil.rollback;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;

public class NoticeDeleteAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		String page = request.getParameter("page");
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		int re = dao.deleteNotice(notice_num, con);
		
		if (re == 1) {
			commit(con);
		} else {
			rollback(con);
		}

		request.setAttribute("page", page);
		
		return false;
	}

}
