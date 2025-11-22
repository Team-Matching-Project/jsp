// 1. validation.js에서 필요한 함수 임포트
import { isNotEmpty, isIdValid } from './validation.js'; 

// 2. 요소 선택
const btnIdCheck = document.getElementById("btnIdCheck");
const userIdInput = document.getElementById("userId");
const signupForm = document.querySelector("form");

// 3. 중복확인 통과 여부 상태 변수 (이게 true여야 가입 가능)
let isIdChecked = false; 

// --- [이벤트 1] 중복확인 버튼 클릭 시 ---
btnIdCheck.addEventListener("click", function() {
    const userId = userIdInput.value;

    // 1) 입력값 유효성 검사 (validation.js 활용)
    if (!isNotEmpty(userId)) {
        alert("아이디를 입력해주세요.");
        userIdInput.focus();
        return;
    }
    
    // (선택) 아이디 형식 검사 등 추가 가능

    // 2) 서버로 비동기 요청 (AJAX)
    fetch(`checkIdAction.jsp?userId=${userId}`, {
        method: 'GET',
    })
    // [중요] JSP가 JSON 객체가 아니라 '단순 숫자'만 보내므로 text()로 받음
    .then(response => response.text()) 
    .then(text => {
        // [중요] 공백 제거 후 숫자로 변환 ('1 ' -> 1)
        const result = parseInt(text.trim()); 
        
        console.log("서버 응답 값:", result); // F12 콘솔 확인용

        // 숫자 비교 로직
        if (result === 1) {
            alert("이미 사용 중인 아이디입니다.");
            userIdInput.value = ""; 
            userIdInput.focus();
            isIdChecked = false;
        } else if (result === 0) {
            const useIt = confirm("사용 가능한 아이디입니다. 사용하시겠습니까?");
            if (useIt) {
                userIdInput.setAttribute("readonly", true); // 수정 불가 처리
                btnIdCheck.disabled = true; // 버튼 비활성화
                isIdChecked = true; // ★가입 가능 상태로 변경
            }
        } else if (result === -2) {
            alert("데이터베이스 오류가 발생했습니다. (관리자 문의)");
        } else {
            alert("알 수 없는 오류가 발생했습니다. 다시 시도해주세요.");
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert("서버 통신 중 오류가 발생했습니다.");
    });
    
}); // <--- [여기가 빠져서 에러가 났었습니다] 버튼 이벤트 끝

// --- [이벤트 2] 아이디 입력창 수정 시 상태 초기화 ---
// 사용자가 중복확인 후 아이디를 슬쩍 바꾸면 다시 검사받게 함
userIdInput.addEventListener("input", function() {
    isIdChecked = false; 
    // (선택) 수정하면 다시 버튼 활성화 등을 할 수도 있음
    btnIdCheck.disabled = false;
    userIdInput.removeAttribute("readonly");
});

// --- [이벤트 3] 폼 제출 시 최종 확인 ---
signupForm.addEventListener("submit", function(event) {
    if (!isIdChecked) {
        event.preventDefault(); // 전송 막기
        alert("아이디 중복확인을 해주세요.");
        userIdInput.focus();
    }
    // 여기에 비밀번호 확인 등 다른 유효성 검사 추가 가능
});