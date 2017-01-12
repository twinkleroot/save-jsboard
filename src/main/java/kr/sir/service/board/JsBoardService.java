package kr.sir.service.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import kr.sir.domain.Write;

public interface JsBoardService {
	
	// 게시판 가져오기
	public Page<Write> findByBoardId(int boardId, PageRequest pageRequest);
	
	// 게시판 가져오기 ( 카테고리로 검색 )
	public Page<Write> findByCategoryName(int boardId, String categoryName, PageRequest pageRequest);
	
	// 게시글 선택 삭제
	public int deleteInIds(String ids);

	// 게시글 보기
	public Write findOne(int articleNumber);

	// 이전 글 or 다음 글 번호 가져오기
	public int findPrevOrNextArticle(int articleNumber, String prevOrNext);

	// 조회수 증가(경우에 따라 증가시키지 않음)
	public void increaseHit(Write article, HttpServletRequest request);

	// 뷰에서 게시글 삭제
	public void delArticle(int articleId);

	// 카테고리 이름 리스트 가져오기 
	public List<String> findCategoryNames();
	
	// 글쓰기, 수정
	public Write save(Write write);
	
	// 게시판에서 가장 작은 wr_num 가져오기
	public int findMinNum();
	
	// 게시판에서 가장 큰 wr_id 가져오기
	public int findMaxId();

	// 해당 게시글에서 가장 큰 댓글 그룹 번호 가져오기
	public int findMaxCommentById(int articleNumber);

	// 게시글의 댓글 리스트 가져오기
	public List<Write> findByParentAndIsComment(int articleNumber, int isComment);
}
