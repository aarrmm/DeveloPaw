package ga.bowwow.controller.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.amazonaws.AmazonClientException;

import ga.bowwow.controller.common.MultipartController;
import ga.bowwow.service.board.Board;
import ga.bowwow.service.board.BoardService;
import ga.bowwow.service.board.Comment;
import ga.bowwow.service.paging.Page;


@Controller
public class BoardController {
	@Autowired //의존주입(DI) : 동일한 데이터 타입 객체
	private BoardService boardService; //의존주입<-- BoardServiceImpl
	@Autowired 
	private HttpSession session;
	@Autowired 
	private HttpServletRequest request;


	public BoardController() {
		System.out.println("---->>> BoardController() 객체생성");
	}


	//게시글 입력
	@RequestMapping("/community/insertBoard")
	public String insertBoard(Board vo, HttpServletRequest request, MultipartController mc) throws AmazonClientException, IllegalStateException, IOException, InterruptedException {
		System.out.println(">>> 게시글 입력 - insertBoard()");
		System.out.println("vo : " + vo);
		String command = "";
		
		//TODO INSERT
		Map<String, Object> map = new HashMap<String, Object>();
		int board_idx = Integer.parseInt(session.getAttribute("board_idx").toString());
		System.out.println("insert idx: " + board_idx);
		
		map.put("board_idx", board_idx);
		
		
		if(board_idx == 1) {
			command = "diary_board"; }
		else if (board_idx == 2) {
			command = "intro_board"; }
		else if (board_idx == 3) {
			command = "knowhow_board"; }
		else if (board_idx == 4) {
			command = "missing_board"; }
		else if (board_idx == 5) {
			command = "used_transaction_board"; }
		else if (board_idx == 6) {
			command = "event_board"; }

		if(vo.getImg_locas() == null || vo.getImg_locas().length() == 0) {
			//이미지 첨부된 거 없으면 바로 db에 저장
			//			map.put("board", vo);
			vo.setBoard_idx(board_idx);
			boardService.insertBoard(vo);
			System.out.println(vo);

		} else { //이미지가 있으면
			//이미지 경로를 저장할 배열 생성
			String[] imgs_loca = new String[10];

			//이미지 경로 , 단위로 잘라 배열에 저장
			imgs_loca = vo.getImg_locas().split(",");

			//배열값 확인
			//		System.out.println(Arrays.toString(imgs_loca));
			//폴더 이름 설정
			String foldername = "";
			
			if(board_idx == 1) {
				foldername = "diary";
				command = "diary_board"; }
			else if (board_idx == 2) {
				foldername = "intro";
				command = "intro_board"; }
			else if (board_idx == 3) {
				foldername = "knowhow";
				command = "knowhow_board"; }
			else if (board_idx == 4) {
				foldername = "missing";
				command = "missing_board"; }
			else if (board_idx == 5) {
				foldername = "usedtransaction";
				command = "used_transaction_board"; }
			else if (board_idx == 6) {
				foldername = "event"; 
				command = "event_board"; }

			//이미지 배열 길이(이미지 개수) 만큼 MultipartController 객체 생성, S3에 업로드 
			for (int i = 0; i < imgs_loca.length; i++) {
				//			MultipartController mc = new MultipartController();
				//업로드할 이미지 경로, 폴더이름, 리퀘스트 전달(MultipartController에서 contextroot 획득을 위함)
				mc.registerImage(imgs_loca[i], foldername, request);
			}

			//DB에 저장되는 데이터 내부서버경로 -> S3서버 경로로 변환 작업(본문 이미지)
			//나중에 출력할 때에는 S3에 업로드 된 파일을 불러와야 하기 때문
			String original_loca = "src=\"/resources/upload";
			String s3_loca = "src=\"https://projectbit.s3.us-east-2.amazonaws.com/" + foldername;
			String reLoca = vo.getBoard_content().replace(original_loca, s3_loca);
			vo.setBoard_content(reLoca);

			//DB에 저장되는 데이터 내부서버경ert fixing로 -> DB에 저장할 경로로 변경(폴더명/파일명), (썸네일)
			String original_thum_loca = "/resources/upload";
			String thumReLoca = vo.getImg1().replace(original_thum_loca, "" + foldername);
			vo.setImg1(thumReLoca);

			//경로 변환 후 최종 DB에 저장되는 VO값 콘솔에 출력
			System.out.println("reLoca vo : " + vo);
			vo.setBoard_idx(board_idx);

			//			map.put("board", vo);
			//			boardService.insertBoard(map);
			boardService.insertBoard(vo);
		}

		//		return "redirect:/community/board_idx";
		String rtn = "redirect:" + "/community/" + command;
		return rtn;
	}


	//펫 다이어리(list)
	@RequestMapping(value = "/community/diary_board", method = RequestMethod.GET)
	public String getDiaryBoardList(Model model) {
		//		System.out.println(">>> 게시글 전체 목록- String getDiaryBoardList()");
		//		System.out.println("board_idx : " + board_idx);
		String board_idx = "1";
		String cPage = request.getParameter("cPage");

		Page p = new Page();

		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);

		p = p.setPage(boardService.getBoardCount(map), cPage, 6, 5);
		map = p.data1(p, board_idx, map);

		//		for ( String key : map.keySet() ) {
		//		    System.out.println("방법1) key : " + key +" / value : " + map.get(key));
		//		}

		List<Board> boardList = boardService.getBoardList(map);
		//		
		//		System.out.println("diary_board boardList input(map) : " + board_idx);
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("boardList", boardList);
		model.addAttribute("board_idx", board_idx);
		model.addAttribute("pvo", p);
		model.addAttribute("command", "/community/diary_board");
		//
		//		System.out.println("bowwow list : " + boardList);
		//		System.out.println("board model : " + model);

		return "/community/combination_board";

	}

	@RequestMapping(value = "/community/main", method = RequestMethod.GET)
	public String communityMain(Model model) {
		//		System.out.println(">>> 게시글 전체 목록- String getDiaryBoardList()");
		//		System.out.println("board_idx : " + board_idx);
		String board_idx = "0";
		String cPage = request.getParameter("cPage");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);
		
		List<Board> diaryList = boardService.getMainList(1);
		List<Board> introList = boardService.getMainList(2);
		List<Board> knowhowList = boardService.getMainList(3);
		List<Board> missingList = boardService.getMainList(4);
//		List<Board> introList = boardService.search("2", keyword);
//		List<Board> knowhowList = boardService.search("3", keyword);
//		List<Board> missingList = boardService.search("4", keyword);
		
		System.out.println("searchboard d:" + diaryList);
		//System.out.println("searchboard:" + introlist);
		//System.out.println("searchboard:" + knowhowlist);
		session.setAttribute("board_idx", 0);
		session.setAttribute("diaryList.board_idx", 1);
		session.setAttribute("introList.board_idx", 2);
		session.setAttribute("knowhowList.board_idx", 3);
		session.setAttribute("missingList.board_idx", 4);
		model.addAttribute("diaryList", diaryList);
		model.addAttribute("introList", introList);
		model.addAttribute("knowhowList", knowhowList);
		model.addAttribute("missingList", missingList);

		return "/community/main";
	}
	
	@RequestMapping(value = "/community/write", method = RequestMethod.GET)
	public String mainWrite(Model model, @RequestParam("board_idx") int board_idx) {
		String command = "";
		
		if(board_idx == 1 || board_idx == 2 || board_idx == 4) {
			command = "write_combination";
		} else if(board_idx == 3) {
			command = "write_knowhow_board";
		} else if(board_idx == 5) {
			command = "write_used_transaction_board";
		}
		
		session.setAttribute("board_idx", board_idx);
		
		return "/community/" + command;
	}




	//펫 소개(list)
	@RequestMapping(value = "/community/intro_board", method = RequestMethod.GET)
	public String getIntroBoardList(Model model, HttpSession session) {
		System.out.println(">>> 게시글 전체 목록- String getintro_BoardList()");
		System.out.println("> boardService : " + boardService);

		String board_idx = "2";
		String cPage = request.getParameter("cPage");
		Page p = new Page();

		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);

		p = p.setPage(boardService.getBoardCount(map), cPage, 6, 5);
		map = p.data1(p, board_idx, map);

		//		for ( String key : map.keySet() ) {
		//		    System.out.println("방법1) key : " + key +" / value : " + map.get(key));
		//		}

		List<Board> boardList = boardService.getBoardList(map);
		//		
		//		System.out.println("diary_board boardList input(map) : " + board_idx);
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pvo", p);
		model.addAttribute("command", "/community/intro_board");

		return "/community/combination_board";
	}

	//펫 노하우(list)
	@RequestMapping(value = "/community/knowhow_board", method = RequestMethod.GET)
	public String getKnowhowBoardList(Model model, HttpSession session) {
		System.out.println(">>> 게시글 전체 목록- String getknowhow_BoardList()");

		String board_idx = "3";
		String cPage = request.getParameter("cPage");
		Page p = new Page();

		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);

		p = p.setPage(boardService.getBoardCount(map), cPage, 6, 5);
		map = p.data1(p, board_idx, map);

		//			for ( String key : map.keySet() ) {
		//			    System.out.println("방법1) key : " + key +" / value : " + map.get(key));
		//			}

		List<Board> boardList = boardService.getBoardList(map);
		//			
		//			System.out.println("diary_board boardList input(map) : " + board_idx);
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pvo", p);
		model.addAttribute("command", "/community/knowhow_board");

		return "/community/knowhow_board";
	}


	//잃어버린 반려동물 찾기(list)
	@RequestMapping(value = "/community/missing_board",method = RequestMethod.GET)
	public String getMissingBoardList(Model model, HttpSession session) {
		System.out.println(">>> 게시글 전체 목록- String getmissing_BoardList()");

		String board_idx = "4";
		String cPage = request.getParameter("cPage");
		Page p = new Page();

		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);

		p = p.setPage(boardService.getBoardCount(map), cPage, 6, 5);
		map = p.data1(p, board_idx, map);

		//			for ( String key : map.keySet() ) {
		//			    System.out.println("방법1) key : " + key +" / value : " + map.get(key));
		//			}

		List<Board> boardList = boardService.getBoardList(map);
		//			
		//			System.out.println("diary_board boardList input(map) : " + board_idx);
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pvo", p);
		model.addAttribute("command", "/community/missing_board");

		return "/community/combination_board";

	}



	//펫 중고장터(list)
	@RequestMapping(value = "/community/used_transaction_board", method = RequestMethod.GET)
	public String used_transaction_board(Model model, HttpSession session) {
		System.out.println(">>> 게시글 전체 목록- String getmissing_BoardList()");

		String board_idx = "5";
		String cPage = request.getParameter("cPage");
		Page p = new Page();

		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);

		p = p.setPage(boardService.getBoardCount(map), cPage, 6, 5);
		map = p.data1(p, board_idx, map);

		//			for ( String key : map.keySet() ) {
		//			    System.out.println("방법1) key : " + key +" / value : " + map.get(key));
		//			}

		List<Board> boardList = boardService.getBoardList(map);
		//			
		//			System.out.println("diary_board boardList input(map) : " + board_idx);
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pvo", p);
		model.addAttribute("command", "/community/used_transaction_board");

		return "/community/used_transaction_board";

	}

	//이벤트(list)
	@RequestMapping(value = "/community/event_board", method = RequestMethod.GET)
	public String getEventBoardList(Model model, HttpSession session) {
		System.out.println(">>> 게시글 전체 목록- String getmissing_BoardList()");

		String board_idx = "6";
		String cPage = request.getParameter("cPage");
		Page p = new Page();

		Map<String, String> map = new HashMap<String, String>();
		map.put("board_idx", board_idx);

		p = p.setPage(boardService.getBoardCount(map), cPage, 6, 5);
		map = p.data1(p, board_idx, map);

		//			for ( String key : map.keySet() ) {
		//			    System.out.println("방법1) key : " + key +" / value : " + map.get(key));
		//			}

		List<Board> boardList = boardService.getBoardList(map);
		//			
		//			System.out.println("diary_board boardList input(map) : " + board_idx);
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pvo", p);
		model.addAttribute("command", "/community/event_board");

		return "/community/event_board";

	}	
	
	//이벤트(list)
	@RequestMapping(value = "/community/animal_hospital", method = RequestMethod.GET)
	public String getAnimalHospital(Model model) {
		
		String board_idx = "7";
		
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("command", "/community/animal_hospital");
		
		return "/community/animal_hospital";
		
	}	


	//상세페이지
	@RequestMapping(value = "/community/detail", method = RequestMethod.GET)
	public String getBoard(@RequestParam("board_idx") String sboard_idx,
			@RequestParam("board_no") int board_no, Board vo, Model model) {

		int board_idx = Integer.parseInt(sboard_idx);
		System.out.println("board_idx : "  + board_idx);
		System.out.println(">>> 글상세 - String getBoard()");
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_idx", board_idx);
		map.put("board_no", board_no );
		vo = boardService.getBoard(map);
		boardService.updateHits(map);

		List<Comment> commentList = boardService.getCommentList(map);
		List<Comment> comment2List = boardService.getComment2List(map);

		System.out.println("detail vo : " + vo);

		System.out.println("commentList : " + commentList);
		System.out.println("comment2List : " + comment2List);

		//TODO 임시 회원 시리얼을 실제 객체로 교체할 것
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("board_no", board_no);
		model.addAttribute("vo", vo);
		model.addAttribute("commentList", commentList);
		model.addAttribute("comment2List", comment2List);

		return "/community/detail_board";

	}
	
	//상세페이지
	@RequestMapping(value = "/community/knowhow_detail", method = RequestMethod.GET)
	public String getKnowhowBoard(@RequestParam("board_idx") String sboard_idx,
			@RequestParam("board_no") int board_no, Board vo, Model model) {
		
		int board_idx = Integer.parseInt(sboard_idx);
		System.out.println("board_idx : "  + board_idx);
		System.out.println(">>> 글상세 - String getBoard()");
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_idx", board_idx);
		map.put("board_no", board_no );
		vo = boardService.getBoard(map);
		boardService.updateHits(map);
		
		List<Comment> commentList = boardService.getCommentList(map);
		List<Comment> comment2List = boardService.getComment2List(map);
		
		System.out.println("detail vo : " + vo);
		
		System.out.println("commentList : " + commentList);
		System.out.println("comment2List : " + comment2List);
		
		//TODO 임시 회원 시리얼을 실제 객체로 교체할 것
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("board_no", board_no);
		model.addAttribute("vo", vo);
		model.addAttribute("commentList", commentList);
		model.addAttribute("comment2List", comment2List);
		
		return "/community/knowhow_detail_board";
		
	}
	
	//상세페이지
	@RequestMapping(value = "/community/transaction_detail", method = RequestMethod.GET)
	public String getTransactionBoard(@RequestParam("board_idx") String sboard_idx,
			@RequestParam("board_no") int board_no, Board vo, Model model) {
		
		int board_idx = Integer.parseInt(sboard_idx);
		System.out.println("board_idx : "  + board_idx);
		System.out.println(">>> 글상세 - String getBoard()");
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_idx", board_idx);
		map.put("board_no", board_no );
		vo = boardService.getBoard(map);
		boardService.updateHits(map);
		
		List<Comment> commentList = boardService.getCommentList(map);
		List<Comment> comment2List = boardService.getComment2List(map);
		
		System.out.println("detail vo : " + vo);
		
		System.out.println("commentList : " + commentList);
		System.out.println("comment2List : " + comment2List);
		
		//TODO 임시 회원 시리얼을 실제 객체로 교체할 것
		session.setAttribute("board_idx", board_idx);
		model.addAttribute("board_no", board_no);
		model.addAttribute("vo", vo);
		model.addAttribute("commentList", commentList);
		model.addAttribute("comment2List", comment2List);
		
		return "/community/transaction_detail_board";
		
	}


	//댓글 입력
	@RequestMapping(value = "/community/comment", method = RequestMethod.GET)
	public String reply(Comment comment, @RequestParam("board_idx") int board_idx ,
			@RequestParam("board_no") int board_no ,
			Model model, HttpSession session) {
		String comment_content = comment.getComment_content();

		System.out.println(">>> 댓글 - reply()");
		System.out.println("댓글내용:" + comment_content);
		comment.setComment_content(comment_content);
		comment.setBoard_no(Integer.toString(board_no));
		System.out.println(comment);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		map.put("comment",comment);
		boardService.insertComment(map);

		return "redirect:/community/detail?board_idx=" + session.getAttribute("board_idx") + "&board_no=" + board_no;
	}

	//대댓글 입력
	@RequestMapping(value = "/community/comment2", method = RequestMethod.GET)
	public String reply2(Comment comment, @RequestParam("board_no") int board_no ,
						@RequestParam("board_idx") int board_idx, 
						@RequestParam("comment_no") String comment_no,
						Model model, HttpSession session) {

		String comment_content = comment.getComment_content(); //대댓글 내용

		System.out.println(">>> 댓글 - reply()");
		System.out.println("대댓글내용:" + comment_content);
		comment.setComment_content(comment_content);
		comment.setComment_no(comment_no);
		System.out.println(comment);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		map.put("comment",comment);
		boardService.insertComment2(map);

		return "redirect:/community/detail?board_idx=" + session.getAttribute("board_idx") + "&board_no=" + board_no;

	}


	//게시글 삭제
	@RequestMapping(value = "/community/boardDelete", method = RequestMethod.POST)
	public String boardDelete(@RequestParam("board_no") int board_no ,
			@RequestParam("board_idx") String board_idx, Model model) {

		System.out.println(">>> 게시글 삭제 - boardDelete()");
		System.out.println(board_no +  " / " + board_idx);
		String command = "";
		
		if(board_idx.equals("1")) {
			command = "diary_board"; }
		else if (board_idx.equals("2")) {
			command = "intro_board"; }
		else if (board_idx.equals("3")) {
			command = "knowhow_board"; }
		else if (board_idx.equals("4")) {
			command = "missing_board"; }
		else if (board_idx.equals("5")) {
			command = "used_transaction_board"; }
		else if (board_idx.equals("6")) {
			command = "event_board"; }

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		map.put("board_no", board_no);
		boardService.boardDelete(map);
		
		return "redirect:/community/" + command;
	}

	//댓글 삭제
	@RequestMapping(value = "/community/commentDelete", method = RequestMethod.GET)
	public String commentDelete(@RequestParam("comment_no") String comment_no, @RequestParam("board_no") int board_no ,
			@RequestParam("board_idx") String board_idx, Model model) {
		Comment comment=new Comment();
		comment.setComment_no(comment_no);
		comment.setBoard_no(Integer.toString(board_no));
		System.out.println("-------------comment-----------" + comment); 
		System.out.println(">>> 댓글삭제 - commentDelete()");
		System.out.println(board_no +  " / " +board_idx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		map.put("comment", comment);
		boardService.commentDelete(map);
		
		return "redirect:/community/detail?board_idx=" + board_idx + "&board_no=" + board_no;
	}

	//대댓글 삭제
	@RequestMapping(value = "/community/commentDelete2", method = RequestMethod.GET)
	public String commentDelete2(@RequestParam("comment_no") String comment_no, @RequestParam("board_no") int board_no ,
			@RequestParam("board_idx") String board_idx, Model model) {
		Comment comment=new Comment();
		comment.setComment_no(comment_no);
		//comment.setBoard_no(Integer.toString(board_no));
		System.out.println("-------------comment-----------" + comment); 
		System.out.println(">>> 댓글삭제 - commentDelete()");
		System.out.println(board_no +  " / " +board_idx);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		map.put("comment", comment);
		boardService.commentDelete2(map);
		
		return "redirect:/community/detail?board_idx=" + board_idx + "&board_no=" + board_no;
	}


	@RequestMapping("/community/update/board")
	public String updateBoard(Board vo, HttpServletRequest request, MultipartController mc, Model model) 
			throws AmazonClientException, IllegalStateException, IOException, InterruptedException {
		System.out.println(">>> 게시글 수정화면 - updateBoard()");
		String command = "";

		int board_idx = (int) session.getAttribute("board_idx");
		int board_no = vo.getBoard_no();

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("board_idx", board_idx);
		map.put("board_no", board_no);

		vo = boardService.getBoard(map);

		model.addAttribute("vo", vo);
		
		if(board_idx == 3) {
			command = "update_knowhow_board";
		}
		else if (board_idx == 5) {
			command = "update_used_transaction_board";
		}
		else command = "update_board";

		return "/community/" + command;
	}


	@RequestMapping("/community/do-update/board")
	public String doUpdateBoard(Board vo, HttpServletRequest request, MultipartController mc) 
			throws AmazonClientException, IllegalStateException, IOException, InterruptedException {
		System.out.println(">>> 게시글 수정 - do-updateBoard()");
		System.out.println("vo : " + vo);
		String command = "";
		//TODO UPDATE
		int board_idx = (int) session.getAttribute("board_idx");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", board_idx);
		
		
		if(board_idx == 1) {
			command = "diary_board"; }
		else if (board_idx == 2) {
			command = "intro_board"; }
		else if (board_idx == 3) {
			command = "knowhow_board"; }
		else if (board_idx == 4) {
			command = "missing_board"; }
		else if (board_idx == 5) {
			command = "used_transaction_board"; }
		else if (board_idx == 6) {
			command = "event_board"; }

		if(vo.getImg_locas() == null || vo.getImg_locas().length() == 0) {
			//이미지 첨부된 거 없으면 바로 db에 저장
			boardService.updateBoard(vo, session);

		} else {
			//이미지 경로를 저장할 배열 생성
			String[] imgs_loca = new String[10];

			//이미지 경로 , 단위로 잘라 배열에 저장
			imgs_loca = vo.getImg_locas().split(",");

			//배열값 확인
			//		System.out.println(Arrays.toString(imgs_loca));

			//폴더 이름 설정
			String foldername = "";
			
			if(board_idx == 1) {
				foldername = "diary";
				command = "diary_board"; }
			else if (board_idx == 2) {
				foldername = "intro";
				command = "intro_board"; }
			else if (board_idx == 3) {
				foldername = "knowhow";
				command = "knowhow_board"; }
			else if (board_idx == 4) {
				foldername = "missing";
				command = "missing_board"; }
			else if (board_idx == 5) {
				foldername = "usedtransaction";
				command = "used_transaction_board"; }
			else if (board_idx == 6) {
				foldername = "event"; 
				command = "event_board"; }
			//이미지 배열 길이(이미지 개수) 만큼 MultipartController 객체 생성, S3에 업로드 
			for (int i = 0; i < imgs_loca.length; i++) {
				//			MultipartController mc = new MultipartController();
				//업로드할 이미지 경로, 폴더이름, 리퀘스트 전달(MultipartController에서 contextroot 획득을 위함)
				mc.registerImage(imgs_loca[i], foldername, request);
			}

			//DB에 저장되는 데이터 내부서버경로 -> S3서버 경로로 변환 작업(본문 이미지)
			//나중에 출력할 때에는 S3에 업로드 된 파일을 불러와야 하기 때문
			String original_loca = "src=\"/resources/upload";
			String s3_loca = "src=\"https://projectbit.s3.us-east-2.amazonaws.com/" + foldername;
			String reLoca = vo.getBoard_content().replace(original_loca, s3_loca);
			vo.setBoard_content(reLoca);

			//DB에 저장되는 데이터 내부서버경로 -> DB에 저장할 경로로 변경(폴더명/파일명), (썸네일)
			String original_thum_loca = "/resources/upload";
			String thumReLoca = vo.getImg1().replace(original_thum_loca, "" + foldername);
			vo.setImg1(thumReLoca);

			//경로 변환 후 최종 DB에 저장되는 VO값 콘솔에 출력
			System.out.println("reLoca vo : " + vo);

			boardService.updateBoard(vo, session);
			
		}


		return "redirect:/community/detail?board_idx=" + session.getAttribute("board_idx")
		+ "&board_no=" + vo.getBoard_no() ;

	}


	//메소드에 선언된 @ModelAttribute : 리턴된 데이터를 View에 전달
	//@ModelAttribute 선언된 메소드는 @RequestMapping 메소드보다 먼저 실행됨
	//뷰에 전달될 때 설정된 명칭(예: conditionMap)으로 전달
	@RequestMapping("/community/search")
	public String search(Board board, Model model) {
		String keyword = board.getKeyword();
		System.out.println(">> 통합검색 - String search()");

		System.out.println(board);
		System.out.println("search vo:"+board.getKeyword());
		List<Board> diarylist = boardService.search("1", keyword);
		List<Board> introlist = boardService.search("2", keyword);
		List<Board> knowhowlist = boardService.search("3", keyword);
		List<Board> missinglist = boardService.search("4", keyword);
		List<Board> transactionlist = boardService.search("5", keyword);
		
		//System.out.println(diarylist.toString().replaceAll(pattern,""));
		System.out.println("searchboard d:" + diarylist);
		//System.out.println("searchboard:" + introlist);
		//System.out.println("searchboard:" + knowhowlist);
	
		model.addAttribute("diarylist",diarylist);
		model.addAttribute("introlist",introlist);
		model.addAttribute("knowhowlist",knowhowlist);
		model.addAttribute("missinglist",missinglist);
		model.addAttribute("transactionlist",transactionlist);

		return "/community/search";
	}
	
	@RequestMapping("/community/boardSearch")
	public String boardSearch(Board board, Model model, @RequestParam("board_idx") int board_idx,
								@RequestParam("idx") int idx, @RequestParam("keyword") String keyword) {
		
		String b_idx = Integer.toString(board_idx);
		List<Board> boardList = boardService.boardSearch(b_idx, idx, keyword);
		
		String command = "";
		
		if(b_idx.equals("1")) {
			command = "combination_board"; }
		else if (b_idx.equals("2")) {
			command = "combination_board"; }
		else if (b_idx.equals("3")) {
			command = "knowhow_board"; }
		else if (b_idx.equals("4")) {
			command = "combination_board"; }
		else if (b_idx.equals("5")) {
			command = "used_transaction_board"; }
		else if (b_idx.equals("6")) {
			command = "event_board"; }
		
		System.out.println("searchboard d:" + boardList);
		model.addAttribute("boardList", boardList);
		
		return "/community/" + command;
	}


	@RequestMapping("/community/insertComment")
	public String insertComment(Comment vo) throws IllegalStateException, IOException, AmazonClientException, InterruptedException {
		System.out.println(">>> 댓글 입력 - insertComment()");
		System.out.println("vo : " + vo);


		//	boardService.insertComment(vo);

		return "/community/insert_complete";

	}


	@RequestMapping("/community/insertComment2")
	public String insertComment2(Comment vo) throws IllegalStateException, IOException, AmazonClientException, InterruptedException {
		System.out.println(">>> 댓글 입력 - insertComment()");
		System.out.println("vo : " + vo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("board_idx", 1);
		map.put("board_no", 1);


		boardService.insertComment2(map);
		return null;
	}

	/*
	@RequestMapping("/community/reportList")
	public String getReportList(@RequestParam("report_idx") String idx, Model model) {

		System.out.println(">>> 신고 전체 목록- String getBoardReportList()");
		//		System.out.println("> boardService : " + boardService);
		System.out.println(idx);
		session.setAttribute("report_idx", idx);
		String r_idx = session.getAttribute("report_idx").toString();
		int report_idx = Integer.parseInt(r_idx);

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("report_idx", report_idx);

		List<Report> reportList = boardService.getReportList(report_idx);

		model.addAttribute("reportList", reportList);

		System.out.println("report list : " + reportList);

		//		if(report_idx == 1) {
		//			return "/community/" + "reportList";
		//			
		//		} else return "/community/" + "comment_report";


		return "/community/" + "reportList";
	}



	
	@RequestMapping("updateBoard")
	public String updateBoard(Board vo) {
		System.out.println(">>> 글수정 - updateBoard()");
		boardService.updateBoard(vo);

		return "getBoardList";
	}	

	@RequestMapping("deleteBoard")
	public String deleteBoard(Board vo) {
		System.out.println(">>> 글수정 - deleteBoard()");
		boardService.deleteBoard(vo);
		S
		return "getBoardList";
	}	

	//Ajax 요청을 받고 JSON 배열 데이터 리턴
	@RequestMapping("ajaxGetBoardList")
	@ResponseBody
	public List<Board> ajaxGetBoardList(Board vo) {
		List<Board> boardList = boardService.getBoardList(vo);
		System.out.println("boardList : " + boardList);

		return boardList;
	}
	 */

}


