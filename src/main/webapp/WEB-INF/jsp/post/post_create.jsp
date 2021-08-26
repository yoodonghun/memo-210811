<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="/static/css/detail_style.css">
</head>
<body>
<div id="centerBox" class="container">
    <div class="d-flex justify-content-center">
      <input type="text" name="subject" class="inputSubject form-control  mt-3" placeholder="제목을 입력하세요" >
    </div>
    <div class="d-flex justify-content-center">
       <textarea name="content" class="form-control  mt-2" rows="15" cols="100" placeholder="내용을 입력해주세요."></textarea>
    </div>
    <div class="file-upload-btn clearfix">
        <input id="file" type="file" class="float-right mt-2 ml-3" accept=".jpg,.jpeg,.png,.gif">
        
    </div>
    <div class="d-flex justify-content-center mt-3">
        <button type="button" id="listBtn" class="btn btn-dark form-control col-2  mr-2">목록</button>
        <button type="button" id="saveBtn" class="btn btn-info form-control col-2  ">저장</button>
    </div>
</div>    
</body>
</html>

<script>
$(document).ready(function() {
	// 목록 버튼 클릭
	$('#listBtn').on('click', function() {
		location.href="/post/post_list_view";
	});
	
	// 모두 지우기 버튼 클릭
	
	
	// 글 내용 저장
	$('#saveBtn').on('click', function(e) {
		e.preventDefault(); // 기본 이벤트 중단 - 화면이 상단으로 올라가는 현상 제거
		
		var subject = $('input[name=subject]').val().trim(); // 제목만 필수
		console.log(subject);
		if (subject == '') {
			alert("제목을 입력해주세요.");
			return;
		}
		
		var content = $('textarea[name=content]').val();
		console.log(content);
		
		// 파일이 업로드 된 경우 확장자 체크
		var file = $('#file').val();
		if (file != "") {
			console.log(file.split('.')); // 파일명을 . 기준으로 나눈다.
			var ext = file.split('.').pop().toLowerCase(); // 파일명을 .기준으로 나누고, 확장자가 있는 마지막 문자를 가져온 후 모두 소문자로 변경
			if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
				 alert('gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.');
				 $('#file').val(''); // 파일을 비운다.
				 return;
			}
		}
		
		// 폼 태그를 자바스크립트에서 만든다.
		var formData = new FormData();
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]); // $('#file')[0]는 첫번째 input file 태그를 의미, files[0]는 업로드된 첫번째 파일을 의미
		
		// AJAX 통신으로 form에 있는 데이터를 전송한다.
		$.ajax({
			url: '/post/create',
			method: 'POST',
			data: formData,
			enctype: 'multipart/form-data', // 파일 업로드를 위한 필수 설정
			processData: false, 			// 파일 업로드를 위한 필수 설정
            contentType: false, 			// 파일 업로드를 위한 필수 설정
			success: function(data) {
				if (data.result == 'success') {
					alert("메모가 저장되었습니다.");
					location.href = "/post/post_list_view";
				}
			},
			error: function(e) {
				alert("메모 저장에 실패했습니다. 관리자에게 문의해주세요8.");
			}
		});
	});
});
</script>