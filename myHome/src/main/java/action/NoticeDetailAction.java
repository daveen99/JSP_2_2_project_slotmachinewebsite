package action;

import static DB.JdbcUtil.close;
import static DB.JdbcUtil.commit;
import static DB.JdbcUtil.getConnection;
import static DB.JdbcUtil.rollback;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;
import beans.Notice;

public class NoticeDetailAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		String page = request.getParameter("page");
		Notice article = null;
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		int up = dao.updateNoticeCount(notice_num);
		if (up == 1) {
			commit(con);
		} else {
			rollback(con);
		}
		
		article = dao.selectNotice(notice_num);
		close(con);
		
		request.setAttribute("page", page);
		request.setAttribute("article", article);
		
		return false;
	}

}
