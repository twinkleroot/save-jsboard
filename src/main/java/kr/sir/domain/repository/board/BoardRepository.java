package kr.sir.domain.repository.board;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import kr.sir.domain.Write;

@Repository
public interface BoardRepository extends JpaRepository<Write, Integer>{
	@Query(value = "select count(w) from Write w")		// JPQL	: return type = String
	public String getTotalCount();
	public Page<Write> findByBoardId(int boardId, Pageable pageable);
}
