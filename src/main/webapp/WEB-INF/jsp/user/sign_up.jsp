<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="m-4">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign_up_for_submit">
			<span class="sign-up-subject">ID</span>
			<%-- 인풋 옆에 중복확인 버튼을 옆에 붙이기 위해 div 만들고 d-flex --%>
			<div class="d-flex ml-3 mt-3">
				<input type="text" name="loginId" class="form-control col-9" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-success ml-2">중복확인</button>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<div class="ml-3 mb-3">
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</div>
			
			<span class="sign-up-subject">Password</span>
			<div class="m-3">
				<input type="password" name="password" class="form-control col-9" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Confirm password</span>
			<div class="m-3">
				<input type="password" name="confirmPassword" class="form-control col-9" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Name</span>
			<div class="m-3">
				<input type="text" name="name" class="form-control col-9" placeholder="이름을 입력하세요">
			</div>

			<span class="sign-up-subject">이메일</span>
			<div class="m-3">
				<input type="text" name="email" class="form-control col-9" placeholder="이메일을 입력하세요">
			</div>
			
			<br>
			<div class="d-flex justify-content-center m-3">
				<button type="button" id="signUpBtn" class="btn btn-info">가입하기</button>
			</div>
		</form>
	</div>
</div>

<script>
$(document).ready(function() {
	// 아이디 중복 확인
	$('#loginIdCheckBtn').on('click', function(e) {
		// validation
		var loginId = $('input[name=loginId]').val().trim();
		// id가 4자 이상이 아니면 경고문구 노출하고 끝낸다.
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none'); // 경고문구 노출
			$('#idCheckDuplicated').addClass('d-none'); // 숨김
			$('#idCheckOk').addClass('d-none'); // 숨김
			return;
		}
		  //중복 확인 여부는 DB를 조회해야 하므로 서버에 묻는다
		  //화면을 이동시키지 않고 AJAX 통신으로 중복 여부 확인하고 동적으로 문구 노출
		  $.ajax({
			  url: "/user/is_duplicated_id"
			  
			  ,data: {"loginId": loginId}
		      ,success: function(data){
		    	  if(data.result == true){ //중복인 경우
		 			 $("#idCheckDuplicated").removeClass("d-none"); //중복 경고 문구
		    		 $("#idCheckLength").addClass("d-none"); //숨김
		 			 $("#idCheckOk").addClass("d-none"); //숨김
		    	  }else{
		    		  //중복이 아닌 경우
		 			 $("#idCheckOk").removeClass("d-none"); //사용가능		    		 
		    		 $("#idCheckLength").addClass("d-none"); //숨김
		    		 $("#idCheckDuplicated").addClass("d-none"); //숨김
		    	  }
		      }, error: function(error){
		    	  alert("아이디 중복 확인에 실패했습니다.")
		      }
		  });
	  });
	  
	  //회원가입 버튼 동작
	  $("#signUpForm").submit(function(e){
		  e.preventDefault(); //서브밋의 기본 동작을 중단
		  
		  //validation
		  let loginId = $('loginId').val().trim();
		  if(loginId = ""){
			  alert("아이디를 입력하세요");
			  return;
		  }
		  
		  let password = $("password").val();
		  let confirmPassword = $("confirmPassword").val();
		  if(password == "" || confirmPassword == ""){
			  alert("비밀번호를 입력하세요");
			  return;
		  }
		  
		  //비밀번호 확인 일치 여부
		  
		  if(password != confirmPassword){
			  alert("비밀번호가 일치하지 않습니다");
			  //텍스트를 초기화한다
			  $("#password").val("");
			  $("#confirmPassword").val("");
			  return;
		  }
		  
		  let name = $("#name").val().trim();
		  if(name = ""){
			  alert("이름을 입력하세요");
			  return;
		  }
		  let email = $("#email").val().trim();
		  if(email = ""){
			  alert("이메일을 입력하세요");
			  return;
		  }
		  
		  //아이디 중복확인이 완료되었는지 확인
		  // idCheckOk -> d-none이 없으면 사용가능한 아이디라고 가정한다
		  if($("#idCheckOk").hasClass("d-none")){
			  alert("아이디 중복확인을 해주세요");
			  return;
		  }
		  
		  //서버로 보내는 방법
		  //1. submit
		  //2. ajax
		  
		  //1 submit : name 속성에 있는 값들이 서버로 넘어간다(requestParam)
		  //$(this)[0].submit();
		  
		  //2 akax
		  let url = '/sign_up_for_ajax';
		  let data = $(this).serialize();
		  //this=signUpForm // form 태그에 name으로 들어있는 input(request param)이 구성된다. 만약 이것을 사용하지 않으면 data json을 임의로 구성해야 한다
		  //console.log(data);
		  
		  $.post(url, data).done(function(data){
			  if(data.result == "success"){
				  alert("회원가입을 환영합니다");
			  }else{
				  alert("회원가입에 실패했습니다. 다시 시도해주세요");
			  }
		  });
	  });
  });
</script>