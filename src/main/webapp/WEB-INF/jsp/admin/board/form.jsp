<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<jsp:include page="../main/head.jsp"></jsp:include> 

<c:if test="${countBoardsGroup<1}">
	<script>
		alert("게시판 그룹이 한 개 이상 생성되어야 합니다","/adm/board/group_list");
	</script>
	
</c:if>
 
    
    
<c:choose>    
	<c:when test="${type eq 'add'}" >
		<c:set var="htmlTitle" value="ㅣ게시판생성"/>
		<c:set var="required" value="required"/>
		<c:set var="soundOnly" value="<strong class='sound_only'>필수</strong>"/>
		<c:set var="required_valid" value="alnum_"/>
		
		
	</c:when>
	
	<c:when test="${type eq 'update'}">
		<c:set var="htmlTitle" value="게시판수정"/>		
		<c:set var="readonly" value="readonly"/>
		
	</c:when>

</c:choose>  





    
    

<div id="container">
    <!-- 중간 레이아웃 -->
    <h1 id="container_title">게시판 생성</h1>

    <div id="container_wr">

        <div id="board_form"> 
        <form name="fboardform" id="fboardform" action="/adm/board/${type}" onsubmit="return fboardform_submit(this)" method="post" enctype="multipart/form-data">
            <input type="hidden" name="_method" value=""/>
            <ul class="tab_01">
               <li><button type="button"  class="selected">기본설정</button></li>
               <li><button type="button">권한 설정</button></li>
               <li><button type="button">기능 설정</button></li>
               <li><button type="button">디자인/양식</button></li>
               <li><button type="button">포인트설정</button></li> 
               <li><button type="button">여분필드</button></li>
            </ul>                    

            <ul class="contents table_basic table_form">
                <!--기본설정-->
                <li class="tab_content">
                    <div class="tab_wr">
                        <h2>게시판 기본 설정</h2>
                        <table>
                            <tbody>
                            <tr>
                                <th scope="row"><label for="bo_table">TABLE</label>
                                    <span class="tooltip">
                                        <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                        <span class="tooltip_area">영문자, 숫자, _ 만 가능 (공백없이 20자 이내)</span>
                                    </span>
                                </th>
                                <td colspan="2">
                                    <input type="text" name="table" value="${board.table}" ${required} ${readonly} id="bo_table" maxlength="20" class="frm_input ${required} ${readonly} ${required_valid}">
                                  	<c:if test="${type eq 'update' }">
                                    <a href="#" class="btn_frmline">게시판 바로가기</a>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="gr_id">그룹<strong class="sound_only">필수</strong></label></th>
                                <td colspan="2">
                                     ${selectedGroupTag} 

                                    <c:if test="${type eq 'update' }">
                                    <a href="javascript:document.location.href='/adm/board/list/sfl/gr_id/stx/${board.id}'" class="btn_frmline">동일그룹 게시판목록</a>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="bo_subject">게시판 제목<strong class="sound_only">필수</strong></label></th>
                                <td colspan="2">
                                    <input type="text" name="subject" value="${board.subject}" id="bo_subject" required class="required frm_input" size="80" maxlength="120">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="bo_mobile_subject">모바일 게시판 제목</label>
                                    <span class="tooltip">
                                        <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                        <span class="tooltip_area">모바일에서 보여지는 게시판 제목이 다른 경우에 입력합니다. 입력이 없으면 기본 게시판 제목이 출력됩니다.</span>
                                    </span>
                                </th>
                                <td colspan="2">
                                    <input type="text" name="mobileSubject" value="${board.mobileSubject}" id="bo_mobile_subject" class="frm_input" size="80" maxlength="120">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="bo_device">접속기기</label>
                                    <span class="tooltip">
                                        <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                        <span class="tooltip_area">PC 와 모바일 사용을 구분합니다.</span>
                                    </span>
                                </th>
                                <td>
                                    <select id="bo_device" name="device">
                                        <option value="both">PC와 모바일에서 모두 사용</option>
                                        <option value="pc">PC 전용</option>
                                        <option value="mobile">모바일 전용</option>
                                    </select>
                                </td>
                                <td class="td_grpset">
                                    <input type="checkbox" name="chk_group_device" value="1" id="chk_grp_device">
                                    <label for="chk_grp_device">그룹적용</label>
                                    <input type="checkbox" name="chk_all_device" value="1" id="chk_all_device">
                                    <label for="chk_all_device">전체적용</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="bo_category_list">분류</label>
                                    <span class="tooltip">
                                        <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                        <span class="tooltip_area">분류와 분류 사이는 | 로 구분하세요. (예: 질문|답변) 첫자로 #은 입력하지 마세요. (예: #질문|#답변 [X])</span>
                                    </span>
                                </th>
                                <td>
                                    <input type="text" name="categoryList" value="${board.categoryList}" id="bo_category_list" class="frm_input" size="70">
                                    <input type="checkbox" name="useCategory" value="1" id="bo_use_category" <c:if test="${board.useCategory eq 1  }">checked</c:if>>
                                    <label for="bo_use_category">사용</label>
                                </td>
                                <td class="td_grpset">
                                    <input type="checkbox" name="chk_grp_category_list" value="1" id="chk_grp_category_list">
                                    <label for="chk_grp_category_list">그룹적용</label>
                                    <input type="checkbox" name="chk_all_category_list" value="1" id="chk_all_category_list">
                                    <label for="chk_all_category_list">전체적용</label>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="proc_count">카운트 조정</label>
                                    <span class="tooltip">
                                        <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                        <span class="tooltip_area"><fmt:formatNumber value="${board.countWrite}" pattern="#,###.##"/>, <fmt:formatNumber value="${board.countComment}" pattern="#,###.##"/><br>게시판 목록에서 글의 번호가 맞지 않을 경우에 체크하십시오.</span>
                                    </span>
                                </th>
                                <td colspan="2">
                                    <input type="checkbox" name="proc_count" value="1" id="proc_count">
                                </td>
                            </tr>
                            </tbody>
                        
                        </table>
                    </div>
                </li>



                <!--권한설정-->
                <li class="tab_content">
                    <div class="tab_wr">
                        <h2>게시판 권한 설정</h2>
                        <table>
                        <tbody>
                        <tr>
                            <th scope="row"><label for="bo_admin">게시판 관리자</label></th>
                            <td>
                                <input type="text" name="admin" value="${board.admin}" id="bo_admin" class="frm_input" maxlength="20">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_admin" value="1" id="chk_grp_admin">
                                <label for="chk_grp_admin">그룹적용</label>
                                <input type="checkbox" name="chk_all_admin" value="1" id="chk_all_admin">
                                <label for="chk_all_admin">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_list_level">목록보기 권한</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">권한 1은 비회원, 2 이상 회원입니다. 권한은 10 이 가장 높습니다.</span>
                                </span>
                            </th>
                            <td>
                               ${listLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_list_level" value="1" id="chk_grp_list_level">
                                <label for="chk_grp_list_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_list_level" value="1" id="chk_all_list_level">
                                <label for="chk_all_list_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_read_level">글읽기 권한</label></th>
                            <td>
                                ${leadLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_read_level" value="1" id="chk_grp_read_level">
                                <label for="chk_grp_read_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_read_level" value="1" id="chk_all_read_level">
                                <label for="chk_all_read_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_write_level">글쓰기 권한</label></th>
                            <td>
                                ${writeLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_write_level" value="1" id="chk_grp_write_level">
                                <label for="chk_grp_write_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_write_level" value="1" id="chk_all_write_level">
                                <label for="chk_all_write_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_reply_level">글답변 권한</label></th>
                            <td>
                                ${replyLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_reply_level" value="1" id="chk_grp_reply_level">
                                <label for="chk_grp_reply_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_reply_level" value="1" id="chk_all_reply_level">
                                <label for="chk_all_reply_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_comment_level">댓글쓰기 권한</label></th>
                            <td>
                                ${commentLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_comment_level" value="1" id="chk_grp_comment_level">
                                <label for="chk_grp_comment_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_comment_level" value="1" id="chk_all_comment_level">
                                <label for="chk_all_comment_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_link_level">링크 권한</label></th>
                            <td>
                                ${linkLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_link_level" value="1" id="chk_grp_link_level">
                                <label for="chk_grp_link_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_link_level" value="1" id="chk_all_link_level">
                                <label for="chk_all_link_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_upload_level">업로드 권한</label></th>
                            <td>
                                ${uploadLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_upload_level" value="1" id="chk_grp_upload_level">
                                <label for="chk_grp_upload_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_upload_level" value="1" id="chk_all_upload_level">
                                <label for="chk_all_upload_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_download_level">다운로드 권한</label></th>
                            <td>
                                ${downloadLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_download_level" value="1" id="chk_grp_download_level">
                                <label for="chk_grp_download_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_download_level" value="1" id="chk_all_download_level">
                                <label for="chk_all_download_level">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_html_level">HTML 쓰기 권한</label></th>
                            <td>
                                ${htmlLevelSelectTag}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_html_level" value="1" id="chk_grp_html_level">
                                <label for="chk_grp_html_level">그룹적용</label>
                                <input type="checkbox" name="chk_all_html_level" value="1" id="chk_all_html_level">
                                <label for="chk_all_html_level">전체적용</label>
                            </td>
                        </tr>
                        </tbody>
                        
                        </table>
                    </div>
                </li>

                <!--기능설정-->
                <li class="tab_content">
                    <div class="tab_wr">
                        <h2>게시판 기능 설정</h2>
                        <table>
                        <tbody>
                        <tr>
                            <th scope="row"><label for="bo_count_modify">원글 수정 불가<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">댓글의 수가 설정 수 이상이면 원글을 수정할 수 없습니다. 0으로 설정하시면 댓글 수에 관계없이 수정할 수있습니다.</span>
                                </span>
                            </th>
                            <td>
                                댓글 <input type="text" name="countModify" id="bo_count_modify" value="${board.countModify}" required class="required numeric frm_input" size="3">개 이상 달리면 수정불가
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_count_modify" value="1" id="chk_grp_count_modify">
                                <label for="chk_grp_count_modify">그룹적용</label>
                                <input type="checkbox" name="chk_all_count_modify" value="1" id="chk_all_count_modify">
                                <label for="chk_all_count_modify">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_count_delete">원글 삭제 불가<strong class="sound_only">필수</strong></label></th>
                            <td>
                                댓글 <input type="text" name="countDelete" id="bo_count_delete" value="${board.countDelete}" required class="required numeric frm_input" size="3">개 이상 달리면 삭제불가
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_count_delete" value="1" id="chk_grp_count_delete">
                                <label for="chk_grp_count_delete">그룹적용</label>
                                <input type="checkbox" name="chk_all_count_delete" value="1" id="chk_all_count_delete">
                                <label for="chk_all_count_delete">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_sideview">글쓴이 사이드뷰</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">글쓴이 클릭시 나오는 레이어 메뉴</span>
                                </span>
                            </th>
                            <td>
                                <input type="checkbox" name="useSideview" value="1" id="bo_use_sideview" <c:if test="${board.useSideview eq 1}">checked</c:if>  >
                               	 사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grop_use_sideview" value="1" id="chk_grp_use_sideview">
                                <label for="chk_grp_use_sideview">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_sideview" value="1" id="chk_all_use_sideview">
                                <label for="chk_all_use_sideview">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_secret">비밀글 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">"체크박스"는 글작성시 비밀글 체크가 가능합니다. <br>"무조건"은 작성되는 모든글을 비밀글로 작성합니다. (관리자는 체크박스로 출력합니다.)<br>스킨에 따라 적용되지 않을 수 있습니다.</span>
                                </span>
                            </th>
                            <td>
                                <select id="bo_use_secret" name="bo_use_secret">                                    
                                    <option value='0' <c:if test="${useSecret eq 0}">selected=selected</c:if> >사용하지 않음</option>
                                    <option value='1' <c:if test="${useSecret eq 1}">selected=selected</c:if> >체크박스</option>
                                    <option value='2' <c:if test="${useSecret eq 2}">selected=selected</c:if> >무조건</option>
                                </select>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_secret" value="1" id="chk_grp_use_secret">
                                <label for="chk_grp_use_secret">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_secret" value="1" id="chk_all_use_secret">
                                <label for="chk_all_use_secret">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_dhtml_editor">DHTML 에디터 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">글작성시 내용을 DHTML 에디터 기능으로 사용할 것인지 설정합니다. 스킨에 따라 적용되지 않을 수 있습니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="checkbox" name="useDhtmlEditor"  value="1" <c:if test="${board.useDhtmlEditor eq 1}">checked</c:if> id="bo_use_dhtml_editor">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_dhtml_editor" value="1" id="chk_grp_use_dhtml_editor">
                                <label for="chk_grp_use_dhtml_editor">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_dhtml_editor" value="1" id="chk_all_use_dhtml_editor">
                                <label for="chk_all_use_dhtml_editor">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_rss_view">RSS 보이기 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">비회원 글읽기가 가능하고 RSS 보이기 사용에 체크가 되어야만 RSS 지원을 합니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="checkbox" name="useRssView" value="1" <c:if test="${board.useRssView eq 1}">checked</c:if> id="bo_use_rss_view">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_rss_view" value="1" id="chk_grp_use_rss_view">
                                <label for="chk_grp_use_rss_view">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_rss_view" value="1" id="chk_all_use_rss_view">
                                <label for="chk_all_use_rss_view">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_good">추천 사용</label></th>
                            <td>
                                <input type="checkbox" name="useGood" value="1" <c:if test="${board.useGood eq 1}">checked</c:if> id="bo_use_good">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_good" value="1" id="chk_grp_use_good">
                                <label for="chk_grp_use_good">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_good" value="1" id="chk_all_use_good">
                                <label for="chk_all_use_good">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_nogood">비추천 사용</label></th>
                            <td>
                                <input type="checkbox" name="useNogood" value="1" <c:if test="${board.useNogood eq 1}">checked</c:if> id="bo_use_nogood">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_nogood" value="1" id="chk_grp_use_nogood">
                                <label for="chk_grp_use_nogood">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_nogood" value="1" id="chk_all_use_nogood">
                                <label for="chk_all_use_nogood">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_name">이름(실명) 사용</label></th>
                            <td>
                                <input type="checkbox" name="bo_use_name" value="1" <c:if test="${board.useName eq 1}">checked</c:if> id="bo_use_name">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_name" value="1" id="chk_grp_use_name">
                                <label for="chk_grp_use_name">그룹적용</label>

                                <input type="checkbox" name="chk_all_use_name" value="1" id="chk_all_use_name">
                                <label for="chk_all_use_name">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_signature">서명보이기 사용</label></th>
                            <td>
                                <input type="checkbox" name="useSignature" value="1" <c:if test="${board.useSignature eq 1}">checked</c:if> id="bo_use_signature">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_signature" value="1" id="chk_grp_use_signature">
                                <label for="chk_grp_use_signature">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_signature" value="1" id="chk_all_use_signature">
                                <label for="chk_all_use_signature">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_ip_view">IP 보이기 사용</label></th>
                            <td>
                                <input type="checkbox" name="useIpView" <c:if test="${board.useIpView eq 1}">checked</c:if> value="1" id="bo_use_ip_view">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_ip_view" value="1" id="chk_grp_use_ip_view">
                                <label for="chk_grp_use_ip_view">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_ip_view" value="1" id="chk_all_use_ip_view">
                                <label for="chk_all_use_ip_view">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_list_content">목록에서 내용 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">목록에서 게시판 제목외에 내용도 읽어와야 할 경우에 설정하는 옵션입니다. 기본은 사용하지 않습니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="checkbox" name="useListContent" <c:if test="${board.useListContent eq 1}">checked</c:if> value="1" id="bo_use_list_content">
                                사용 (사용시 속도가 느려질 수 있습니다.)
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_list_content" value="1" id="chk_grp_use_list_content">
                                <label for="chk_grp_use_list_content">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_list_content" value="1" id="chk_all_use_list_content">
                                <label for="chk_all_use_list_content">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_list_file">목록에서 파일 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">목록에서 게시판 첨부파일을 읽어와야 할 경우에 설정하는 옵션입니다. 기본은 사용하지 않습니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="checkbox" name="useListFile" <c:if test="${board.useListFile eq 1}">checked</c:if> value="1" id="bo_use_list_file">
                                사용 (사용시 속도가 느려질 수 있습니다.)
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_use_list_file" value="1" id="chk_grp_use_list_file">
                                <label for="chk_grp_use_list_file">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_list_file" value="1" id="chk_all_use_list_file">
                                <label for="chk_all_use_list_file">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_list_view">전체목록보이기 사용</label></th>
                            <td>
                                <input type="checkbox" name="useListView" <c:if test="${board.useListView eq 1 }">checked</c:if> value="1" id="bo_use_list_view">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_list_view" value="1" id="chk_grp_use_list_view">
                                <label for="chk_grp_use_list_view">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_list_view" value="1" id="chk_all_use_list_view">
                                <label for="chk_all_use_list_view">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_email">메일발송 사용</label></th>
                            <td>
                                <input type="checkbox" name="useEmail" value="1"  <c:if test="${board.useEmail eq 1 }">checked</c:if>id="bo_use_email">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_email" value="1" id="chk_grp_use_email">
                                <label for="chk_grp_use_email">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_email" value="1" id="chk_all_use_email">
                                <label for="chk_all_use_email">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_cert">본인확인 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">본인확인 여부에 따라 게시물을 조회 할 수 있도록 합니다.</span>
                                </span>
                            </th>
                            <td>
                                <select id="bo_use_cert" name="useCert">
                                    <option value="" <c:if test="${empty board.useCert || board.useCert eq 0 }">selected='selected'</c:if> >사용안함</option>
                                	<c:if test="${config.certUse eq 1}">
                                		<option value="cert" <c:if test="${board.useCert eq 'cert'}">selected='selected'</c:if>>본인확인된 회원전체</option>
                                		<option value="adult" <c:if test="${board.useCert eq 'adult'}">selected='selected'</c:if> >본인확인된 성인회원만</option>
                                		<option value="hp-cert" <c:if test="${board.useCert eq 'hp-cert'}">selected='selected'</c:if>>휴대폰 본인확인된 회원전체</option>
                                		<option value="hp-adult" <c:if test="${board.useCert eq 'hp-adult'}">selected='selected'</c:if>>휴대폰 본인확인된 성인회원만</option>
                                	</c:if>
                                </select>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_cert" value="1" id="chk_grp_use_cert">
                                <label for="chk_grp_use_cert">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_cert" value="1" id="chk_all_use_cert">
                                <label for="chk_all_use_cert">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_upload_count">파일 업로드 개수<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">게시물 한건당 업로드 할 수 있는 파일의 최대 개수 (0 은 파일첨부 사용하지 않음)</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="uploadCount" id="bo_upload_count" value="${board.uploadCount }" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_upload_count" value="1" id="chk_grp_upload_count">
                                <label for="chk_grp_upload_count">그룹적용</label>
                                <input type="checkbox" name="chk_all_upload_count" value="1" id="chk_all_upload_count">
                                <label for="chk_all_upload_count">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_upload_size">파일 업로드 용량<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">최대 1024M 이하 업로드 가능, 1 MB = 1,048,576 bytes</span>
                                </span>
                            </th>
                            <td>
                                업로드 파일 한개당 <input type="text" name="uploadSize" id="bo_upload_size" value="${board.uploadSize}" required class="required numeric frm_input"  size="10"> bytes 이하
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_upload_size" value="1" id="chk_grp_upload_size">
                                <label for="chk_grp_upload_size">그룹적용</label>
                                <input type="checkbox" name="chk_all_upload_size" value="1" id="chk_all_upload_size">
                                <label for="chk_all_upload_size">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_file_content">파일 설명 사용</label></th>
                            <td>
                                <input type="checkbox" name="useFileContent" value="1" <c:if test="${board.useFileContent eq 1}">checked</c:if> id="bo_use_file_content">사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_file_content" value="1" id="chk_grp_use_file_content">
                                <label for="chk_grp_use_file_content">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_file_content" value="1" id="chk_all_use_file_content">
                                <label for="chk_all_use_file_content">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_write_min">최소 글수 제한</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">글 입력시 최소 글자수를 설정. 0을 입력하거나 최고관리자, DHTML 에디터 사용시에는 검사하지 않음</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="writeMin" id="bo_write_min" value="${board.writeMin}" class="numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_write_min" value="1" id="chk_grp_write_min">
                                <label for="chk_grp_write_min">그룹적용</label>
                                <input type="checkbox" name="chk_all_write_min" value="1" id="chk_all_write_min">
                                <label for="chk_all_write_min">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_write_max">최대 글수 제한</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">글 입력시 최대 글자수를 설정. 0을 입력하거나 최고관리자, DHTML 에디터 사용시에는 검사하지 않음</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="writeMax" id="bo_write_max" value="${board.writeMax}" class="numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_write_max" value="1" id="chk_grp_write_max">
                                <label for="chk_grp_write_max">그룹적용</label>
                                <input type="checkbox" name="chk_all_write_max" value="1" id="chk_all_write_max">
                                <label for="chk_all_write_max">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_comment_min">최소 댓글수 제한</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">댓글 입력시 최소 글자수를 설정. 0을 입력하면 검사하지 않음</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="commentMin" id="bo_comment_min" value="${board.commentMin}" class="numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_comment_min" value="1" id="chk_grp_comment_min">
                                <label for="chk_grp_comment_min">그룹적용</label>
                                <input type="checkbox" name="chk_all_comment_min" value="1" id="chk_all_comment_min">
                                <label for="chk_all_comment_min">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_comment_max">최대 댓글수 제한</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">댓글 입력시 최소 글자수를 설정. 0을 입력하면 검사하지 않음</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="bo_comment_max" id="bo_comment_max" value="${board.commentMax}" class="numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_comment_max" value="1" id="chk_grp_comment_max">
                                <label for="chk_grp_comment_max">그룹적용</label>
                                <input type="checkbox" name="chk_all_comment_max" value="1" id="chk_all_comment_max">
                                <label for="chk_all_comment_max">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_sns">SNS 사용</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">사용에 체크하시면 소셜네트워크서비스(SNS)에 글을 퍼가거나 댓글을 동시에 등록할수 있습니다.<br>기본환경설정의 SNS 설정을 하셔야 사용이 가능합니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="checkbox" name="bo_use_sns" value="1" <c:if test="${board.useSns eq 1 }">checked</c:if> id="bo_use_sns">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_sns" value="1" id="chk_grp_use_sns">
                                <label for="chk_grp_use_sns">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_sns" value="1" id="chk_all_use_sns">
                                <label for="chk_all_use_sns">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_use_search">전체 검색 사용</label></th>
                            <td>
                                <input type="checkbox" name="useSearch" value="1" <c:if test="${board.useSearch eq 1}">checked</c:if> id="bo_use_search">
                                사용
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_use_search" value="1" id="chk_grp_use_search">
                                <label for="chk_grp_use_search">그룹적용</label>
                                <input type="checkbox" name="chk_all_use_search" value="1" id="chk_all_use_search">
                                <label for="chk_all_use_search">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_order">출력 순서</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">숫자가 낮은 게시판 부터 메뉴나 검색시 우선 출력합니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="order" id="bo_order" value="${board.order}" class="frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_order" value="1" id="chk_grp_order">
                                <label for="chk_grp_order">그룹적용</label>
                                <input type="checkbox" name="chk_all_order" value="1" id="chk_all_order">
                                <label for="chk_all_order">전체적용</label>
                            </td>
                        </tr>
                        </tbody>
                        
                        </table>
                    </div>
                </li>

                <!--게시판 디자인/양식-->
                <li class="tab_content">
                    <div class="tab_wr">
                        <h2>게시판 디자인/양식</h2>
                        <table>
                        <tbody>
                            <tr>
                            <th scope="row"><label for="bo_skin">스킨 디렉토리<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <select id="skin" name="skin">
                                    <option value="basic" selected="selected">basic</option>
                                </select>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_skin" value="1" id="chk_grp_skin">
                                <label for="chk_grp_skin">그룹적용</label>
                                <input type="checkbox" name="chk_all_skin" value="1" id="chk_all_skin">
                                <label for="chk_all_skin">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_skin">모바일 스킨 디렉토리<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <select id="mobileSkin" name="mobileSkin">
                                    <option value="basic" selected="selected">basic</option>
                                </select>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_mobile_skin" value="1" id="chk_grp_mobile_skin">
                                <label for="chk_grp_mobile_skin">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_skin" value="1" id="chk_all_mobile_skin">
                                <label for="chk_all_mobile_skin">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_include_head">상단 파일 경로</label></th>
                            <td>
                                <input type="text" name="includeHead" id="bo_include_head" value="${board.includeHead}" class="frm_input" size="50">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_include_head" value="1" id="chk_grp_include_head">
                                <label for="chk_grp_include_head">그룹적용</label>
                                <input type="checkbox" name="chk_all_include_head" value="1" id="chk_all_include_head">
                                <label for="chk_all_include_head">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_include_tail">하단 파일 경로</label></th>
                            <td>
                                <input type="text" name="includeTail" id="bo_include_tail" value="${board.includeTail}" class="frm_input" size="50">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_include_tail" value="1" id="chk_grp_include_tail">
                                <label for="chk_grp_include_tail">그룹적용</label>
                                <input type="checkbox" name="chk_all_include_tail" value="1" id="chk_all_include_tail">
                                <label for="chk_all_include_tail">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_content_head">상단 내용</label></th>
                            <td>
                                ${editorContentHead}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_content_head" value="1" id="chk_grp_content_head">
                                <label for="chk_grp_content_head">그룹적용</label>
                                <input type="checkbox" name="chk_all_content_head" value="1" id="chk_all_content_head">
                                <label for="chk_all_content_head">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_content_tail">하단 내용</label></th>
                            <td>
                                ${editorContentTail}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_content_tail" value="1" id="chk_grp_content_tail">
                                <label for="chk_grp_content_tail">그룹적용</label>
                                <input type="checkbox" name="chk_all_content_tail" value="1" id="chk_all_content_tail">
                                <label for="chk_all_content_tail">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_content_head">모바일 상단 내용</label></th>
                            <td>
                                ${editormobileContentHead}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_mobile_content_head" value="1" id="chk_grp_mobile_content_head">
                                <label for="chk_grp_mobile_content_head">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_content_head" value="1" id="chk_all_mobile_content_head">
                                <label for="chk_all_mobile_content_head">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_content_tail">모바일 하단 내용</label></th>
                            <td>
                               ${editorMobileContentTail}
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_mobile_content_tail" value="1" id="chk_grp_mobile_content_tail">
                                <label for="chk_grp_mobile_content_tail">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_content_tail" value="1" id="chk_all_mobile_content_tail">
                                <label for="chk_all_mobile_content_tail">전체적용</label>
                            </td>
                        </tr>
                         <tr>
                            <th scope="row"><label for="bo_insert_content">글쓰기 기본 내용</label></th>
                            <td>
                                <textarea id="bo_insert_content" name="insertContent" rows="5">${board.insertContent}</textarea>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_insert_content" value="1" id="chk_grp_insert_content">
                                <label for="chk_grp_insert_content">그룹적용</label>
                                <input type="checkbox" name="chk_all_insert_content" value="1" id="chk_all_insert_content">
                                <label for="chk_all_insert_content">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_subject_len">제목 길이<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">목록에서의 제목 글자수. 잘리는 글은 … 로 표시</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="subjectLen" id="bo_subject_len" value="${board.subjectLen}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_subject_len" value="1" id="chk_grp_subject_len">
                                <label for="chk_grp_subject_len">그룹적용</label>
                                <input type="checkbox" name="chk_all_subject_len" value="1" id="chk_all_subject_len">
                                <label for="chk_all_subject_len">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_subject_len">모바일 제목 길이<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">목록에서의 제목 글자수. 잘리는 글은 … 로 표시</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="mobileSubjectLen" id="bo_mobile_subject_len" value="${board.mobileSubjectLen}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_mobile_subject_len" value="1" id="chk_grp_mobile_subject_len">
                                <label for="chk_grp_mobile_subject_len">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_subject_len" value="1" id="chk_all_mobile_subject_len">
                                <label for="chk_all_mobile_subject_len">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_page_rows">페이지당 목록 수<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <input type="text" name="pageRows" id="bo_page_rows" value="${board.pageRows}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_page_rows" value="1" id="chk_grp_page_rows">
                                <label for="chk_grp_page_rows">그룹적용</label>
                                <input type="checkbox" name="chk_all_page_rows" value="1" id="chk_all_page_rows">
                                <label for="chk_all_page_rows">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_page_rows">모바일 페이지당 목록 수<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <input type="text" name="mobilePageRows" id="bo_mobile_page_rows" value="${board.mobilePageRows}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_mobile_page_rows" value="1" id="chk_grp_mobile_page_rows">
                                <label for="chk_grp_mobile_page_rows">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_page_rows" value="1" id="chk_all_mobile_page_rows">
                                <label for="chk_all_mobile_page_rows">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_gallery_cols">갤러리 이미지 수<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">갤러리 형식의 게시판 목록에서 이미지를 한줄에 몇장씩 보여 줄 것인지를 설정하는 값</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="galleryCols" id="bo_gallery_cols" value="${board.galleryCols }" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_gallery_cols" value="1" id="chk_grp_gallery_cols">
                                <label for="chk_grp_gallery_cols">그룹적용</label>
                                <input type="checkbox" name="chk_all_gallery_cols" value="1" id="chk_all_gallery_cols">
                                <label for="chk_all_gallery_cols">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_gallery_width">갤러리 이미지 폭<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">갤러리 형식의 게시판 목록에서 썸네일 이미지의 폭을 설정하는 값</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="galleryWidth" id="bo_gallery_width" value="${board.galleryWidth}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_gallery_width" value="1" id="chk_grp_gallery_width">
                                <label for="chk_grp_gallery_width">그룹적용</label>
                                <input type="checkbox" name="chk_all_gallery_width" value="1" id="chk_all_gallery_width">
                                <label for="chk_all_gallery_width">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_gallery_height">갤러리 이미지 높이<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">갤러리 형식의 게시판 목록에서 썸네일 이미지의 높이를 설정하는 값</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="galleryHeight" id="bo_gallery_height" value="${board.galleryHeight}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_gallery_height" value="1" id="chk_grp_gallery_height">
                                <label for="chk_grp_gallery_height">그룹적용</label>
                                <input type="checkbox" name="chk_all_gallery_height" value="1" id="chk_all_gallery_height">
                                <label for="chk_all_gallery_height">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_gallery_width">모바일<br>갤러리 이미지 폭<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">모바일로 접속시 갤러리 형식의 게시판 목록에서 썸네일 이미지의 폭을 설정하는 값</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="mobileGalleryWidth" id="bo_mobile_gallery_width" value="${board.mobileGalleryWidth }" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_mobile_gallery_width" value="1" id="chk_grp_mobile_gallery_width">
                                <label for="chk_grp_mobile_gallery_width">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_gallery_width" value="1" id="chk_all_mobile_gallery_width">
                                <label for="chk_all_mobile_gallery_width">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_mobile_gallery_height">모바일<br>갤러리 이미지 높이<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">모바일로 접속시 갤러리 형식의 게시판 목록에서 썸네일 이미지의 높이를 설정하는 값</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="mobileGalleryHeight" id="bo_mobile_gallery_height" value="${board.mobileGalleryHeight}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_mobile_gallery_height" value="1" id="chk_grp_mobile_gallery_height">
                                <label for="chk_grp_mobile_gallery_height">그룹적용</label>
                                <input type="checkbox" name="chk_all_mobile_gallery_height" value="1" id="chk_all_mobile_gallery_height">
                                <label for="chk_all_mobile_gallery_height">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_table_width">게시판 폭<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">100 이하는 %</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="bo_table_width" id="bo_table_width" value="${board.tableWidth}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_grp_table_width" value="1" id="chk_grp_table_width">
                                <label for="chk_grp_table_width">그룹적용</label>
                                <input type="checkbox" name="chk_all_table_width" value="1" id="chk_all_table_width">
                                <label for="chk_all_table_width">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_image_width">이미지 폭 크기<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">게시판에서 출력되는 이미지의 폭 크기</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="imageWidth"  id="bo_image_width" value="${board.imageWidth}" required class="required numeric frm_input" size="4"> 픽셀
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_image_width" value="1" id="chk_grp_image_width">
                                <label for="chk_grp_image_width">그룹적용</label>
                                <input type="checkbox" name="chk_all_image_width" value="1" id="chk_all_image_width">
                                <label for="chk_all_image_width">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_new">새글 아이콘<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">글 입력후 new 이미지를 출력하는 시간. 0을 입력하시면 아이콘을 출력하지 않습니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="newIcon" id="bo_new" required value="${board.newIcon }" class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_new" value="1" id="chk_grp_new">
                                <label for="chk_grp_new">그룹적용</label>
                                <input type="checkbox" name="chk_all_new" value="1" id="chk_all_new">
                                <label for="chk_all_new">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_hot">인기글 아이콘<strong class="sound_only">필수</strong></label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">조회수가 설정값 이상이면 hot 이미지 출력. 0을 입력하시면 아이콘을 출력하지 않습니다.</span>
                                </span>
                            </th>
                            <td>
                                <input type="text" name="hotIcon" id="bo_hot" value="${board.hotIcon}" required class="required numeric frm_input" size="4">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_hot" value="1" id="chk_grp_hot">
                                <label for="chk_grp_hot">그룹적용</label>
                                <input type="checkbox" name="chk_all_hot" value="1" id="chk_all_hot">
                                <label for="chk_all_hot">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_reply_order">답변 달기</label></th>
                            <td>
                                <select id="bo_reply_order" name="bo_reply_order">
                                    <option value="1" <c:if test="${board.replyOrder eq 1}">selected='selected'</c:if> >나중에 쓴 답변 아래로 달기 (기본)
                                    <option value="0" <c:if test="${board.replyOrder eq 0}">selected='selected'</c:if>>나중에 쓴 답변 위로 달기
                                </select>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" id="chk_group_reply_order" name="chk_grp_reply_order" value="1">
                                <label for="chk_grp_reply_order">그룹적용</label>
                                <input type="checkbox" id="chk_all_reply_order" name="chk_all_reply_order" value="1">
                                <label for="chk_all_reply_order">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_sort_field">리스트 정렬 필드</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">리스트에서 기본으로 정렬에 사용할 필드를 선택합니다. "기본"으로 사용하지 않으시는 경우 속도가 느려질 수 있습니다</span>
                                </span>
                            </th>
                            <td>
                                <select id="bo_sort_field" name="sortField">
                                    <option value="" <c:if test="${empty board.sortField }">selected='selected'</c:if>>wr_num, wr_reply : 기본</option>
                                    <option value="wr_datetime asc" <c:if test="${board.sortField eq 'wr_datetime asc'}">selected='selected'</c:if>  >wr_datetime asc : 날짜 이전것 부터</option>
                                    <option value="wr_datetime desc" <c:if test="${board.sortField eq 'wr_datetime desc'}">selected='selected'</c:if>>wr_datetime desc : 날짜 최근것 부터</option>
                                    <option value="wr_hit asc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_hit asc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_hit asc : 조회수 낮은것 부터</option>
                                    <option value="wr_hit desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_hit desc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_hit desc : 조회수 높은것 부터</option>
                                    <option value="wr_last asc" <c:if test="${board.sortField eq 'wr_last asc'}">selected='selected'</c:if>>wr_last asc : 최근글 이전것 부터</option>
                                    <option value="wr_last desc" <c:if test="${board.sortField eq 'wr_last desc'}">selected='selected'</c:if>>wr_last desc : 최근글 최근것 부터</option>
                                    <option value="wr_comment asc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_comment asc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_comment asc : 댓글수 낮은것 부터</option>
                                    <option value="wr_comment desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_comment desc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_comment desc : 댓글수 높은것 부터</option>
                                    <option value="wr_good asc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_good asc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_good asc : 추천수 낮은것 부터</option>
                                    <option value="wr_good desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_good desc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_good desc : 추천수 높은것 부터</option>
                                    <option value="wr_nogood asc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_nogood asc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_nogood asc : 비추천수 낮은것 부터</option>
                                    <option value="wr_nogood desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_nogood desc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_nogood desc : 비추천수 높은것 부터</option>
                                    <option value="wr_subject asc, wr_num, wr_reply"  <c:if test="${board.sortField eq 'wr_subject asc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_subject asc : 제목 오름차순</option>
                                    <option value="wr_subject desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_subject desc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_subject desc : 제목 내림차순</option>
                                    <option value="wr_name asc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_name asc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_name asc : 글쓴이 오름차순</option>
                                    <option value="wr_name desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_name desc, wr_num, wr_reply'}">selected='selected'</c:if>>wr_name desc : 글쓴이 내림차순</option>
                                    <option value="ca_name asc, wr_num, wr_reply" <c:if test="${board.sortField eq 'wr_name desc, ca_name asc, wr_num, wr_reply'}">selected='selected'</c:if>>ca_name asc : 분류명 오름차순</option>
                                    <option value="ca_name desc, wr_num, wr_reply" <c:if test="${board.sortField eq 'ca_name desc, wr_num, wr_reply'}">selected='selected'</c:if>>ca_name desc : 분류명 내림차순</option>
                                </select>
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_sort_field" value="1" id="chk_grp_sort_field">
                                <label for="chk_grp_sort_field">그룹적용</label>
                                <input type="checkbox" name="chk_all_sort_field" value="1" id="chk_all_sort_field">
                                <label for="chk_all_sort_field">전체적용</label>
                            </td>
                        </tbody>
                        
                        </table>
                    </div>
                    <div class="btn_confirm">
                        <button type="button" class="btn_02 btn" class="get_theme_galc">테마 이미지설정 가져오기</button>
                    </div>
                </li>

                <!--게시판 포인트 설정-->
                <li class="tab_content">
                    <div class="tab_wr">
                        <h2>게시판 포인트 설정</h2>
                        <table>
                        <tbody>
                        <tr>
                            <th scope="row"><label for="chk_grp_point">기본값으로 설정</label>
                                <span class="tooltip">
                                    <button type="button" class="tooltip_btn"><span class="sound_only">도움말</span></button>
                                    <span class="tooltip_area">환경설정에 입력된 포인트로 설정</span>
                                </span>
                            </th>
                            <td colspan="2">
                                <input type="checkbox" name="chk_group_point" id="chk_grp_point" onclick="set_point(this.form)">
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_read_point">글읽기 포인트<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <input type="text" name="readPoint" id="bo_read_point" value="${board.readPoint}" required class="required frm_input" size="5">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_read_point" value="1" id="chk_grp_read_point">
                                <label for="chk_grp_read_point">그룹적용</label>
                                <input type="checkbox" name="chk_all_read_point" value="1" id="chk_all_read_point">
                                <label for="chk_all_read_point">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_write_point">글쓰기 포인트<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <input type="text" name="writePoint" id="bo_write_point" value="${board.writePoint}" required class="required frm_input" size="5">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_write_point" value="1" id="chk_grp_write_point">
                                <label for="chk_grp_write_point">그룹적용</label>
                                <input type="checkbox" name="chk_all_write_point" value="1" id="chk_all_write_point">
                                <label for="chk_all_write_point">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_comment_point">댓글쓰기 포인트<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <input type="text" name="commentPoint" id="bo_comment_point" value="${board.commentPoint}" required class="required frm_input" size="5">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_comment_point" value="1" id="chk_grp_comment_point">
                                <label for="chk_grp_comment_point">그룹적용</label>
                                <input type="checkbox" name="chk_all_comment_point" value="1" id="chk_all_comment_point">
                                <label for="chk_all_comment_point">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><label for="bo_download_point">다운로드 포인트<strong class="sound_only">필수</strong></label></th>
                            <td>
                                <input type="text" name="downloadPoint" id="bo_download_point" value="${board.downloadPoint}" required class="required frm_input" size="5">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_download_point" value="1" id="chk_grp_download_point">
                                <label for="chk_grp_download_point">그룹적용</label>
                                <input type="checkbox" name="chk_all_download_point" value="1" id="chk_all_download_point">
                                <label for="chk_all_download_point">전체적용</label>
                            </td>
                        </tr>
                        </tbody>
                        
                        </table>
                    </div>
                    
                </li>

                <!--여분필드 설정-->
                <li class="tab_content">
                    <div class="tab_wr">
                        <h2>게시판 여분필드 설정</h2>
                        <table>
                        <tr>
                            <th scope="row">여분필드1</th>
                            <td class="td_extra">
                                <label for="bo_1_subj">여분필드 1 제목</label>
                                <input type="text" name="extra1Key" id="bo_1_subj" value="${board.extra1Key}" class="frm_input">
                                <label for="bo_1">여분필드 1 값</label>
                                <input type="text" name="extra1Value" id="bo_1" value="${board.extra1Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_1" id="chk_grp_1">
                                <label for="chk_grp_1">그룹적용</label>
                                <input type="checkbox" name="chk_all_1" id="chk_all_1">
                                <label for="chk_all_1">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드2</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 2 제목</label>
                                <input type="text" name="extra2Key" id="bo_2_subj" value="${board.extra2Key}"class="frm_input">
                                <label for="bo_2">여분필드 2 값</label>
                                <input type="text" name="extra2Value"  id="bo_2" value="${board.extra2Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드3</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 3 제목</label>
                                <input type="text" name="extra3Key" id="bo_2_subj" value="${board.extra3Key}" class="frm_input">
                                <label for="bo_2">여분필드 3 값</label>
                                <input type="text" name="extra3Value"  id="bo_2" value="${board.extra3Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드4</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 4 제목</label>
                                <input type="text" name="extra4Key" id="bo_2_subj" value="${board.extra4Key}" class="frm_input">
                                <label for="bo_2">여분필드 4 값</label>
                                <input type="text" name="extra4Value"  id="bo_2" value="${board.extra4Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드5</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 5 제목</label>
                                <input type="text" name="extra5Key" id="bo_2_subj" value="${board.extra5Key}" class="frm_input">
                                <label for="bo_2">여분필드 5 값</label>
                                <input type="text" name="extra5Value"  id="bo_2" value="${board.extra5Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드6</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 6 제목</label>
                                <input type="text" name="extra6Key" id="bo_2_subj" value="${board.extra6Key}" class="frm_input">
                                <label for="bo_2">여분필드 6 값</label>
                                <input type="text" name="extra6Value"  id="bo_2" value="${board.extra6Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드7</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 7 제목</label>
                                <input type="text" name="extra7Key" id="bo_2_subj" value="${board.extra7Key}" class="frm_input">
                                <label for="bo_2">여분필드 7 값</label>
                                <input type="text" name="extra7Value"  id="bo_2" value="${board.extra7Value}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드8</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 8 제목</label>
                                <input type="text" name="extra8Key" id="bo_2_subj" value="${board.extra8Key}" class="frm_input">
                                <label for="bo_2">여분필드 8 값</label>
                                <input type="text" name="extra8Value"  id="bo_2" value="${board.extra8Key}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드9</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드 9 제목</label>
                                <input type="text" name="extra9Key" id="bo_2_subj" value="${board.extra9Key}" class="frm_input">
                                <label for="bo_2">여분필드 9 값</label>
                                <input type="text" name="extra9Value"  id="bo_2" value="${board.extra9Key}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">여분필드10</th>
                            <td class="td_extra">
                                <label for="bo_2_subj">여분필드10 제목</label>
                                <input type="text" name="extra9Key" id="bo_2_subj" value="${board.extra10Key}" class="frm_input">
                                <label for="bo_2">여분필드 10 값</label>
                                <input type="text" name="extra9Value"  id="bo_2"  value="${board.extra10Key}" class="frm_input">
                            </td>
                            <td class="td_grpset">
                                <input type="checkbox" name="chk_group_2" id="chk_grp_2">
                                <label for="chk_grp_2">그룹적용</label>
                                <input type="checkbox" name="chk_all_2" id="chk_all_2">
                                <label for="chk_all_2">전체적용</label>
                            </td>
                        </tr>
                        </table>
                    </div>
                </li>
            </ul>

            <div class="btn_fixed_top">
                <a href="#" class="btn_02 btn">게시판복사</a>
                <a href="#" class="btn_02 btn">게시판바로가기</a>
                <a href="#" class="btn_02 btn">게시판썸네일삭제</a>
				<c:if test="${type eq 'add' }">
                <input type="submit" value="추가" id="btn_submit" class="btn_submit btn" onclick="document.pressed=this.value">
                </c:if>
                <c:if test="${type eq 'update'}">
                <input type="submit" value="수정" id="btn_submit" class="btn_submit btn" onclick="document.pressed=this.value">
                </c:if>
            </div>
        </form>
        </div>
    </div>  
    
<script>
$(function(){
    $("#board_copy").click(function(){
        window.open(this.href, "win_board_copy", "left=10,top=10,width=500,height=400");
        return false;
    });

    $(".get_theme_galc").on("click", function() {
        if(!confirm("현재 테마의 게시판 이미지 설정을 적용하시겠습니까?"))
            return false;

        $.ajax({
            type: "POST",
            url: "./theme_config_load.php",
            cache: false,
            async: false,
            data: { type: "board" },
            dataType: "json",
            success: function(data) {
                if(data.error) {
                    alert(data.error);
                    return false;
                }

                var field = Array('galleryCols', 'galleryWidth', 'galleryHeight', 'mobileGalleryWidth', 'mobileGalleryHeight', 'imageWidth');
                //var field = Array('bo_gallery_cols', 'bo_gallery_width', 'bo_gallery_height', 'bo_mobile_gallery_width', 'bo_mobile_gallery_height', 'bo_image_width');
                var count = field.length;
                var key;

                for(i=0; i<count; i++) {
                    key = field[i];

                    if(data[key] != undefined && data[key] != "")
                        $("input[name="+key+"]").val(data[key]);
                }
            }
        });
    });
});
      
function board_copy(bo_table) {
    window.open("./board_copy.php?bo_table="+bo_table, "BoardCopy", "left=10,top=10,width=500,height=200");
}

function set_point(f) {
    if (f.chk_group_point.checked) {
        f.readPoint.value = ${config.readPoint};
        f.writePoint.value = ${config.writePoint};
        f.commentPoint.value = ${config.commentPoint};
        f.downloadPoint.value = ${config.downloadPoint};
    } else {
        f.readPoint.value     = f.bo_read_point.defaultValue;
        f.writePoint.value    = f.bo_write_point.defaultValue;
        f.commentPoint.value  = f.bo_comment_point.defaultValue;
        f.downloadPoint.value = f.bo_download_point.defaultValue;
    }
}

function fboardform_submit(f)
{
/*     <?php echo get_editor_js("bo_content_head"); ?>
    <?php echo get_editor_js("bo_content_tail"); ?>
    <?php echo get_editor_js("bo_mobile_content_head"); ?>
    <?php echo get_editor_js("bo_mobile_content_tail"); ?> */

    if (parseInt(f.bo_count_modify.value) < 0) {
        alert("원글 수정 불가 댓글수는 0 이상 입력하셔야 합니다.");
        f.bo_count_modify.focus();
        return false;
    }

    if (parseInt(f.bo_count_delete.value) < 1) {
        alert("원글 삭제 불가 댓글수는 1 이상 입력하셔야 합니다.");
        f.bo_count_delete.focus();
        return false;
    }
        
    if(document.pressed == '추가') {
    	
	}else if (document.pressed == '수정') {
		
		$("input:hidden[name=_method]").val("PUT");
		
	}
    
    

    return true;
}
</script>    






    
 <jsp:include page="../main/tail.jsp"></jsp:include>    