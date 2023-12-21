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
    
    <!-- 다음(카카오) 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
    <meta name="농담" content="안녕하세요, 농업 정보 커뮤니티 농담입니다."/>
    
    <!-- 파비콘 -->
    <link rel="icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="${contextPath }/resources/image/common/favicon.ico"/>
    
    <script type="text/javascript">
    $(document).ready(function () {
    	$("#cancelPay").on("click", function() {
			let result = confirm('해당 공동구매 게시글을 삭제하시겠습니까?');
			if(result == false){
				return;
			} else {
   				 jQuery.ajax({
   				      // 예: http://www.myservice.com/payments/cancel
   				      "url": "{http://www.myservice.com/payments/cancel}", 
   				      "type": "POST",
   				      "contentType": "application/json",
   				      "data": JSON.stringify({
   				        "merchant_uid": "${gpUser.gp_uid}", // 예: ORD20180131-0000011
   				        "cancel_request_amount": "${gpUser.gp_total}", // 환불금액
   				        "reason": "테스트 결제 환불" // 환불사유
   				        // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
   				        "refund_holder": "홍길동", 
   				        // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
   				        "refund_bank": "88" 
   				        // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
   				        "refund_account": "56211105948400" 
   				      }),
   				      "dataType": "json"
   				    }).done(function(result) { // 환불 성공시 로직 
   				      alert("환불 성공");
   				    }).fail(function(error) { // 환불 실패시 로직
   				      alert("환불 실패");
   				    });
   				$("#submitForm").attr("action", "${contextPath}/myPage/deletePayByIdx");
   			}
    	});
    	
    	function execDaumPostcode() {
            new daum.Postcode( {
              oncomplete: function( data ) {
                document.getElementById( 'gp_zipcode' ).value = data.zonecode;
                document.getElementById( 'gp_zipcode2' ).value = data.address;
                document.getElementById( 'gp_zipcode3' ).focus();
              }
            } ).open();
          }
          function execDaumPostcodeReset() {
            document.getElementById( 'gp_zipcode' ).value = null;
            document.getElementById( 'gp_zipcode2' ).value = null;
            document.getElementById( 'gp_zipcode3' ).value = null;
          }
    });
	</script>
    
    <title>농담 | 농업 정보 커뮤니티</title>
    
</head>
<body>

	<jsp:include page="../common/header.jsp"/>
	<jsp:include page="../common/banner.jsp"/>
	<div class = "container">
			
	<!-- =============================================== -->
                        <!-- 공동구매 -->
                        <div class="pb-3 border-bottom">
                        	
							         
                            <h6 class="mt-4 mb-4 ps-1"><i class="fa-solid fa-tag"></i> 공동구매 신청 내역</h6>
                            <!-- 맨 윗줄 -->
                            	<c:forEach var="gpUserList" items="${gpUserList }">
                            	
                            		<c:set var="currentDate" value="<%= new java.util.Date() %>"/>
									<c:set var="startDate" value="${gp1.gp_date_start }"/>
									<c:set var="endDate" value="${gp1.gp_date_last }"/>
									
									<c:set var="diffMillis" value="${startDate.time - currentDate.time}"/>
									<c:set var="diffDays" value="${diffMillis / (24 * 60 * 60 * 1000)}"/>
									                       
									<c:set var="diffMillisEnd" value="${endDate.time - currentDate.time}"/>
									<c:set var="diffDaysEnd" value="${diffMillisEnd / (24 * 60 * 60 * 1000)}"/>
                            	
			                            <div class="d-flex flex-row flex-wrap pt-2 pb-2 border ">
			                                <div class="d-none d-lg-block col-1 text-center">
			                                    #
			                                </div>
			                                <div class="col-12 col-lg-5 text-center">
			                                    상품
			                                </div>
			                                <div class="d-none d-lg-block col-lg-3 text-center">
			                                    일자
			                                </div>
			                                <div class="d-none d-lg-block col-lg-3 text-center">
			                                    상세
			                                </div>
			                            </div>
			                            <!-- 맨 윗줄 끝 -->
			                            <!-- 목록 하나 -->
					                            <div class="d-flex flex-row flex-wrap justify-content-center align-items-center pt-3 pb-3 border border-top-0 bg-body-tertiary">
					                                <div class="d-none d-lg-block col-1 text-center">
					                                    ${gpUserList.gp_uid }
					                                </div>
					                                <div class="col-12 col-lg-5">
					                                    <div class="d-flex gap-2 ms-3 me-3">
					                                        <img src="https://images.unsplash.com/photo-1528301721190-186c3bd85418?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D" 
					                                            class="bg-light object-fit-cover"
					                                            style="width: 50px; height: 50px;">
					                                        <div>
					                                            <a href="#" class="text-decoration-none text-body title-overflow-1">
												                        <!-- 마감일까지 남은 일수 표시 -->
												                        	<c:choose>
													                            <c:when test="${diffDaysEnd > 0}">
													                            	<div class="text-end fst-italic">
													                            		<span class="text-danger">
														                                    [거래중]
														                           		</span>
														                           	</div>
													                            </c:when>
													                            <c:when test="${diffDaysEnd < 0}">
														                            <div class="text-end fst-italic">
														                                <span class="text-muted">
														                                    [거래완료]
														                                </span>
														                            </div>
													                            </c:when>
													                        </c:choose>
					                                                <!-- 상품명 -->
					                                                <span></span>
					                                            </a>
					                                            <div class="text-muted">
					                                                <span>${gp_price }원</span>
					                                                <span>${gpUserList.gp_num }개</span>
					                                            </div>
					                                        </div>
					                                    </div>
					                                </div>
					                                <div class="col-6 col-lg-3 text-center">
					                                    ~ ${gp1.gp_date_last }
					                                </div>
					                            
					                                <div class="col-6 col-lg-3 text-center">
					                                    <button class="btn btn-sm btn-secondary">세부내역</button>
					                                    <button type="button" class="btn btn-sm btn-secondary" id="cancelPay">취소하기</button>
					                                </div>
					                            </div>
					                            <form method="get" id="submitForm">
					                            	<input type="hidden" id="gp_uid" name="gp_uid" value="${gpUserList.gp_uid }">	    
					                            </form>
			                            <!-- 목록 하나 끝 -->
			                            <!-- 목록의 세부내역 버튼을 클릭했을 때 나오는 배송지(세부내역) -->
			                            <div class="p-3 pt-2 pb-2 border border-top-0">
			                                <div class="p-2 pt-3 pb-3">
			                                    <h6 class="mb-3">
			                                        배송지 설정
			                                    </h6>
			                                    <!-- 성명 -->
			                                    <div class="row align-items-center pb-2">
			                                        <div class="col-12 col-sm-2">
			                                            성명
			                                        </div>
			                                        <div class="col-12 col-sm-5">
			                                            <input type="text" placeholder="성명" class="form-control">
			                                        </div>
			                                    </div>
			                                    <!-- 배송지 -->
			                                    <div class="row mb-2">
			                                        <label class="form-label col-12 col-sm-2">배송지</label>
			                                        <div class="mb-4 col-12 col-sm-10">
			                                            <div class="form-group">
			                                                <div class="row mb-2">
			                                                    <div class="col-5">
			                                                        <!-- 우편번호. readonly로 되어있으나 풀어도 됩니다 -->
			                                                        <input type="text" class="form-control" id="user_zipcode" value="${gpUserList.gp_zipcode }"placeholder="00000" readonly>
			                                                    </div>
			                                                    <div class="col-7">
			                                                        <!-- 우편번호 찾기 버튼. -->
			                                                        <button type="button" class="btn btn-secondary" onclick="execDaumPostcode()">우편번호 찾기</button>
			                                                    </div>
			                                                </div>
			                                            </div>
			                                            <input type="text" class="form-control mb-2" id="user_zipcode2" placeholder="주소">
			                                            <input type="text" class="form-control" id="user_zipcode3" placeholder="상세 주소">
			                                        </div>
			                                    </div>
			                                    <div class="d-flex justify-content-end">
			                                        <button class="btn btn-sm btn-outline-secondary me-1"><i class="fa-solid fa-gear"></i> 수정하기</button>
			                                    </div>
			                                </div>
			                            </div>
			                            <!-- 세부내역 끝 -->
			                            <!--공동구매 끝-->
			                            </c:forEach>
			                        </div>
                        <!-- =============================================== -->
                        </div>
	<jsp:include page="../common/footer.jsp"/>
</body>
</html>
