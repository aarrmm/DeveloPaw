package ga.bowwow.service.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import ga.bowwow.service.board.Board;
import ga.bowwow.service.board.Comment;
import ga.bowwow.service.board.Report;


@Repository("boardDAO")
public class BoardDAO {
	
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public BoardDAO() {
		System.out.println(">> BoardDAOMybatis() 객체생성");
	}
	
	//글 입력
	public void insertBoard(Board vo) {
		System.out.println("===> MyBatis로 insertBoard() 실행");
		
		mybatis.insert("BoardDAO.insertBoard", vo);
		System.out.println("boarddao : " + vo);
	}
	
	//글 수정
	public void updateBoard(Board vo, HttpSession session) {
		System.out.println("===> MyBatis로 updateBoard() 실행");
		Map<String, Object> map = new HashMap<String, Object>();
//		int board_idx = Integer.parseInt(session.getAttribute("board_idx").toString());
		int board_idx = (int) session.getAttribute("board_idx");
		map.put("board_idx", board_idx);
		map.put("vo", vo);
		mybatis.update("BoardDAO.updateBoard", map);
	}
	
	//글 삭제
	public void deleteBoard(Board vo) {
		System.out.println("===> MyBatis로 deleteBoard() 실행");
		mybatis.delete("BoardDAO.deleteBoard", vo);
	}		
	
	//게시글 1개 조회
	public Board getBoard(Map<String, Integer> map) {
		System.out.println("상세페이지 : " + map);
		System.out.println("===> MyBatis로 getBoard() 실행");
		return mybatis.selectOne("BoardDAO.getBoard", map);
	}
	
	public int updateHits(Map<String, Integer> map) {
		return mybatis.update("BoardDAO.updateHits", map);
	}
	
	public List<Board> getBoardList(Map<String, String> map) {
		
		System.out.println("===> MyBatis로 getBoardList() 실행-vo");
//		System.out.println("dao board_name: " + board_name);
		
		return mybatis.selectList("BoardDAO.getBoardList", map);
	}
	
	public List<Board> getMainList(int board_idx) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_idx", board_idx);
		System.out.println("===> MyBatis로 getBoardList() 실행-vo");
//		System.out.println("dao board_name: " + board_name);
		
		return mybatis.selectList("BoardDAO.getMainList", map);
	}
	
	
	public List<Comment> getCommentList(Map<String, Integer> map) {
		System.out.println("===> MyBatis로 getCommentList() 실행-vo");
		
		return mybatis.selectList("BoardDAO.getCommentList", map);
	}
	
	public List<Comment> getComment2List(Map<String, Integer> map) {
		System.out.println("===> MyBatis로 getComment2List() 실행-vo");
		
		return mybatis.selectList("BoardDAO.getComment2List", map);
	}

//	public List<Board> getBoardList() {
//		
//		return null;
//	}	
	
	public void boardDelete(Map<String, Object> map) {
		System.out.println("===> MyBatis로 boardDelete 실행");
		System.out.println("꺄르륵" + map);
		mybatis.delete("BoardDAO.boardDelete", map);
	}
	

	public List<Board> search(String board, String keyword) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board);
		map.put("keyword", keyword);
		System.out.println("map : " + map);
		System.out.println("===> MyBatis로 search() 실행-vo");
		return mybatis.selectList("BoardDAO.search",map);
	}
	
	public List<Board> boardSearch(String board_idx, int idx, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		map.put("idx", idx);
		map.put("keyword", keyword);
		System.out.println("map : " + map);
		System.out.println("===> MyBatis로 search() 실행-vo");
		return mybatis.selectList("BoardDAO.boardSearch",map);
	}
	
	
	public void insertReport(Report vo) {
		System.out.println("===> MyBatis로 insertReport() 실행");
		mybatis.insert("BoardDAO.report", vo);
		System.out.println("boardao : " + vo);
	}

	public void commentDelete(Map<String, Object> map) {
		System.out.println("===> MyBatis로 commentDelete 실행");
		System.out.println("commentDelete map :"+map );
		mybatis.update("BoardDAO.commentDelete", map);
		
	}
	
	public void commentDelete2(Map<String, Object> map) {
		System.out.println("===> MyBatis로 commentDelete 실행");
		System.out.println("commentDelete map :"+map );
		mybatis.update("BoardDAO.commentDelete2", map);
		
	}
	
	public int getBoardCount(Map<String, String> map) {
		return mybatis.selectOne("BoardDAO.getBoardCount", map);
	}

}
