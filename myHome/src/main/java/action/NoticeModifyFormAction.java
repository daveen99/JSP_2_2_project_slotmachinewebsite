package action;

import static DB.JdbcUtil.*;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;
import beans.Notice;

public class NoticeModifyFormAction implements Action{

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		Notice article = null;
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		article = dao.selectNotice(notice_num);
		close(con);
		
		request.setAttribute("article", article);
		return false;
	}

}
