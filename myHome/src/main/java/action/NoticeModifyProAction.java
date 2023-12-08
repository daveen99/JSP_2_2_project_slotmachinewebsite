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
import beans.Notice;

public class NoticeModifyProAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		int notice_num = Integer.parseInt(request.getParameter("NOTICE_NUM"));
		String name = request.getParameter("NOTICE_NAME");
		Notice article = new Notice();
		
		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setCon(con);
		boolean isWriter = dao.isArticleNoticeWriter(notice_num, name);
		
		if (!isWriter) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자 아이디가 일치하지 않아, 수정이 거부되었습니다.')");
			out.println("history.back();");
			out.println("</script>");
		} else {
			article.setNOTICE_NUM(notice_num);
			article.setNOTICE_SUBJECT(request.getParameter("NOTICE_SUBJECT"));
			article.setNOTICE_CONTENT(request.getParameter("NOTICE_CONTENT"));
			int upCount = dao.updateNotice(article);
			
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
			}
			close(con);
			

		}
		return true;
	}
	
}
