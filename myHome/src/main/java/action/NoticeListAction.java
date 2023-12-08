package action;

import static DB.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.BoardDAO;
import beans.Notice;
import beans.PageInfo;

public class NoticeListAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<Notice> articleList = new ArrayList<Notice>();
		int npage = 1;
		int limit = 10;
		
		if (request.getParameter("npage") != null) {
			npage = Integer.parseInt(request.getParameter("npage"));
		}
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		int listCount = dao.selectNoticeCount();
		
		articleList = dao.selectNoticeList(npage, limit);
		
		int maxPage = (int) Math.ceil((double)listCount / limit);
		int startPage = (((int)((double)npage/limit + 0.9))-1) * 10+1;
		int endPage = startPage + 9;
		
		if (endPage > maxPage) endPage = maxPage;
		
		PageInfo npInfo = new PageInfo();
		npInfo.setListCount(listCount);
		npInfo.setPage(npage);
		npInfo.setMaxPage(maxPage);
		npInfo.setStartPage(startPage);
		npInfo.setEndPage(endPage);
		
		request.setAttribute("pageInfo", npInfo);
		request.setAttribute("articleList", articleList);
		
		return false;
	}

}
