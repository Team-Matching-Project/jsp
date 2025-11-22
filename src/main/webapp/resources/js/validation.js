// 상단의 const ... = document.getElementById... 부분은 삭제하세요.
// 이 파일은 순수하게 검사 '규칙'만 가집니다.

export function isNotEmpty(value) {
    return value.trim() !== '';
}
  
export function hasMinLength(value, minLength) {
    return value.length >= minLength;
}
  
export function isEqualToOtherValue(value, otherValue) {
    return value === otherValue;
}

export function isIdValid(value) {
    if (!value || typeof value !== 'string') {
        return false;
    }
    const regExp = /^[a-zA-Z0-9]+$/;
    return regExp.test(value);
}

export function isPasswordValid(value) {
    if (!value || typeof value !== 'string') {
        return false;
    }
    // 특수문자 포함 여부 등 정규식 체크
    const regExp = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_])[a-zA-Z0-9!@#$%^&*?_]{8,20}$/;
    return regExp.test(value);
}