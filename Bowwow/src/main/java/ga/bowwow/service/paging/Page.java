package ga.bowwow.service.paging;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Component
public class Page {

	private int nowPage = 1;		//현재페이지
	private int nowBlock = 1;		//현재 블록(페이지 담는 단위)
	
	private int pageUnit = 20;		//블록당 표시하는 페이지 갯수
	private int pageSize = 20;		//한 페이지당 보여지는 게시물수


	private int recordPerPage = 10; //하나의 페이지에 표시할 게시글 수
	private int pagePerBlock = 5; //블록당 표시하는 페이지 갯수

	private int totalRecord = 0; //총 게시물 갯수(원본 게시글 수)
	private int totalPage = 0; //전체 페이지 갯수
	private int totalBlock = 0; //전체 블록 갯수

	private int recordBeginIdx = 0; //현재 페이지상의 시작 글번호
	private int recordEndIdx = 0; //현재 페이지상의 마지막 글번호

	private int pageBeginIdx = 0; //현재 블록의 시작 페이지 번호
	private int pageEndIdx = 0; //현재 블록의 끝 페이지 번호
	
	private Map<String, String> map = new HashMap<String, String>();
	
	
	//0개의 파라미터로 페이징 처리할 때(ex:전체 회원 출력, 전체 상품 출력)
	public Map<String, String> data0(Page p){
		
		Map<String, String> map = new HashMap<>();
		map.put("begin", Integer.toString(p.getRecordBeginIdx()));
		map.put("end", Integer.toString(p.getRecordEndIdx()));
		
		return map;
	}
	
	//1개의 파라미터로 페이징 처리할 때(ex:아이디, 게시판 종류)
	public Map<String, String> data1(Page p, String data1, Map<String, String> map){
		
		map.put("begin", Integer.toString(p.getRecordBeginIdx()));
		map.put("end", Integer.toString(p.getRecordEndIdx()));
		map.put(data1, data1);
		
		return map;
	}
	
	
	//2개의 파라미터로 페이징 처리할 때(ex:제목, 검색어)
	public Map<String, String> data2(Page p, String data1, String data2, Map<String, String> map){
		
		map.put("begin", Integer.toString(p.getRecordBeginIdx()));
		map.put("end", Integer.toString(p.getRecordEndIdx()));
		map.put("data1", data1);
		map.put("data2", data2);
		
		return map;
	}
	
	//2개의 파라미터로 페이징 처리할 때(ex:제목, 검색어)
	public Map<String, Object> data22(Page p, int data1, String data2, Map<String, Object> map){
		
		map.put("begin", p.getRecordBeginIdx());
		map.put("end", p.getRecordEndIdx());
		map.put("data1", data1);
		map.put("data2", data2);
		
		return map;
	}
	
	//3개의 파라미터로 페이징 처리할 때(ex:게시판 종류, 제목, 검색어)
	public Map<String, String> search(Page p, String data1, String data2, String data3){
		
		Map<String, String> map = new HashMap<>();
		map.put("begin", Integer.toString(p.getRecordBeginIdx()));
		map.put("end", Integer.toString(p.getRecordEndIdx()));
		map.put("data1", data1);
		map.put("data2", data2);
		map.put("data3", data3);
		
		return map;
	}

	
	public Page setPage(int recordCount, String nowPage, int recordPerPage, int pagePerBlock) {
		this.setRecordPerPage(recordPerPage);
		this.setPagePerBlock(pagePerBlock);
		this.setNowPage(isCurPageNotNull(nowPage) ? Integer.parseInt(nowPage) : 1);
		this.setTotalRecord(recordCount);
		this.initPage(recordCount);
		return this;
	}
	static boolean isCurPageNotNull(String nowPage) {
		return nowPage != null ? true : false;
	}
	public void initPage(int recordCount) {	//페이지 설정  recordCount : 전체 게시물 수
		this.setRecordScale(recordCount);
		this.setRangeOfPageNo(); 	//페이지의 게시물 범위(begin/end) 설정
		this.setRangeOfBlockNo();	//블록의 페이지 범위(begin/end) 설정
		this.logging();				//필드 데이터 로그 기록
	}
	public void setRecordScale(int recordCount) {
		this.setTotalRecord(recordCount);	//전체 게시물 수 설정
		this.setTotalPage();  				//받아온 전체 게시물 수를 이용해 전체 페이지 수 설정
	}
	public void setTotalPage() {	//받아온 전체 게시물 수를 이용해 전체 페이지 수 설정 
		this.setTotalPage(this.getTotalRecord() % this.getRecordPerPage() > 0
				? (this.getTotalRecord() / this.getRecordPerPage())+1
						: this.getTotalRecord() / this.getRecordPerPage());
	}
	public void setRangeOfPageNo() {	//페이지의 게시물 범위(begin/end) 설정
		this.setRecordBeginIdx((this.getNowPage()-1) * this.getRecordPerPage() + 1);
		this.setRecordEndIdx(this.getRecordEndIdx() > this.getTotalRecord()
				? this.getTotalRecord()
						: this.getNowPage() * this.getRecordPerPage());
	}
	public void setRangeOfBlockNo() {	//블록의 페이지 범위(begin/end) 설정
		this.logging();

		this.setPageBeginIdx((int)((this.getNowPage()-1) / this.getPagePerBlock()) * this.getPagePerBlock() + 1);
		this.setPageEndIdx((this.getPageBeginIdx() + this.getPagePerBlock() - 1) > this.getTotalPage()
				? this.getTotalPage()
						: (this.getPageBeginIdx() + this.getPagePerBlock() - 1));


	}

	public void logging() {
		System.out.println("--------------");
		System.out.println("> 전체 게시글 수 : " + this.getTotalRecord());
		System.out.println("> 전체 페이지 수 : " + this.getTotalPage());
		System.out.println(">> 현재페이지 : " + this.getNowPage());
		System.out.println(">> 시작글번호(begin) : " + this.getRecordBeginIdx());
		System.out.println(">> 끝 글번호(end) : " + this.getRecordEndIdx());
		System.out.println(">> 시작페이지(beginPage) : " + this.getPageBeginIdx());
		System.out.println(">> 끝페이지(endPage) : " + this.getPageEndIdx());
	}


}


