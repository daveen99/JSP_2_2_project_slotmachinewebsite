package DB;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import beans.Board;
import beans.Notice;
import static DB.JdbcUtil.*;

public class BoardDAO {
	DataSource ds;
	Connection con;
	private static BoardDAO boardDAO;
	
	private BoardDAO() {}
	public static BoardDAO getInstance() {  // 싱글톤(singleton) 객체  : 단일객체로 만들어 중복생성하지 않고 하나를 모두가 공유해서 사용함
		if(boardDAO == null)
			boardDAO = new BoardDAO();
		return boardDAO;
	}
	
	public void setCon(Connection con) {
		this.con = con;
	}
	
	public int updateArticle(Board board) {
		int upCount = 0;
		PreparedStatement ps = null;
		String sql = "update board set BOARD_SUBJECT = ?, BOARD_CONTENT = ? where BOARD_NUM = ?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, board.getBOARD_SUBJECT());
			ps.setString(2, board.getBOARD_CONTENT());
			ps.setInt(3, board.getBOARD_NUM());
			upCount = ps.executeUpdate();
		} catch (Exception e) {
			System.out.println("글 수정(업데이트)중 오류");
			e.printStackTrace();
		} finally {
			close(ps);
		}
		
		return upCount;
	}
	
	public boolean isArticleBoardWriter(int num, String pass) {
		boolean isWriter = false;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "select BOARD_PASS from board where BOARD_NUM = ?";
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			rs.next();
			if (pass.equals(rs.getString(1))) {
				isWriter = true;
			}
			
		} catch (Exception e) {
			System.out.println("패스워드 확인 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}
		
		return isWriter;
	}
	
	public Board selectArticle(int num) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		Board boardBean = null;
		
		try {
			String sql = "select * from board where BOARD_NUM = ?";
			ps =  con.prepareStatement(sql);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			if (rs.next()) {
				boardBean = new Board();
				boardBean.setBOARD_NUM(rs.getInt("BOARD_NUM"));
				boardBean.setBOARD_NAME(rs.getString("BOARD_NAME"));
				boardBean.setBOARD_PASS(rs.getString("BOARD_PASS"));
				boardBean.setBOARD_SUBJECT(rs.getString("BOARD_SUBJECT"));
				boardBean.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));
				boardBean.setBOARD_FILE(rs.getString("BOARD_FILE"));
				boardBean.setBOARD_RE_REF(rs.getInt("BOARD_RE_REF"));
				boardBean.setBOARD_RE_LEV(rs.getInt("BOARD_RE_LEV"));
				boardBean.setBOARD_RE_SEQ(rs.getInt("BOARD_RE_SEQ"));
				boardBean.setBOARD_READCOUNT(rs.getInt("BOARD_READCOUNT"));
				boardBean.setBOARD_DATE(rs.getDate("BOARD_DATE"));
			}
			
		} catch (Exception e) {
			System.out.println("상세글 가져오기 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
		}
		return boardBean;
	}

	public int updateReadCount(int num) {
		PreparedStatement ps = null;
		int upCount = 0;
		
		String sql = "Update board set BOARD_READCOUNT = BOARD_READCOUNT + 1 WHERE BOARD_NUM = ?";
				try {
					ps = con.prepareStatement(sql);
					ps.setInt(1, num);
					upCount = ps.executeUpdate();
				} catch (Exception e) {
					System.out.println("조회수 업데이트 오류");
					e.printStackTrace();
				} finally {
					close(ps);
				}
		
		return upCount;
	}
	
	
	// 전체 게시글 수 가져오기
	public int selectListCount() {
		int listCount = 0;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = con.prepareStatement("select count(*) from board");
			rs = ps.executeQuery();
			if (rs.next()) {
				listCount = rs.getInt(1);
			}
			
		}catch (Exception ex) {
			System.out.println("getListCount 에러: " + ex);		
		}finally {
			close(rs);
			close(ps);
		}
		return listCount;
	}
	
	
	// 전체 게시글 조회 메서드
	public ArrayList<Board> selectArticleList(int page, int limit) {
		ArrayList<Board> aList = new ArrayList<Board>();
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select * from board order by BOARD_RE_REF desc, BOARD_RE_LEV asc, BOARD_RE_SEQ asc limit ?, ?";
		Board boardBean = null;
		int startRow = (page-1) * 10;
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, startRow);
			ps.setInt(2, limit);
			rs = ps.executeQuery();
			while (rs.next()) {
				boardBean = new Board();
				boardBean.setBOARD_NUM(rs.getInt("BOARD_NUM"));
				boardBean.setBOARD_NAME(rs.getString("BOARD_NAME"));
				boardBean.setBOARD_PASS(rs.getString("BOARD_PASS"));
				boardBean.setBOARD_SUBJECT(rs.getString("BOARD_SUBJECT"));
				boardBean.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));
				boardBean.setBOARD_FILE(rs.getString("BOARD_FILE"));
				boardBean.setBOARD_RE_REF(rs.getInt("BOARD_RE_REF"));
				boardBean.setBOARD_RE_LEV(rs.getInt("BOARD_RE_LEV"));
				boardBean.setBOARD_RE_SEQ(rs.getInt("BOARD_RE_SEQ"));
				boardBean.setBOARD_READCOUNT(rs.getInt("BOARD_READCOUNT"));
				boardBean.setBOARD_DATE(rs.getDate("BOARD_DATE"));
				
				aList.add(boardBean);
			}
		} catch (Exception e) {
			System.out.println("게시글 가져오기 실패!!!");
			e.printStackTrace();
		} finally {
			close(rs);
			close(ps);
			// 나중에 만든거 먼저 닫는다
		}
		return aList;
	}

	
	
	// 게시글 등록 메서드
	public int insertArticle(Board b, Connection con) {
		int re = 0;
		PreparedStatement ps = null;
		String sql = "";
		sql = "select max(BOARD_NUM) from board";
		ResultSet rs = null;
		int num = 0;
		
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next())
				num = rs.getInt(1) + 1;
			else 
				num = 1;
			
			sql = "insert into board(BOARD_NUM, BOARD_NAME, BOARD_PASS, BOARD_SUBJECT, BOARD_CONTENT, "
					+ "BOARD_FILE, BOARD_RE_REF, BOARD_RE_LEV, BOARD_RE_SEQ, BOARD_DATE) "
					+ "values (?,?,?,?,?,?,?,?,?,now())";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, num);
			ps.setString(2, b.getBOARD_NAME());
			ps.setString(3, b.getBOARD_PASS());	
			ps.setString(4, b.getBOARD_SUBJECT());
			ps.setString(5, b.getBOARD_CONTENT());	
			ps.setString(6, b.getBOARD_FILE());	
			ps.setInt(7, num);
			ps.setInt(8, 0);
			ps.setInt(9, 0);	
			
			re = ps.executeUpdate();
			// 성공하면 1 실패하면 0
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			close(rs);
			close(ps);
		}
		
		return re;
	}
	// 게시물 삭제
	public int deleteBoard(int num, Connection con) {
		PreparedStatement ps = null;
		int result = 0;
		try {
			String sql = "delete from board where BOARD_NUM = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			result = ps.executeUpdate();
			
		}catch (Exception ex) {
			ex.printStackTrace();	
		}finally {
			close(ps);
		}
		return result;
	}
	
	
	
	
	
	
	// 공지사항 전용 메서드들
	
	// 전체 게시글 조회 메서드
		public ArrayList<Notice> selectNoticeList(int page, int limit) {
			ArrayList<Notice> aList = new ArrayList<Notice>();
			
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql = "select * from notice order by NOTICE_RE_REF desc, NOTICE_RE_LEV asc, NOTICE_RE_SEQ asc limit ?, ?";
			Notice noticeBean = null;
			int startRow = (page-1) * 10;
			
			try {
				ps = con.prepareStatement(sql);
				ps.setInt(1, startRow);
				ps.setInt(2, limit);
				rs = ps.executeQuery();
				while (rs.next()) {
					noticeBean = new Notice();
					noticeBean.setNOTICE_NUM(rs.getInt("NOTICE_NUM"));
					noticeBean.setNOTICE_SUBJECT(rs.getString("NOTICE_SUBJECT"));
					noticeBean.setNOTICE_CONTENT(rs.getString("NOTICE_CONTENT"));
					noticeBean.setNOTICE_RE_REF(rs.getInt("NOTICE_RE_REF"));
					noticeBean.setNOTICE_RE_LEV(rs.getInt("NOTICE_RE_LEV"));
					noticeBean.setNOTICE_RE_SEQ(rs.getInt("NOTICE_RE_SEQ"));
					noticeBean.setNOTICE_READCOUNT(rs.getInt("NOTICE_READCOUNT"));
					noticeBean.setNOTICE_DATE(rs.getDate("NOTICE_DATE"));
					noticeBean.setNOTICE_NAME(rs.getString("NOTICE_NAME"));
					
					aList.add(noticeBean);
				}
			} catch (Exception e) {
				System.out.println("게시글 가져오기 실패!!!");
				e.printStackTrace();
			} finally {
				close(rs);
				close(ps);
				// 나중에 만든거 먼저 닫는다
			}
			return aList;
		}
		
		
		
		
		
	
		// 공지사항 등록 메서드
		public int insertNotice(Notice n, Connection con) {
			int re = 0;
			PreparedStatement ps = null;
			String sql = "";
			sql = "select max(NOTICE_NUM) from notice";
			ResultSet rs = null;
			int num = 0;
			
			try {
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				
				if(rs.next())
					num = rs.getInt(1) + 1;
				else 
					num = 1;
				
				sql = "insert into notice(NOTICE_NUM, NOTICE_SUBJECT, NOTICE_CONTENT, "
						+ "NOTICE_RE_REF, NOTICE_RE_LEV, NOTICE_RE_SEQ,  NOTICE_NAME, NOTICE_DATE) "
						+ "values (?,?,?,?,?,?,?,now())";
				ps = con.prepareStatement(sql);
				
				ps.setInt(1, num);
				ps.setString(2, n.getNOTICE_SUBJECT());
				ps.setString(3, n.getNOTICE_CONTENT());	
				ps.setInt(4, num);
				ps.setInt(5, 0);
				ps.setInt(6, 0);	
				ps.setString(7, n.getNOTICE_NAME());
				System.out.println(n.getNOTICE_NAME());
				re = ps.executeUpdate();
				// 성공하면 1 실패하면 0
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally {
				close(rs);
				close(ps);
			}
			
			return re;
		}
	
		public int updateNoticeCount(int num) {
			PreparedStatement ps = null;
			int upCount = 0;
			
			String sql = "Update notice set NOTICE_READCOUNT = NOTICE_READCOUNT + 1 WHERE NOTICE_NUM = ?";
					try {
						ps = con.prepareStatement(sql);
						ps.setInt(1, num);
						upCount = ps.executeUpdate();
					} catch (Exception e) {
						System.out.println("조회수 업데이트 오류");
						e.printStackTrace();
					} finally {
						close(ps);
					}
			
			return upCount;
		}
		
		public Notice selectNotice(int num) {
			PreparedStatement ps = null;
			ResultSet rs = null;
			Notice boardBean = null;
			
			try {
				String sql = "select * from notice where NOTICE_NUM = ?";
				ps =  con.prepareStatement(sql);
				ps.setInt(1, num);
				rs = ps.executeQuery();
				if (rs.next()) {
					boardBean = new Notice();
					boardBean.setNOTICE_NUM(rs.getInt("NOTICE_NUM"));
					boardBean.setNOTICE_SUBJECT(rs.getString("NOTICE_SUBJECT"));
					boardBean.setNOTICE_CONTENT(rs.getString("NOTICE_CONTENT"));
					boardBean.setNOTICE_RE_REF(rs.getInt("NOTICE_RE_REF"));
					boardBean.setNOTICE_RE_LEV(rs.getInt("NOTICE_RE_LEV"));
					boardBean.setNOTICE_RE_SEQ(rs.getInt("NOTICE_RE_SEQ"));
					boardBean.setNOTICE_READCOUNT(rs.getInt("NOTICE_READCOUNT"));
					boardBean.setNOTICE_DATE(rs.getDate("NOTICE_DATE"));
					boardBean.setNOTICE_NAME(rs.getString("NOTICE_NAME"));
				}
				
			} catch (Exception e) {
				System.out.println("상세글 가져오기 오류");
				e.printStackTrace();
			} finally {
				close(rs);
				close(ps);
			}
			return boardBean;
		}
		
		public boolean isArticleNoticeWriter(int num, String name) {
			boolean isWriter = false;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			String sql = "select NOTICE_NAME from notice where NOTICE_NUM = ?";
			try {
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);
				rs = ps.executeQuery();
				rs.next();
				if (name.equals(rs.getString(1))) {
					isWriter = true;
				}
				
			} catch (Exception e) {
				System.out.println("관리자 확인 오류");
				e.printStackTrace();
			} finally {
				close(rs);
				close(ps);
			}
			
			return isWriter;
		}
	
		public int updateNotice(Notice notice) {
			int upCount = 0;
			PreparedStatement ps = null;
			String sql = "update notice set NOTICE_SUBJECT = ?,NOTICE_CONTENT = ? where NOTICE_NUM = ?";
			try {
				ps = con.prepareStatement(sql);
				ps.setString(1, notice.getNOTICE_SUBJECT());
				ps.setString(2, notice.getNOTICE_CONTENT());
				ps.setInt(3, notice.getNOTICE_NUM());
				upCount = ps.executeUpdate();
			} catch (Exception e) {
				System.out.println("글 수정(업데이트)중 오류");
				e.printStackTrace();
			} finally {
				close(ps);
			}
			
			return upCount;
		}
		
		// 게시물 삭제
		public int deleteNotice(int num, Connection con) {
			PreparedStatement ps = null;
			int result = 0;
			try {
				String sql = "delete from notice where NOTICE_NUM = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);
				result = ps.executeUpdate();
				
			}catch (Exception ex) {
				ex.printStackTrace();	
			}finally {
				close(ps);
			}
			return result;
		}
		// 전체 게시글 수 가져오기
		public int selectNoticeCount() {
			int listCount = 0;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				ps = con.prepareStatement("select count(*) from notice");
				rs = ps.executeQuery();
				if (rs.next()) {
					listCount = rs.getInt(1);
				}
				
			}catch (Exception ex) {
				System.out.println("getListCount 에러: " + ex);		
			}finally {
				close(rs);
				close(ps);
			}
			return listCount;
		}

		
		public int minusPoint(String id, int num) {
			PreparedStatement ps = null;
			int result = 0;
			String sql = null;
			System.out.println("id=" + id + " num=" + num);
					try {
						if (num == 100 || num >= 100000) {
							sql = "UPDATE member SET point = point - ? WHERE id = ?";
						} else {
							sql = "UPDATE member SET point = point + ? WHERE id = ?";
						}
						ps = con.prepareStatement(sql);
						System.out.println("con= " + con);
						ps.setInt(1, num);
						ps.setString(2, id);
						result = ps.executeUpdate();
						System.out.printf("%d 포인트 차감!", num);
						con.commit();
					} catch (Exception e) {
						System.out.println("포인트 차감 오류");
						e.printStackTrace();
					} finally {
						close(ps);
					}
					System.out.println("result= " + result);
					return result;
		}
	
}
