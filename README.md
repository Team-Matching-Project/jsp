# 🚀 팀 매칭 시스템 (JSP/Servlet 기반)

> 대학생 및 개발자를 위한 프로젝트 팀원 모집 및 지원자 관리 웹 애플리케이션입니다.  
> 학과 수업, 공모전, 부트캠프 등 다양한 목적의 프로젝트에 적합한 팀원을 찾고 관리할 수 있습니다.

<br>

## 📌 1. 프로젝트 개요
* **프로젝트명:** 팀 매칭 시스템 (Team Matching System)
* **개발 언어 및 환경:** Java, JSP/Servlet, HTML5/CSS3
* **아키텍처 스턴트:** MVC Pattern (DTO/DAO 구조 및 JSP 웹 뷰 결합)
* **UI 프레임워크:** Bootstrap 5.3

<br>

## 🛠 2. 사용 기술 스택 (Tech Stack)
* **Backend:** Java, JSP (JavaServer Pages), JSTL (JSP Standard Tag Library)
* **Frontend:** HTML5, CSS3, Bootstrap 5.3 (CDN)
* **Database / Access:** MySQL, DAO/DTO 패턴
* **Architecture:** MVC (Model-View-Controller)

<br>

## ✨ 3. 핵심 기능 (Key Features)

### 👤 1) 회원 관리 (User & Profile)
* **회원가입 (`signup.jsp`):** 아이디 중복 확인, 비밀번호, 생년월일, 학과, 학년, 성별 등 기본 정보 입력
* **로그인/로그아웃 (`login.jsp`):** 세션(`sessionScope.userID`) 기반의 사용자 인증 처리
* **마이페이지 (`mypage.jsp`):** 개인 정보 요약, 보유 기술 스택 태그(Badge) 시각화, 나의 강점 조회
* **개인정보 수정 (`edit_profile.jsp`):** 비밀번호 변경, 학년/학과, 기술 스택 및 자기소개(강점) 수정

### 📋 2) 프로젝트 탐색 및 메인 화면 (`index.jsp`)
* **최신 프로젝트 목록 (`project_list.jsp`):** 프로젝트 제목, 모집 기술 스택, 현재 모집 현황(예: `2 / 5명`), 마감일(D-Day) 요약 제공
* **프로젝트 통계 현황 (`statics.jsp`):** 학과별 현재 모집 중인 프로젝트 수 및 마감 임박 프로젝트 수 시각화
* **커뮤니티 및 안내:** 실시간 공지사항(`notice.jsp`) 및 안전한 팀 매칭을 위한 웹사이트 이용수칙(`rule.jsp`) 제공

### 📝 3) 프로젝트 개설 및 조회
* **프로젝트 등록 (`project_create.jsp`):** 
  * 프로젝트 종류(학과 수업, 부트캠프, 공모전, 개인 프로젝트 등) 설정
  * 모집 마감일, 예상 프로젝트 기간, 총 모집 인원 설정
  * 필요 기술 스택(쉼표 구분) 및 분야별 상세 모집 인원(예: 백엔드 2명, 프론트엔드 1명) 작성
* **프로젝트 상세 보기 (`project_view.jsp`):** 프로젝트 세부 설명, 작성자 정보, 상세 역할별 모집 현황 확인 및 **[지원하기]** 기능

### ⚙️ 4) 지원자 및 팀원 관리 (`manage_applicants.jsp`)
* **개설자 맞춤 관리:** 마이페이지에서 본인이 개설한 프로젝트의 지원자 수를 실시간 배지로 확인
* **승인 대기 지원자 관리:** 지원자의 학과, 학년, 보유 기술, 지원 포부 메시지 검토 후 **[승인] / [거절]** 처리
* **확정 팀원 목록 관리:** 승인이 완료된 최종 팀원 리스트 및 보유 기술 조회

<br>

## 📁 4. 프로젝트 파일 구조 (Project Structure)

```text
src/main
├── java
│   ├── dao
│   │   └── ProjectDAO.java         # 프로젝트 데이터 DB 접근 객체
│   └── dto
│       └── ProjectDTO.java         # 프로젝트 데이터 전송 객체
└── webapp
    ├── META-INF
    │   └── MANIFEST.MF
    ├── edit_profile.jsp            # 개인정보 수정 페이지
    ├── footer.jsp                  # 공통 푸터 (레이아웃)
    ├── header.jsp                  # 공통 네비게이션 바 (레이아웃)
    ├── index.jsp                   # 메인 홈 화면
    ├── login.jsp                   # 로그인 페이지
    ├── manage_applicants.jsp       # 지원자 승인/거절 관리 페이지
    ├── mypage.jsp                  # 사용자 마이페이지
    ├── notice.jsp                  # 공지사항 목록 컴포넌트
    ├── project_create.jsp          # 새 프로젝트 개설 페이지
    ├── project_list.jsp            # 프로젝트 카드 목록 컴포넌트
    ├── project_view.jsp            # 프로젝트 상세 보기 페이지
    ├── rule.jsp                    # 웹사이트 이용 수칙 컴포넌트
    └── statics.jsp                 # 학과별 프로젝트 통계 컴포넌트
