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
$(document).ready(function(){
	$("#listBtn").on("click",function(e){
		location.href="/post/post_list_view";
	});
	
	$("#saveBtn").on("click",function(e){
	 e.preventDefault();
	 
	 
	 
	 
	});
});

</script>