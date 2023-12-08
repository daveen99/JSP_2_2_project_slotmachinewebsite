package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.*;

/**
 * Servlet implementation class BoardFrontController
 */
@WebServlet("*.bo")
public class BoardFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardFrontController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}
	
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		boolean redirect = false;
		String path = null;
		Action action = null;
		
		request.setCharacterEncoding("utf-8");
		String requestURI = request.getRequestURI();
		int i = requestURI.lastIndexOf("/");
		String command = requestURI.substring(i);
		
		if (command.equals("/boardWriteForm.bo")) {
			path = "/board/qna_board_write.jsp";
		}
		else if (command.equals("/boardWritePro.bo")) {
			action = new BoardWriteProAction();
			try {
				redirect = action.execute(request, response);
				path = "boardList.bo";
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if (command.equals("/boardList.bo")) {
			System.out.println("게시판 확인용");
			action = new BoardListAction();
			try {
				redirect = action.execute(request, response);
				path = "/board/qna_board_list.jsp";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		else if (command.equals("/boardDetail.bo")) {
			System.out.println("게시판 상세보기용");
			action = new BoardDetailAction();
			try {
				redirect = action.execute(request, response);
				path = "/board/qna_board_view.jsp";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		else if (command.equals("/boardModifyForm.bo")) {
			System.out.println("게시판 수정화면용");
			action = new BoardModifyFormAction();
			try {
				redirect = action.execute(request, response);
				path = "/board/qna_board_modify.jsp";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if (command.equals("/boardModifyPro.bo")) {
			System.out.println("게시판 수정적용 확인용");
			action = new BoardModifyProAction();
			try {
				redirect = action.execute(request, response);
				path = "boardList.bo";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if (command.equals("/boardDeleteForm.bo")) {
			System.out.println("게시물 삭제 확인용");
			action = new BoardDeleteAction();
			try {
				redirect = action.execute(request, response);
				path = "boardList.bo";
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		
		
		
		
		// 공지사항 게시판
		else if (command.equals("/noticeList.bo")) {
			System.out.println("공지사항 게시판 확인용");
			action = new NoticeListAction();
			try {
				redirect = action.execute(request, response);
				path = "/board/notice_list.jsp";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		else if (command.equals("/noticeWriteForm.bo")) {
			System.out.println("공지사항 작성용");
			path = "/board/notice_write.jsp";
		}
		else if (command.equals("/noticeWritePro.bo")) {
			action = new NoticeWriteProAction();
			try {
				redirect = action.execute(request, response);
				path = "noticeList.bo";
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if (command.equals("/noticeDetail.bo")) {
			System.out.println("공지사항 상세보기용");
			action = new NoticeDetailAction();
			try {
				redirect = action.execute(request, response);
				path = "/board/notice_view.jsp";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		
		else if (command.equals("/noticeModifyForm.bo")) {
			System.out.println("게시판 수정화면용");
			action = new NoticeModifyFormAction();
			try {
				redirect = action.execute(request, response);
				path = "/board/notice_modify.jsp";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if (command.equals("/noticeModifyPro.bo")) {
			System.out.println("게시판 수정적용 확인용");
			action = new NoticeModifyProAction();
			try {
				redirect = action.execute(request, response);
				path = "noticeList.bo";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if (command.equals("/noticeDeleteForm.bo")) {
			System.out.println("공지사항 삭제 확인용");
			action = new NoticeDeleteAction();
			try {
				redirect = action.execute(request, response);
				path = "noticeList.bo";
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		////// 해당 페이지 이동~
		if(redirect==true) {
			response.sendRedirect(path);
		}
		else {
			RequestDispatcher disp = request.getRequestDispatcher(path);
			disp.forward(request, response);
		}
	}
	

}
