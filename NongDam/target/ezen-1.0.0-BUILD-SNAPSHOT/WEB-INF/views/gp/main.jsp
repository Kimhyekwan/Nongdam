<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<html lang="ko" data-bs-theme="light">
<head>
    <!-- UTF-8 사용-->
    <meta charset="UTF-8">
    <!-- 기본 화면 보기 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <!-- bootstrap 5.3.2 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>

    <!--제이쿼리-->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    
    <!-- ckEditor 5 -->
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>

    <!-- fontAwesome -->
    <script src="https://kit.fontawesome.com/f34a67d667.js" crossorigin="anonymous"></script>
    
    <!-- 스타일시트 -->
    <link rel="stylesheet" href="${contextPath }/resources/common/css/style.css">
    <!-- 기본js -->
    <script type="text/javascript" src="${contextPath }/resources/common/js/common.js"></script>
    
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <title>농담 | 농업 정보 커뮤니티</title>
    
    <script type="text/javascript">
	    
	    //페이지 번호 클릭 할때 이동하기
	  $(document).ready(function () {
	        $(".page-link").on("click", function (e) {
	            e.preventDefault();  // 기본 이벤트 막기
	            
	            var page = $(this).attr("href");  // 페이지 번호 가져오기
	            $("#page").val(page);  // 페이지 값 폼에 설정
	            $("#pageFrm").submit();  // 폼 서브밋
	        });
	        
	        $("#moving").on("click",function(e){
		         e.preventDefault();
		         pageFrm.attr("action","${contextPath}/gp/write");
		         pageFrm.attr("method","get");
		         pageFrm.submit();
		     });
	        
	        var bannerTitle = "공동구매 게시판";
	        var bannerText1 = "다양한 제품들을 많은 사람들과 함께 싼 가격에 구매해보세요";
	        var bannerText2 = "공동구매 게시글들은 문의 혹은 별도의 연락을 받아 게시글을 올려드리고 있습니다.";
	        
	        $("#banner-title").text(bannerTitle);
	        $("#banner-content1").text(bannerText1);
	        $("#banner-content2").text(bannerText2);
	  
	    });
	
	</script>
    
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	
	
	<!-- 여기에 컨텐츠를 추가 -->
	<!-- 태그 탭 -->
    <nav class="container mt-5">
        <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <!--  class="nav-link(기본) active(선택된 값) text-body(텍스트 색 지정)"-->
            <!-- 필요한 경우 button을 a 태그로 바꾸어도 괜찮습니다. (단, a태그로 바꾸는 경우 type=button 삭제하세요 )-->
            <button class="nav-link text-body active" data-bs-toggle="tab" type="button" role="tab" aria-controls="nav-all" aria-selected="true">전체</button>
            <button class="nav-link text-body" data-bs-toggle="tab" type="button" role="tab" aria-controls="nav-progress" aria-selected="false">진행</button>
            <button class="nav-link text-body" data-bs-toggle="tab" type="button" role="tab" aria-controls="nav-complet" aria-selected="false">완료</button>
        </div>
    </nav>
    <!--카드형식 div container-->
    <!-- 윗부분 -->
    <div class="container mt-5 mb-3 d-flex flex-wrap justify-content-between">
    	
        <div>
        	<a class="text-decoration-none" href="${contextPath}/gp/write">
            <button class="btn btn-secondary">글쓰기</button>
            </a>
        </div>
        <div style="width: 20rem;">
			<form method="get">
				<div class="input-group">

					<select class="btn btn-outline-secondary dropdown-toggle"
						name="type">
						<option class="dropdown-item" value="progress">진행</option>
						<option class="dropdown-item" value="complet">완료</option>
					</select> <input type="text" name="keyword" class="form-control"
						value="${cri.keyword }" placeholder="검색">
					<button class="btn btn-secondary" type="submit">검색</button>

				</div>
			</form>
		</div>
    </div>
    <!-- 아랫부분 -->
    <div class="container mt-2 mb-5">
        <div class="border rounded-2 p-4 container">
            <p class="d-flex flex-wrap">
                <span class="d-inline-block me-auto fs-5 fw-bolder">다른 사람들과 함께 싼 가격에 제품을 구매해보세요.</span>
            </p>
            <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 ">
                <!-- 카드 하나 시작 -->
                <c:forEach var="li" items="${li }">
                <div class="col pb-4">
                    <a class="text-decoration-none" href="${contextPath}/gp/detail?gp_idx=${li.gp_idx}">
                        <div class="card">
                            <img src="..." class="border-bottom rounded-2 bg-light w-100 object-fit-cover" height="200">
                            <div class="card-body">
                                <h5 class="card-title title-overflow-3">
                                    ${li.gp_title}
                                </h5>
                                <p class="card-text">
                                    <span class="title-overflow-1">시작일 <fmt:formatDate value="${li.gp_date_start }" pattern="YYYY-MM-dd "/></span>
                                    <span class="title-overflow-1">마감일 <fmt:formatDate value="${li.gp_date_last }" pattern="YYYY-MM-dd "/></span>
                                </p>
                                <!-- 아래 div 태그는 공동구매에서만 사용-->
                                <div class="text-end fst-italic">{타이머위치}</div>
                            </div>
                        </div>
                    </a>
                </div>
                </c:forEach>
                <!-- 카드 하나 끝 -->
                


            </div>
            <!-- 카드 게시판 영역 끝 -->
            
            <!-- 페이징 -->
            <div class="mt-3">			
				<nav class="d-flex justify-content-center">
					<ul class="pagination">
						<c:if test="${pageCre.prev }">
							<li class="page-item disabled"><a
								class="page-link text-secondary" href="${pageCre.startPage-1}">&laquo;
							</a></li>
						</c:if>
						<c:forEach var="pageNum" begin="${pageCre.startPage }"
							end="${pageCre.endPage }">
							<li class="page-item  ${pageCre.cri.page==pageNum? 'active text-secondary' :'' }">
								<a class="page-link   ${pageCre.cri.page==pageNum? 'bg-secondary border-secondary':'' }" href="${pageNum}">${pageNum }</a>
							</li>
						</c:forEach>


						<c:if test="${pageCre.next }">
							<li class="page-item">
							<a class="page-link text-secondary" href="${pageCre.endPage+1}">&raquo;</a></li>
						</c:if>


					</ul>
				</nav>
				
			</div>
			<form id="pageFrm" action="${contextPath}/gp/main" method="get">
				<input type="hidden" id="user_idx" name="user_idx" value="1"/>
				<input type="hidden" id="page" name="page" value="${pageCre.cri.page }"/>
				<input type="hidden" id="perPageNum" name="perPageNum" value="${pageCre.cri.perPageNum }"/>
               	<input type="hidden" name="type" value="${ pageCre.cri.type}"/>
               	<input type="hidden" name="keyword" value="${pageCre.cri.keyword}"/>
			</form>
            <!-- 페이징 끝 -->
        </div>
    </div>
    <!-- ============================================== -->
		
	
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>