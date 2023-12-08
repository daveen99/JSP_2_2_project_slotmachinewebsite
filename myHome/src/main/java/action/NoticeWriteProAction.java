package action;

import static DB.JdbcUtil.close;
import static DB.JdbcUtil.commit;
import static DB.JdbcUtil.getConnection;
import static DB.JdbcUtil.rollback;

import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DB.BoardDAO;
import beans.Notice;

public class NoticeWriteProAction implements Action {

	@Override
	public boolean execute(HttpServletRequest request, HttpServletResponse response) throws Exception  {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String realFolder = "";
		String saveFolder = "./boardUpload";
		ServletContext context = request.getServletContext();
		realFolder = context.getRealPath(saveFolder);
		int fileSize = 1024*1024*10;
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, fileSize, 
				"UTF-8", new DefaultFileRenamePolicy());
		Notice bdBeans = new Notice();
		bdBeans.setNOTICE_SUBJECT(multi.getParameter("NOTICE_SUBJECT"));
		bdBeans.setNOTICE_CONTENT(multi.getParameter("NOTICE_CONTENT"));
		bdBeans.setNOTICE_NAME(multi.getParameter("NOTICE_NAME"));
		//System.out.println(multi.getParameter("NOTICE_NAME"));
		System.out.println(multi.getParameter("NOTICE_SUBJECT"));

		Connection con = getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		int re = dao.insertNotice(bdBeans, con);
		if (re!=1) {
			rollback(con);
			close(con);
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록실패')");
			out.println("history.back();");
			out.println("</script>");
			
		} else {
			commit(con);
			
		}
		close(con);
		return true;
	}
}
